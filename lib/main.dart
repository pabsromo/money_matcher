import 'package:flutter/material.dart';
import 'db/auth_database.dart';
import 'db/users_dao.dart';
import 'features/presentation/auth/pages/login_screen.dart';

void main() {
  final db = AuthDatabase();
  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final AuthDatabase db;
  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    // final usersDao = UsersDao(db);
    return MaterialApp(
      title: 'Money Matcher',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(db: db),
    );
  }
}
