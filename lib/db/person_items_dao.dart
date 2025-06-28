import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'person_items_dao.g.dart';

@DriftAccessor(tables: [PersonItems])
class PersonItemsDao extends DatabaseAccessor<AuthDatabase>
    with _$PersonItemsDaoMixin {
  PersonItemsDao(super.db);

  // Create

  // Read

  // Update

  // Delete
}
