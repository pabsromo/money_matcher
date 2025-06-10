import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/edit/screens/groups_screen.dart';
import 'package:money_matcher/features/presentation/edit/screens/settings_screen.dart';
import 'package:money_matcher/features/presentation/history/screens/history_screen.dart';
import '../../../../db/users_dao.dart';
import 'login_screen.dart';
import '../../data_entry/screens/scanning_screen.dart';

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
          child: Column(
        children: [
          // TODO: Add scan functionality and state
          TextButton(
            key: const Key("scanScreenBtn"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ScanningScreen(),
                ),
              );
            },
            child: const Text('New Ticket'),
          ),
          // TODO: Add history functionality and state
          TextButton(
            key: const Key("historyBtn"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HistoryScreen(),
                ),
              );
            },
            child: const Text('Past Tickets'),
          ),
          // TODO: Add groups functionality and state
          TextButton(
            key: const Key("groupsBtn"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GroupsScreen(),
                ),
              );
            },
            child: const Text('Groups'),
          ),
          // TODO: Add settings functionality and state
          TextButton(
            key: const Key("settingsBtn"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
            child: const Text('Settings'),
          ),
        ],
      )),
    );
  }
}
