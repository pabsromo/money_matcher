import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_matcher/db/events_dao.dart';
import 'package:money_matcher/db/groups_dao.dart';
import 'package:money_matcher/db/persons_dao.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/scanning_screen.dart';
import 'package:money_matcher/features/presentation/edit/screens/groups_screen.dart';
import '../../../../db/auth_database.dart';

class EventDetailsScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;

  const EventDetailsScreen({super.key, required this.db, required this.userId});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Group? _chosenGroup;
  List<Person>? _groupPersons;
  final _formKey = GlobalKey<FormState>();
  final _eventNameCtrl = TextEditingController();
  final _eventLocationCtrl = TextEditingController();
  final _eventDateCtrl = TextEditingController();
  // final _eventTimeCtrl = TextEditingController();

  Event? _currEvent;

  late GroupsDao _groupsDao;
  late PersonsDao _personsDao;
  late EventsDao _eventsDao;

  // ignore: unused_field
  bool _isLoading = true;
  String? _errorText;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _groupsDao = GroupsDao(widget.db);
    _personsDao = PersonsDao(widget.db);
    _eventsDao = EventsDao(widget.db);
    _initializeData();
  }

  Future<void> _initializeData() async {
    setState(() => _isLoading = true);

    await _loadChosenGroup();

    Event? currEvent;

    // find event that has isEditing if possible for user
    currEvent = await _eventsDao.getEditingEventByUserId(widget.userId);

    if (currEvent == null) {
      final currEventId = await _eventsDao.createEmptyEvent(widget.userId);
      await _eventsDao.setAllIsEditingByUserId(widget.userId, false);
      await _eventsDao.setEditingById(currEventId, true);
      currEvent = await _eventsDao.getEventById(currEventId);
    }

    setState(() {
      _isLoading = false;
      _errorText = null;
      _currEvent = currEvent;
      _eventNameCtrl.text = _currEvent!.eventName;
      _eventLocationCtrl.text = _currEvent!.location;
      _selectedDate = _currEvent!.date;
      if (_selectedDate != null) {
        _eventDateCtrl.text = formatDateWithSuffix(_selectedDate!);
      }
    });
  }

  Future<void> _loadChosenGroup() async {
    final userGroups = await _groupsDao.getGroupsByUserId(widget.userId);

    final chosen = userGroups.where((g) => g.isChosenGroup).isNotEmpty
        ? userGroups.firstWhere((g) => g.isChosenGroup)
        : null;

    final persons = chosen != null
        ? await _personsDao.getPersonsByGroupId(chosen.id)
        : <Person>[];

    setState(() {
      _chosenGroup = chosen;
      _groupPersons = persons;
      _errorText = null;
    });
  }

  Future<void> _next() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool needsPersons;
      final eventName = _eventNameCtrl.text.trim();
      final location = _eventLocationCtrl.text.trim();
      final date = _selectedDate;

      _groupPersons!.isEmpty || _groupPersons == null
          ? needsPersons = true
          : needsPersons = false;

      if (!mounted) return;

      if (_chosenGroup == null) {
        setState(() {
          _errorText = 'You need to choose a Group for the Event';
        });
      } else if (needsPersons) {
        setState(() {
          _errorText = 'Chosen Group needs Persons';
        });
      } else {
        // _eventsDao.createEvent(eventName, location, date);
        _eventsDao.setEventById(
            _currEvent!.id, eventName, location, date, _chosenGroup!.id, true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ScanningScreen(db: widget.db, userId: widget.userId),
          ),
        );
      }
    }
  }

  Future<void> _exitScreen() async {
    final eventName = _eventNameCtrl.text.trim();
    final location = _eventLocationCtrl.text.trim();
    final date = _selectedDate;
    final groupId = _chosenGroup?.id;

    if (_currEvent != null) {
      if (eventName == '' && location == '' && date == null) {
        await _eventsDao.deleteEventById(_currEvent!.id);
        // delete associated images as well
      } else {
        if (_chosenGroup == null) {}
        await _eventsDao.setEventById(
            _currEvent!.id, eventName, location, date, groupId, false);
      }
    }
  }

  String formatDateWithSuffix(DateTime date) {
    final day = date.day;
    final suffix = (day >= 11 && day <= 13)
        ? 'th'
        : {
              1: 'st',
              2: 'nd',
              3: 'rd',
            }[day % 10] ??
            'th';

    final formatted = DateFormat('EEEE, MMMM d').format(date);
    return '$formatted$suffix ${date.year}'; // e.g., "Wednesday, June 26th 2025"
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) {
            await _exitScreen();
          }
        },
        child: Scaffold(
            key: const Key('eventDetailsScreen'),
            appBar: AppBar(
              title: const Text('Groups'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(
                      context, true); // Return true to signal data was updated
                },
              ),
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                if (_errorText != null) ...[
                  Text(_errorText!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                ],
                Card(
                  key: const Key('chosenGroupCard'),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                                child: _chosenGroup != null
                                    ? Text(
                                        key: const Key('chosenGroupText'),
                                        'Group: ${_chosenGroup!.groupName}')
                                    : const Text(
                                        key: Key('chosenGroupText'),
                                        'No Group Selected')),
                            IconButton(
                                key: const Key('editGroupIcon'),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => GroupsScreen(
                                              db: widget.db,
                                              userId: widget.userId)));
                                  if (result == true) {
                                    await _loadChosenGroup();
                                  }
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              key: const Key('chipWrap'),
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: _groupPersons != null
                                  ? _groupPersons!.map((person) {
                                      return Chip(
                                        key: Key("${person.nickName}_chip"),
                                        label: Text(person.nickName),
                                      );
                                    }).toList()
                                  : List.empty(),
                            )),
                      )
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                        decoration:
                            const InputDecoration(labelText: 'Location'),
                        validator: (val) => (val == null || val.trim().isEmpty)
                            ? 'Enter event location'
                            : null,
                      ),
                      TextFormField(
                        key: const Key("eventDateInput"),
                        controller: _eventDateCtrl,
                        decoration: const InputDecoration(labelText: 'Date'),
                        // keyboardType: TextInputType.none,
                        // readOnly: true,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());

                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate ?? now,
                            firstDate: DateTime(now.year - 5),
                            lastDate: DateTime(now.year + 5),
                          );
                          if (picked != null) {
                            setState(() {
                              _selectedDate = picked;
                              _eventDateCtrl.text =
                                  formatDateWithSuffix(picked);
                            });
                          }
                        },
                        validator: (val) => (_selectedDate == null)
                            ? 'Choose an event date'
                            : null,
                      ),
                      ElevatedButton(
                        key: const Key('doneBtn'),
                        onPressed: _next,
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                )
              ]),
            ))));
  }
}
