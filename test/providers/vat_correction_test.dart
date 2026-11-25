import 'package:drift/native.dart';
import 'package:florin/db/daos/expense_dao.dart';
import 'package:florin/db/daos/vat_filed_figures_dao.dart';
import 'package:florin/db/database.dart';
import 'package:florin/providers/providers.dart';
import 'package:florin/services/domain.dart';
import 'package:florin/services/vat_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _q1 = (year: 2026, kind: VatFilingPeriod.quarterly, number: 1);
const _q2 = (year: 2026, kind: VatFilingPeriod.quarterly, number: 2);

Future<void> _expense(AppDatabase db, DateTime date, int vat) =>
    ExpenseDao(db).save(
      ExpensesCompanion.insert(
        date: date,
        supplier: 's',
        description: 'd',
        category: ExpenseCategory.software,
        amountExclVat: vat * 100 ~/ 21,
        vatRate: VatRate.high,
        vatAmount: vat,
        totalInclVat: vat * 100 ~/ 21 + vat,
        businessUsePct: 1,
        deductibleAmount: vat * 100 ~/ 21,
        vatReclaimable: true,
        vatToReclaim: vat,
      ),
    );

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
        databaseProvider.overrideWithValue(db),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  Future<VatReturnResult> period(VatPeriod p) async {
    final sub = container.listen(vatPeriodProvider(p), (_, _) {});
    for (var i = 0; i < 50 && !sub.read().hasValue; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
    final value = sub.read().requireValue;
    sub.close();
    return value;
  }

  Future<void> file(VatPeriod p) async {
    final own = await period(p);
    await VatFiledFiguresDao(db).setFiled(
      p,
      filed: true,
      paid: false,
      figures: own.rubrieken,
      carried: own.carriedFrom,
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }

  test('a small change to a filed return is carried into the next one and '
      'settled when that one is filed (Belastingdienst, Btw-aangifte '
      'corrigeren)', () async {
    await _expense(db, DateTime(2026, 2, 1), 2100);
    await file(_q1);
    expect((await period(_q1)).changedSinceFiled, isEmpty);

    await _expense(db, DateTime(2026, 3, 1), 4200);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final q1 = await period(_q1);
    expect(VatService.netVatOf(q1.changedSinceFiled), -4200);
    final q2 = await period(_q2);
    expect(q2.carriedCorrections['5b']?.$2, 4200);
    expect(q2.inputVat5b, 4200);
    expect(q2.carriedFrom.keys, [_q1]);

    await file(_q2);
    expect((await period(_q1)).changedSinceFiled, isEmpty);
  });

  test(
    'a change above EUR 1.000 is not carried: it needs a suppletie',
    () async {
      await file(_q1);
      await _expense(db, DateTime(2026, 3, 1), 150000);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final q1 = await period(_q1);
      expect(q1.changedSinceFiled, isNotEmpty);
      final rules = container.read(taxRulesProvider(2026));
      expect(VatService.fitsNextReturn(q1.changedSinceFiled, rules), isFalse);
      expect((await period(_q2)).carriedCorrections, isEmpty);

      await VatFiledFiguresDao(db).settle(_q1, q1.rubrieken);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect((await period(_q1)).changedSinceFiled, isEmpty);
    },
  );
}
