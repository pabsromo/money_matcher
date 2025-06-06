import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'auth_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username =>
      text().withLength(min: 3, max: 32).customConstraint('UNIQUE')();
  TextColumn get passwordHash => text()();
}

@DriftDatabase(tables: [Users])
class AuthDatabase extends _$AuthDatabase {
  AuthDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> createUser(String username, String password) {
    final passwordHash = _hashPassword(password);
    return into(users).insert(UsersCompanion(
      username: Value(username),
      passwordHash: Value(passwordHash),
    ));
  }

  Future<User?> getUserByUsername(String username) {
    return (select(users)..where((u) => u.username.equals(username)))
        .getSingleOrNull();
  }

  Future<bool> checkUserCredentials(String username, String password) async {
    final user = await getUserByUsername(username);
    if (user == null) return false;
    final hashedInput = _hashPassword(password);
    return user.passwordHash == hashedInput;
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'auth_db.sqlite'));
    return NativeDatabase(file);
  });
}
