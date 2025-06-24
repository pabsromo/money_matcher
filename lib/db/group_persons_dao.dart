import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'group_persons_dao.g.dart';

@DriftAccessor(tables: [GroupPersons])
class GroupPersonsDao extends DatabaseAccessor<AuthDatabase>
    with _$GroupPersonsDaoMixin {
  GroupPersonsDao(super.db);

  // Create
  Future<void> addPersonToGroup(int groupId, int personId) async {
    final exists = await (select(groupPersons)
          ..where((tbl) =>
              tbl.group_id.equals(groupId) & tbl.person_id.equals(personId)))
        .getSingleOrNull();

    if (exists == null) {
      into(groupPersons).insert(
        GroupPersonsCompanion.insert(
          group_id: groupId,
          person_id: personId,
        ),
      );
    }
  }

  // Read

  // Update

  // Delete
  Future<void> removePersonFromGroup(int groupId, int personId) async {
    await (delete(groupPersons)
          ..where((gp) =>
              gp.group_id.equals(groupId) & gp.person_id.equals(personId)))
        .go();
    // await delete(groupPersons).delete(
    //       groupPersons.where((tbl) =>
    //           tbl.group_id.equals(groupId) & tbl.person_id.equals(personId)),
    //     );
  }
}
