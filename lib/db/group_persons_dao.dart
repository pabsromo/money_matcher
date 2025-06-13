import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'group_persons_dao.g.dart';

@DriftAccessor(tables: [GroupPersons])
class GroupPersonsDao extends DatabaseAccessor<AuthDatabase>
    with _$GroupPersonsDaoMixin {
  GroupPersonsDao(super.db);

  // Create

  // Read
}
