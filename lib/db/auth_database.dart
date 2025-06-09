import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'tables.dart';
import 'users_dao.dart';

part 'auth_database.g.dart';

// class Users extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get username =>
//       text().withLength(min: 3, max: 32).customConstraint('UNIQUE')();
//   TextColumn get passwordHash => text()();
// }

@DriftDatabase(tables: [Users], daos: [UsersDao])
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
