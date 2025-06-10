import 'package:flutter/material.dart';
import '../../../../db/users_dao.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  // final AuthDatabase db;
  final UsersDao usersDao;
  final String username;

  const HomeScreen({super.key, required this.usersDao, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("homeScreen"),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => LoginScreen(usersDao: usersDao)),
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
