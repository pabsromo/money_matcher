import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'item_persons_dao.g.dart';

@DriftAccessor(tables: [ItemPersons])
class ItemPersonsDao extends DatabaseAccessor<AuthDatabase>
    with _$ItemPersonsDaoMixin {
  ItemPersonsDao(super.db);

  // Create
  Future<void> addPersonToItem(
      int itemId, int personId, double splitRatio) async {
    final exists = await (select(itemPersons)
          ..where((ip) =>
              ip.item_id.equals(itemId) & ip.person_id.equals(personId)))
        .getSingleOrNull();

    if (exists == null) {
      into(itemPersons).insert(
        ItemPersonsCompanion.insert(
            item_id: itemId, person_id: personId, splitRatio: splitRatio),
      );
    }
  }

  // Read
  Future<List<Person>> getPersonsByItemId(int itemId) async {
    final query = select(itemPersons).join([
      innerJoin(persons, persons.id.equalsExp(itemPersons.person_id)),
    ])
      ..where(itemPersons.item_id.equals(itemId));

    final results = await query.get();
    return results.map((row) => row.readTable(persons)).toList();
  }

  // Update
  // Future<int> updateSplitRatioById(int id) async {

  // }

  Future<int> updateSplitRatiosByItemId(int itemId, double splitRatio) async {
    return (update(itemPersons)..where((ip) => ip.item_id.equals(itemId)))
        .write(ItemPersonsCompanion(splitRatio: Value(splitRatio)));
  }

  // Delete
  Future<void> removePersonFromItem(int itemId, int personId) async {
    await (delete(itemPersons)
          ..where((ip) =>
              ip.item_id.equals(itemId) & ip.person_id.equals(personId)))
        .go();
  }
}
