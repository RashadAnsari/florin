import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/business_profile.dart';

part 'business_profile_dao.g.dart';

@DriftAccessor(tables: [BusinessProfiles])
class BusinessProfileDao extends DatabaseAccessor<AppDatabase>
    with
        _$BusinessProfileDaoMixin,
        Crud<$BusinessProfilesTable, BusinessProfile> {
  BusinessProfileDao(super.db);

  @override
  TableInfo<$BusinessProfilesTable, BusinessProfile> get table =>
      businessProfiles;

  Stream<BusinessProfile?> watch() =>
      select(businessProfiles).watchSingleOrNull();

  Future<BusinessProfile?> get() => select(businessProfiles).getSingleOrNull();
}
