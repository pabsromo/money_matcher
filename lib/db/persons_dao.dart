import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'persons_dao.g.dart';

@DriftAccessor(tables: [Persons, GroupPersons])
class PersonsDao extends DatabaseAccessor<AuthDatabase> with _$PersonsDaoMixin {
  PersonsDao(super.db);

  // Create
  Future<int> createPerson(String? firstName, String? lastName,
      String? nickName, String? email, int? userId, bool isMain) {
    return into(persons).insert(PersonsCompanion(
      firstName: firstName != null ? Value(firstName) : const Value.absent(),
      lastName: lastName != null ? Value(lastName) : const Value.absent(),
      nickName: nickName != null ? Value(nickName) : const Value.absent(),
      email: email != null ? Value(email) : const Value.absent(),
      user_id: Value(userId),
      isMain: Value(isMain),
    ));
  }

  // Read
  Future<Person?> getPersonByUserId(int userId) {
    return (select(persons)..where((p) => p.user_id.equals(userId)))
        .getSingleOrNull();
  }

  Future<Person?> getMainPersonByUserId(int userId) {
    return (select(persons)
          ..where((p) => p.user_id.equals(userId) & p.isMain.equals(true)))
        .getSingleOrNull();
  }

  Future<List<Person>> getPersonsByUserId(int userId) {
    return (select(persons)..where((p) => p.user_id.equals(userId))).get();
  }

  Future<List<Person>> getPersonsByGroupId(int groupId) {
    final query = select(persons).join([
      innerJoin(
        groupPersons,
        groupPersons.person_id.equalsExp(persons.id),
      )
    ])
      ..where(groupPersons.group_id.equals(groupId));

    return query.map((row) => row.readTable(persons)).get();
  }

  // Update
  Future<int> setPersonNicknameById(int id, String nickname) {
    return (update(persons)..where((p) => p.id.equals(id)))
        .write(PersonsCompanion(nickName: Value(nickname)));
  }

  // Delete
  Future<void> deletePersonById(int id) {
    return (delete(persons)..where((p) => p.id.equals(id))).go();
  }
}
