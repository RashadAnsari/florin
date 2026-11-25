import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/vat_filed_figures.dart';
import '../tables/vat_returns.dart';

part 'vat_filed_figures_dao.g.dart';

@DriftAccessor(tables: [VatFiledFigures, VatReturns])
class VatFiledFiguresDao extends DatabaseAccessor<AppDatabase>
    with _$VatFiledFiguresDaoMixin {
  VatFiledFiguresDao(super.db);

  Stream<List<VatFiledFigure>> watchYear(int year) =>
      (select(vatFiledFigures)..where((f) => f.year.equals(year))).watch();

  /// Replaces what is kept as filed for [period] with [figures].
  Future<void> _keep(
    ({int year, VatFilingPeriod kind, int number}) period,
    Map<String, (int, int)> figures,
  ) async {
    await (delete(vatFiledFigures)..where(
          (f) =>
              f.year.equals(period.year) &
              f.kind.equalsValue(period.kind) &
              f.number.equals(period.number),
        ))
        .go();
    await batch(
      (b) => b.insertAll(vatFiledFigures, [
        for (final MapEntry(key: rubriek, value: (base, vat))
            in figures.entries)
          VatFiledFiguresCompanion.insert(
            year: period.year,
            kind: period.kind,
            number: period.number,
            rubriek: rubriek,
            base: base,
            vat: vat,
          ),
      ]),
    );
  }

  /// Marks [period] filed or not. Filing keeps its own [figures] and, for
  /// each earlier period whose correction it carries, that period's
  /// [carried] figures as now settled. Unmarking forgets what was kept for
  /// [period].
  Future<void> setFiled(
    ({int year, VatFilingPeriod kind, int number}) period, {
    required bool filed,
    required bool paid,
    Map<String, (int, int)> figures = const {},
    Map<({int year, VatFilingPeriod kind, int number}), Map<String, (int, int)>>
        carried =
        const {},
  }) => transaction(() async {
    await into(vatReturns).insertOnConflictUpdate(
      VatReturnsCompanion(
        year: Value(period.year),
        kind: Value(period.kind),
        number: Value(period.number),
        filed: Value(filed),
        paid: Value(paid),
      ),
    );
    if (filed) {
      await _keep(period, figures);
      for (final MapEntry(:key, :value) in carried.entries) {
        await _keep(key, value);
      }
    } else {
      await _keep(period, const {});
    }
  });

  /// Records that a correction of [period] was filed with a suppletie: its
  /// figures as they are now count as filed.
  Future<void> settle(
    ({int year, VatFilingPeriod kind, int number}) period,
    Map<String, (int, int)> figures,
  ) => transaction(() => _keep(period, figures));
}
