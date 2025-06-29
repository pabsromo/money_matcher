import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'tickets_dao.g.dart';

@DriftAccessor(tables: [Tickets])
class TicketsDao extends DatabaseAccessor<AuthDatabase> with _$TicketsDaoMixin {
  TicketsDao(super.db);

  // Create
  Future<int?> createEmptyTicket(int eventId) {
    return into(tickets).insert(TicketsCompanion(
      event_id: Value(eventId),
      tipInDollars: const Value.absent(),
      tipInPercent: const Value.absent(),
      tipType: const Value.absent(),
      taxes: const Value.absent(),
      taxType: const Value.absent(),
      subtotal: const Value.absent(),
      total: const Value.absent(),
    ));
  }

  // Read
  Future<Ticket?> getTicketById(int id) {
    return (select(tickets)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<Ticket?> getTicketByEventId(int eventId) {
    return (select(tickets)..where((t) => t.event_id.equals(eventId)))
        .getSingleOrNull();
  }

  // Update
  Future<int> updateSubtotal(int id, double amt) {
    return (update(tickets)..where((t) => t.id.equals(id)))
        .write(TicketsCompanion(subtotal: Value(amt)));
  }

  Future<int> updateTax(int id, double amt) {
    return (update(tickets)..where((t) => t.id.equals(id)))
        .write(TicketsCompanion(taxes: Value(amt)));
  }

  Future<int> updateTipInDollars(int id, double amt) {
    return (update(tickets)..where((t) => t.id.equals(id)))
        .write(TicketsCompanion(tipInDollars: Value(amt)));
  }

  Future<int> updateTipInPercent(int id, double amt) {
    return (update(tickets)..where((t) => t.id.equals(id)))
        .write(TicketsCompanion(tipInPercent: Value(amt)));
  }

  Future<int> updateTipType(int id, String type) {
    return (update(tickets)..where((t) => t.id.equals(id)))
        .write(TicketsCompanion(tipType: Value(type)));
  }

  Future<int> updateTotal(int id, double amt) {
    return (update(tickets)..where((t) => t.id.equals(id)))
        .write(TicketsCompanion(total: Value(amt)));
  }

  Future<int> updateIsScannedById(int id, bool isScanned) {
    return (update(tickets)..where((t) => t.id.equals(id)))
        .write(TicketsCompanion(isScanned: Value(isScanned)));
  }

  // Delete
}
