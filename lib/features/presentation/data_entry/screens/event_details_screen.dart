import 'package:flutter/material.dart';
import '../../../../db/auth_database.dart';
import '../../../../db/users_dao.dart';

class EventDetailsScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;

  const EventDetailsScreen({super.key, required this.db, required this.userId});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameCtrl = TextEditingController();
  final _eventLocationCtrl = TextEditingController();
  final _eventDateCtrl = TextEditingController();
  final _eventTimeCtrl = TextEditingController();
  // groups controller

  late UsersDao _usersDao;

  @override
  void initState() {
    super.initState();
    _usersDao = UsersDao(widget.db);
  }

  String? _errorText;

  Future<void> _next() async {
    if (_formKey.currentState?.validate() ?? false) {
      // final username = _usernameCtrl.text.trim();
      // final password = _passwordCtrl.text;
      // final success =
      //     await widget.usersDao.checkUserCredentials(username, password);

      // if (!mounted) return;

      // if (success) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) =>
      //           HomeScreen(usersDao: widget.usersDao, username: username),
      //     ),
      //   );
      // } else {
      //   setState(() {
      //     _errorText = 'Invalid username or password';
      //   });
      // }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key('eventDetailsScreen'),
        appBar: AppBar(
          title: const Text('New Event Details'),
        ),
        body: Container(
          child: Column(children: [
            if (_errorText != null) ...[
              Text(_errorText!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
            ],
            // DropdownMenu(dropdownMenuEntries: _userGroups)
            TextFormField(
              key: const Key("eventNameInput"),
              controller: _eventNameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (val) => (val == null || val.trim().isEmpty)
                  ? 'Enter event name'
                  : null,
            ),
            TextFormField(
              key: const Key("eventLocationInput"),
              controller: _eventLocationCtrl,
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (val) => (val == null || val.trim().isEmpty)
                  ? 'Enter event location'
                  : null,
            ),
            TextFormField(
              key: const Key("eventDateInput"),
              controller: _eventDateCtrl,
              decoration: const InputDecoration(labelText: 'Date'),
              validator: (val) => (val == null || val.trim().isEmpty)
                  ? 'Enter event date'
                  : null,
            ),
            TextFormField(
              key: const Key("eventTimeInput"),
              controller: _eventTimeCtrl,
              decoration: const InputDecoration(labelText: 'Time'),
              validator: (val) => (val == null || val.trim().isEmpty)
                  ? 'Enter event time'
                  : null,
            ),
            ElevatedButton(
              onPressed: _next,
              key: const Key("nextBtn"),
              child: const Text('Next'),
            ),
          ]),
        ));
  }
}
