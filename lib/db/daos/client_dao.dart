import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/clients.dart';

part 'client_dao.g.dart';

@DriftAccessor(tables: [Clients])
class ClientDao extends DatabaseAccessor<AppDatabase> with _$ClientDaoMixin {
  ClientDao(super.db);

  Stream<List<Client>> watchAllActive() =>
      (select(clients)
            ..where((c) => c.isActive.equals(true))
            ..orderBy([(c) => OrderingTerm.asc(c.name)]))
          .watch();

  Future<List<Client>> getAllActive() =>
      (select(clients)
            ..where((c) => c.isActive.equals(true))
            ..orderBy([(c) => OrderingTerm.asc(c.name)]))
          .get();

  Future<List<Client>> getAll() =>
      (select(clients)..orderBy([(c) => OrderingTerm.asc(c.name)])).get();

  Future<Client?> getById(int id) =>
      (select(clients)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<int> insertClient(ClientsCompanion entry) =>
      into(clients).insert(entry);

  Future<bool> saveClient(ClientsCompanion entry) =>
      (update(clients)).replace(entry);

  Stream<List<Client>> watchAll() =>
      (select(clients)..orderBy([(c) => OrderingTerm.asc(c.name)])).watch();

  Future<int> deleteClient(int id) =>
      (delete(clients)..where((c) => c.id.equals(id))).go();
}
