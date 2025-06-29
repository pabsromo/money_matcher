import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'groups_dao.g.dart';

@DriftAccessor(tables: [Groups])
class GroupsDao extends DatabaseAccessor<AuthDatabase> with _$GroupsDaoMixin {
  GroupsDao(super.db);

  // Create
  Future<int> createGroup(String? groupName, int? userId) {
    return into(groups).insert(GroupsCompanion(
      groupName: groupName != null ? Value(groupName) : const Value.absent(),
      user_id: userId != null ? Value(userId) : const Value.absent(),
    ));
  }

  // Read
  Future<List<Group>> getGroupsByUserId(int userId) {
    return (select(groups)..where((g) => g.user_id.equals(userId))).get();
  }

  Future<int?> getChosenGroupByUserId(int userId) async {
    final query = select(groups)
      ..where((g) => g.user_id.equals(userId) & g.isChosenGroup.equals(true))
      ..limit(1);

    final result = await query.getSingleOrNull();
    return result?.id;
  }

  // Update
  Future<int> setGroupNameById(int id, String groupName) {
    return (update(groups)..where((g) => g.id.equals(id)))
        .write(GroupsCompanion(groupName: Value(groupName)));
  }

  Future<int> setChosenGroupById(int? id, bool isChosen) async {
    return (update(groups)..where((g) => g.id.equals(id!)))
        .write(GroupsCompanion(isChosenGroup: Value(isChosen)));
  }

  // Delete
  Future<void> deleteGroup(int id) {
    return (delete(groups)..where((g) => g.id.equals(id))).go();
  }
}
