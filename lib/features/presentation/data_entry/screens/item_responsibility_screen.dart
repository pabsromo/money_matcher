import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/db/events_dao.dart';
import 'package:money_matcher/db/group_persons_dao.dart';
import 'package:money_matcher/db/groups_dao.dart';
import 'package:money_matcher/db/items_dao.dart';
import 'package:money_matcher/db/tickets_dao.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class ItemResponsibilityScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;
  final int eventId;
  final int ticketId;

  const ItemResponsibilityScreen(
      {super.key,
      required this.db,
      required this.userId,
      required this.eventId,
      required this.ticketId});

  @override
  State<ItemResponsibilityScreen> createState() =>
      _ItemResponsibilityScreenState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _ItemResponsibilityScreenState extends State<ItemResponsibilityScreen> {
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );
  String dropdownValue = list.first;

  Ticket? _currTicket;
  late List<Item?> _currItems;
  Group? _chosenGroup;
  late List<Person?> _groupPersons;
  final Set<int> _activePersonIds = {};

  late TicketsDao _ticketsDao;
  late ItemsDao _itemsDao;
  late EventsDao _eventsDao;
  late GroupsDao _groupsDao;
  late GroupPersonsDao _groupPersonsDao;

  @override
  void initState() {
    super.initState();
    _ticketsDao = TicketsDao(widget.db);
    _itemsDao = ItemsDao(widget.db);
    _eventsDao = EventsDao(widget.db);
    _groupsDao = GroupsDao(widget.db);
    _groupPersonsDao = GroupPersonsDao(widget.db);

    _initAsync();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initAsync() async {
    await _initializeData();
    if (!mounted) return;

    await _loadData();
  }

  Future<void> _initializeData() async {
    final tempTicket = await _ticketsDao.getTicketById(widget.ticketId);

    setState(
      () {
        _currTicket = tempTicket;
      },
    );
  }

  Future<void> _loadData() async {
    final currItems = await _itemsDao.getItemsByTicketId(widget.ticketId);
    // final currEvent = await _eventsDao.getEventById(widget.eventId);
    final chosenGroup = await _groupsDao.getChosenGroupByUserId(widget.userId);
    final groupPersons =
        await _groupPersonsDao.getPersonsByGroupId(chosenGroup!.id);

    print('------------------------------------------------------------------');
    print('CURRENT ITEMS::');
    print(currItems);
    print('------------------------------------------------------------------');
    print('CHOSEN GROUP::');
    print(chosenGroup);
    print('------------------------------------------------------------------');
    print('GROUP PERSONS::');
    print(groupPersons);

    setState(() {
      _currItems = currItems;
      _chosenGroup = chosenGroup;
      _groupPersons = groupPersons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('itemResponsibilitiesScreen'),
      appBar: AppBar(
        title: const Text('Responsibilities'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Paid By',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    }
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  underline: Container(), // removes default underline
                  isDense: true,
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                      // children: List.generate(),
                      ))),
          Container(
              width: 70,
              child: Column(
                children: List.generate(_groupPersons.length, (index) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              final personId = _groupPersons[index]!.id;
                              if (_activePersonIds.contains(personId)) {
                                _activePersonIds.remove(personId);
                              } else {
                                _activePersonIds.add(personId);
                              }
                            });
                          },
                          child: CircleAvatar(
                              radius: 24,
                              backgroundColor: _activePersonIds
                                      .contains(_groupPersons[index]!.id)
                                  ? Colors.blueAccent
                                  : null,
                              child: Text(_groupPersons[index]!.nickName))));
                }),
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.blueAccent,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.group), label: 'Change Group'),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit), label: 'Edit Items'),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done')
          ],
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  // change group
                  break;
                case 1:
                  // edit items
                  break;
                case 2:
                  // done
                  break;
                default:
              }
            });
          }),
    );
  }
}
