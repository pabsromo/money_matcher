import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'tables.dart';
import 'users_dao.dart';
import 'groups_dao.dart';
import 'persons_dao.dart';
import 'events_dao.dart';
import 'images_dao.dart';
import 'tickets_dao.dart';
import 'items_dao.dart';
import 'person_items_dao.dart';

part 'auth_database.g.dart';

@DriftDatabase(tables: [
  Users,
  Groups,
  Persons,
  GroupPersons,
  Events,
  Images,
  Tickets,
  Items,
  PersonItems
], daos: [
  UsersDao,
  PersonsDao,
  GroupsDao,
  EventsDao,
  ImagesDao,
  TicketsDao,
  ItemsDao,
  PersonItemsDao
])
class AuthDatabase extends _$AuthDatabase {
  AuthDatabase() : super(_openConnection());

  AuthDatabase.custom(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
      );
  // @override
  // MigrationStrategy get migration => MigrationStrategy(
  //       onCreate: (m) => m.createAll(),
  //       onUpgrade: (m, from, to) async {
  //         // Add custom migrations here if needed later
  //       },
  //     );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'auth_db.sqlite'));
    return NativeDatabase(file);
  });
}
