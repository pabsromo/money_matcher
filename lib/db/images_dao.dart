import 'package:drift/drift.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'images_dao.g.dart';

@DriftAccessor(tables: [Images])
class ImagesDao extends DatabaseAccessor<AuthDatabase> with _$ImagesDaoMixin {
  ImagesDao(super.db);

  // Create
  Future<int> createImage(String imagePath, int eventId) {
    return into(images).insert(
        ImagesCompanion(imagePath: Value(imagePath), event_id: Value(eventId)));
  }

  // Read
  Future<List<Image>> getEventImages(int eventId) {
    return (select(images)..where((i) => i.event_id.equals(eventId))).get();
  }

  // Update

  // Delete
  Future<void> deleteImagesOfEvent(int eventId) {
    return (delete(images)..where((i) => i.event_id.equals(eventId))).go();
  }
}
