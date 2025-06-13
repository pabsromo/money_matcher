import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/event_details_screen.dart';
import 'package:money_matcher/features/presentation/edit/screens/groups_screen.dart';
import 'package:money_matcher/features/presentation/edit/screens/settings_screen.dart';
import 'package:money_matcher/features/presentation/history/screens/history_screen.dart';
import '../../../../db/auth_database.dart';
import '../../../../db/users_dao.dart';
import '../../../../db/persons_dao.dart';
import 'login_screen.dart';
import '../../data_entry/screens/scanning_screen.dart';

class HomeScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;
  // final UsersDao usersDao;
  const HomeScreen({super.key, required this.db, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final UsersDao usersDao;
  Person? _userPerson;

  late UsersDao _usersDao;
  late PersonsDao _personsDao;

  @override
  void initState() {
    super.initState();
    _usersDao = UsersDao(widget.db);
    _personsDao = PersonsDao(widget.db);
    _loadMainPerson();
  }

  Future<void> _loadMainPerson() async {
    final person = await _personsDao.getMainPersonByUserId(widget.userId);
    if (mounted) {
      setState(() {
        _userPerson = person;
      });
    }
  }

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
                MaterialPageRoute(builder: (_) => LoginScreen(db: widget.db)),
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
            key: const Key("eventDetailsBtn"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailsScreen(
                    db: widget.db,
                    userId: widget.userId,
                  ),
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
                  builder: (_) =>
                      GroupsScreen(db: widget.db, userId: widget.userId),
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
          // Text('FirstName: ${_userPerson!.firstName}'),
          // Text('LastName: ${_userPerson!.lastName}'),
          // Text('NickName: ${_userPerson!.nickName}'),
          // Text('email: ${_userPerson!.email}'),
        ],
      )),
    );
  }
}
