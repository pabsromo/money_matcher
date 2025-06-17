import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'events_dao.g.dart';

@DriftAccessor(tables: [Events])
class EventsDao extends DatabaseAccessor<AuthDatabase> with _$EventsDaoMixin {
  EventsDao(super.db);

  // Create
  Future<int> createEvent(String? eventName, String? location, DateTime? date) {
    return into(events).insert(EventsCompanion(
      eventName: eventName != null ? Value(eventName) : const Value.absent(),
      location: location != null ? Value(location) : const Value.absent(),
      date: date != null ? Value(date) : const Value.absent(),
    ));
  }

  Future<int> createEmptyEvent(int userId) {
    return into(events).insert(EventsCompanion(
      eventName: const Value(''),
      location: const Value(""),
      date: const Value.absent(),
      user_id: Value(userId),
    ));
  }

  // Read
  Future<Event?> getEventById(int id) {
    return (select(events)..where((e) => e.id.equals(id))).getSingleOrNull();
  }

  Future<Event?> getEditingEventByUserId(int userId) {
    return (select(events)
          ..where((e) => e.user_id.equals(userId) & e.isEditing.equals(true)))
        .getSingleOrNull();
  }

  // Update
  Future<int> setEventById(int id, String eventName, String eventLocation,
      DateTime? date, int groupId, bool isEditingValue) {
    return (update(events)..where((e) => e.id.equals(id))).write(
        EventsCompanion(
            eventName: Value(eventName),
            location: Value(eventLocation),
            date: Value(date!),
            group_id: Value(groupId),
            isEditing: Value(isEditingValue)));
  }

  Future<int> setEditingById(int id, bool isEditingValue) {
    return (update(events)..where((e) => e.id.equals(id)))
        .write(EventsCompanion(isEditing: Value(isEditingValue)));
  }

  Future<int> setAllIsEditingByUserId(int userId, bool isEditingValue) {
    return (update(events)..where((e) => e.user_id.equals(userId))).write(
      EventsCompanion(
        isEditing: Value(isEditingValue),
      ),
    );
  }

  // Delete
  Future<void> deleteEventById(int id) {
    return (delete(events)..where((e) => e.id.equals(id))).go();
  }
}
