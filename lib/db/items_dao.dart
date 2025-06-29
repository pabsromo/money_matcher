import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'items_dao.g.dart';

@DriftAccessor(tables: [Items])
class ItemsDao extends DatabaseAccessor<AuthDatabase> with _$ItemsDaoMixin {
  ItemsDao(super.db);

  // Create
  Future<int> createItem(
      int ticketId, String name, double amt, String? currency) {
    return into(items).insert(ItemsCompanion(
      ticket_id: Value(ticketId),
      name: Value(name),
      amount: Value(amt),
      currency: currency != null ? Value(currency) : const Value.absent(),
    ));
  }

  // Read
  Future<List<Item>> getItemsByTicketId(int ticketId) {
    return (select(items)..where((i) => i.ticket_id.equals(ticketId))).get();
  }

  // Update
  Future<int> updateItemNameById(int id, String name) {
    return (update(items)..where((i) => i.id.equals(id)))
        .write(ItemsCompanion(name: Value(name)));
  }

  Future<int> updateItemAmtById(int id, double amt) {
    return (update(items)..where((i) => i.id.equals(id)))
        .write(ItemsCompanion(amount: Value(amt)));
  }

  // Delete
  Future<void> deleteItem(int id) {
    return (delete(items)..where((i) => i.id.equals(id))).go();
  }
}
