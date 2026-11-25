import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/clients.dart';
import '../tables/hour_entries.dart';
import '../tables/invoices.dart';

part 'client_dao.g.dart';

@DriftAccessor(tables: [Clients, Invoices, HourEntries])
class ClientDao extends DatabaseAccessor<AppDatabase>
    with _$ClientDaoMixin, Crud<$ClientsTable, Client> {
  ClientDao(super.db);

  @override
  TableInfo<$ClientsTable, Client> get table => clients;

  Stream<List<Client>> watchAll() =>
      (select(clients)..orderBy([(c) => OrderingTerm.asc(c.name)])).watch();

  Future<Client?> getById(int id) =>
      (select(clients)..where((c) => c.id.equals(id))).getSingleOrNull();

  /// Whether invoices or hours refer to the client, which then cannot be
  /// deleted.
  Future<bool> isReferenced(int clientId) async =>
      await (select(invoices)
                ..where((i) => i.clientId.equals(clientId))
                ..limit(1))
              .getSingleOrNull() !=
          null ||
      await (select(hourEntries)
                ..where((h) => h.clientId.equals(clientId))
                ..limit(1))
              .getSingleOrNull() !=
          null;
}
