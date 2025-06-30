import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/db/events_dao.dart';
import 'package:money_matcher/db/group_persons_dao.dart';
import 'package:money_matcher/db/groups_dao.dart';
import 'package:money_matcher/db/items_dao.dart';
import 'package:money_matcher/db/item_persons_dao.dart';
import 'package:money_matcher/db/persons_dao.dart';
import 'package:money_matcher/db/tickets_dao.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/manual_entry_screen.dart';
import 'package:money_matcher/features/presentation/edit/screens/groups_screen.dart';
import 'package:money_matcher/features/presentation/summary/screens/ticket_info_screen.dart';

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
  late Person _dropdownValue;
  bool _everythingLoaded = false;

  Ticket? _currTicket;
  late List<Item?> _currItems;
  Group? _chosenGroup;
  late List<Person?> _groupPersons;
  Map<int, List<Person>>? _itemPersons;
  final Set<int> _activePersonIds = {};

  late TicketsDao _ticketsDao;
  late ItemsDao _itemsDao;
  late EventsDao _eventsDao;
  late PersonsDao _personsDao;
  late GroupsDao _groupsDao;
  late GroupPersonsDao _groupPersonsDao;
  late ItemPersonsDao _itemPersonsDao;

  @override
  void initState() {
    super.initState();
    _ticketsDao = TicketsDao(widget.db);
    _itemsDao = ItemsDao(widget.db);
    _eventsDao = EventsDao(widget.db);
    _personsDao = PersonsDao(widget.db);
    _groupsDao = GroupsDao(widget.db);
    _groupPersonsDao = GroupPersonsDao(widget.db);
    _itemPersonsDao = ItemPersonsDao(widget.db);

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

    setState(() {
      _everythingLoaded = true;
    });
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

    _dropdownValue =
        await _personsDao.getPersonById(_currTicket!.primary_payer_id);

    final Map<int, List<Person>> itemPersons = {};
    for (var item in currItems) {
      itemPersons[item.id] = await _itemPersonsDao.getPersonsByItemId(item.id);
    }

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
      _itemPersons = itemPersons;
    });
  }

  void _changeGroup() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                GroupsScreen(db: widget.db, userId: widget.userId)));
  }

  // void _editItems() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) =>)
  // }

  void _done() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => TicketInfoScreen(
                db: widget.db,
                userId: widget.userId,
                eventId: widget.eventId,
                ticketId: widget.ticketId)));
  }

  @override
  Widget build(BuildContext context) {
    if (!_everythingLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
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
                  value: _dropdownValue.nickName,
                  onChanged: (String? newValue) async {
                    if (newValue != null) {
                      final nonNullPersons =
                          _groupPersons.whereType<Person>().toList();

                      if (nonNullPersons.isEmpty) return;

                      final newPerson = nonNullPersons.firstWhere(
                        (p) => p.nickName == newValue,
                        orElse: () => nonNullPersons.first,
                      );

                      await _ticketsDao.updatePrimaryPayer(
                          widget.ticketId, newPerson.id);

                      setState(() {
                        _dropdownValue = newPerson;
                      });
                    }
                  },
                  items: _groupPersons
                      .map<DropdownMenuItem<String>>((Person? person) {
                    return DropdownMenuItem<String>(
                      value: person!.nickName,
                      child: Text(
                        person.nickName,
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
                      children: List.generate(_currItems.length, (index) {
                    return GestureDetector(
                        onTap: () async {
                          final itemId = _currItems[index]!.id;

                          for (var personId in _activePersonIds) {
                            await _itemPersonsDao.addPersonToItem(
                                itemId, personId, 0.00);
                          }

                          final updatedPersons =
                              await _itemPersonsDao.getPersonsByItemId(itemId);

                          final defaultSplitRatio = 1 / updatedPersons.length;

                          _itemPersonsDao.updateSplitRatiosByItemId(
                              itemId, defaultSplitRatio);

                          if (!mounted) return;
                          setState(() {
                            _itemPersons![itemId] = updatedPersons;
                          });
                        },
                        child: Card(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _currItems[index]!.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$${_currItems[index]!.amount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _itemPersons![
                                                    _currItems[index]!.id] !=
                                                null &&
                                            _itemPersons![
                                                    _currItems[index]!.id]!
                                                .isNotEmpty
                                        ? SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: _itemPersons![
                                                      _currItems[index]!.id]!
                                                  .map((person) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 8.0),
                                                        child: GestureDetector(
                                                          onLongPress:
                                                              () async {
                                                            final itemId =
                                                                _currItems[
                                                                        index]!
                                                                    .id;
                                                            await _itemPersonsDao
                                                                .removePersonFromItem(
                                                                    itemId,
                                                                    person.id);
                                                            final updatedPersons =
                                                                await _itemPersonsDao
                                                                    .getPersonsByItemId(
                                                                        itemId);
                                                            if (!mounted)
                                                              return;
                                                            setState(() {
                                                              _itemPersons![
                                                                      itemId] =
                                                                  updatedPersons;
                                                            });

                                                            Fluttertoast
                                                                .showToast(
                                                              msg:
                                                                  '${person.nickName} removed from item.',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .TOP,
                                                              backgroundColor:
                                                                  Colors
                                                                      .black87,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                            );
                                                          },
                                                          child: Chip(
                                                            label: Column(
                                                              children: [
                                                                Text(person
                                                                    .nickName),
                                                                const Text(
                                                                    '100%'), // TODO: dynamic
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          )
                                        : const Text(
                                            'Click person(s) then here to assign'),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Column(
                                      children: [
                                        Icon(Icons.percent),
                                        Text('Adjust')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )));
                  })))),
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
                  _changeGroup();
                  break;
                case 1:
                  // edit items
                  break;
                case 2:
                  // done
                  _done();
                  break;
                default:
              }
            });
          }),
    );
  }
}
