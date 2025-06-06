import 'package:flutter/material.dart';
import '../../../../db/auth_database.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthDatabase db;
  final String username;

  const HomeScreen({super.key, required this.db, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen(db: db)),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: Center(
        child:
            Text('Welcome, $username!', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
