import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/clients.dart';
import '../tables/invoices.dart';

part 'client_dao.g.dart';

@DriftAccessor(tables: [Clients, Invoices])
class ClientDao extends DatabaseAccessor<AppDatabase>
    with _$ClientDaoMixin, Crud<$ClientsTable, Client> {
  ClientDao(super.db);

  @override
  TableInfo<$ClientsTable, Client> get table => clients;

  Stream<List<Client>> watchAll() =>
      (select(clients)..orderBy([(c) => OrderingTerm.asc(c.name)])).watch();

  Future<Client?> getById(int id) =>
      (select(clients)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<bool> hasInvoices(int clientId) async =>
      await (select(invoices)
            ..where((i) => i.clientId.equals(clientId))
            ..limit(1))
          .getSingleOrNull() !=
      null;
}
