import 'package:drift/drift.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'tables.dart';
import 'auth_database.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AuthDatabase> with _$UsersDaoMixin {
  UsersDao(super.db);

  // Create
  Future<int> createUser(String username, String email, String password) {
    return into(users).insert(UsersCompanion(
      username: Value(username),
      email: Value(email),
      passwordHash: Value(hashPassword(password)),
    ));
  }

  // Read
  Future<User?> getUserByUsername(String username) {
    return (select(users)..where((u) => u.username.equals(username)))
        .getSingleOrNull();
  }

  Future<User?> getUserByEmail(String email) {
    return (select(users)..where((u) => u.email.equals(email)))
        .getSingleOrNull();
  }

  // Update
  Future<int> updatePassword(int userId, String newPasswordHash) {
    return (update(users)..where((u) => u.id.equals(userId))).write(
      UsersCompanion(passwordHash: Value(newPasswordHash)),
    );
  }

  // Delete
  Future<int> deleteUser(int userId) {
    return (delete(users)..where((u) => u.id.equals(userId))).go();
  }

  Future<void> deleteAll() {
    return delete(users).go();
  }

  // List all
  Future<List<User>> getAllUsers() => select(users).get();

  Future<bool> checkUserCredentials(String username, String password) async {
    final user = await getUserByUsername(username);
    if (user == null) return false;
    final hashedInput = hashPassword(password);
    return user.passwordHash == hashedInput;
  }

  // Helper Methods
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
