import 'package:flutter/material.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/db/events_dao.dart';
import 'package:money_matcher/db/group_persons_dao.dart';
import 'package:money_matcher/db/groups_dao.dart';
import 'package:money_matcher/db/item_persons_dao.dart';
import 'package:money_matcher/db/items_dao.dart';
import 'package:money_matcher/db/persons_dao.dart';
import 'package:money_matcher/db/tickets_dao.dart';

class TicketInfoScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;
  final int eventId;
  final int ticketId;

  const TicketInfoScreen({
    super.key,
    required this.db,
    required this.userId,
    required this.eventId,
    required this.ticketId,
  });

  @override
  State<TicketInfoScreen> createState() => _TicketInfoScreenState();
}

class _TicketInfoScreenState extends State<TicketInfoScreen> {
  bool _everythingLoaded = false;

  late Ticket _currTicket;
  late Event? _currEvent;
  late List<Person> _ticketPersons;
  Map<int, List<Item>>? _personItems;
  Map<String, double>? _splitRatios;
  Map<int, double>? _personTotals;

  late EventsDao _eventsDao;
  late TicketsDao _ticketsDao;
  late ItemsDao _itemsDao;
  late PersonsDao _personsDao;
  late GroupsDao _groupsDao;
  late GroupPersonsDao _groupPersonsDao;
  late ItemPersonsDao _itemPersonsDao;

  @override
  void initState() {
    super.initState();
    _eventsDao = EventsDao(widget.db);
    _ticketsDao = TicketsDao(widget.db);
    _itemsDao = ItemsDao(widget.db);
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
    if (!mounted) return;

    await _loadData();

    setState(() {
      _everythingLoaded = true;
    });
  }

  Future<void> _loadData() async {
    final currTicket = await _ticketsDao.getTicketById(widget.ticketId);
    final currEvent = await _eventsDao.getEventById(currTicket!.event_id);

    // get current persons
    final ticketPersons =
        await _personsDao.getPersonsByGroupId(currEvent!.group_id!);

    // get items per person
    final currItems = await _itemsDao.getItemsByTicketId(widget.ticketId);
    final Map<int, List<Person>> itemPersons = {};
    for (var item in currItems) {
      itemPersons[item.id] = await _itemPersonsDao.getPersonsByItemId(item.id);
    }
    final Map<int, List<Item>> personItems = {};
    for (var item in currItems) {
      final persons = itemPersons[item.id] ?? [];
      for (var person in persons) {
        personItems.putIfAbsent(person.id, () => []);
        personItems[person.id]!.add(item);
      }
    }

    // get splitRatios for item person pairs
    final Map<String, double> splitRatios = {};
    for (var item in currItems) {
      for (var person in itemPersons[item.id]!) {
        final splitRatio = await _itemPersonsDao
            .getSplitRatioByItemIdAndPersonId(item.id, person.id);
        splitRatios['${item.id}:${person.id}'] = splitRatio;
      }
    }

    // calcualte person totals
    final Map<int, double> personTotals = {};
    for (var person in ticketPersons) {
      double amt = 0;
      for (var item in personItems[person.id]!) {
        amt = amt + item.amount * splitRatios['${item.id}:${person.id}']!;
      }
      personTotals[person.id] = amt;
    }

    setState(() {
      _currEvent = currEvent;
      _currTicket = currTicket;
      _ticketPersons = ticketPersons;
      _personItems = personItems;
      _splitRatios = splitRatios;
      _personTotals = personTotals;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_everythingLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      key: const Key('ticketInfoScreen'),
      appBar: AppBar(title: const Text('Summary'), actions: [
        Row(
          children: [
            TextButton.icon(
              label: Text('Export'),
              icon: const Icon(Icons.outbox),
              onPressed: () {},
            ),
            TextButton.icon(
              label: Text('Send'),
              icon: const Icon(Icons.share),
              onPressed: () {},
            )
          ],
        )
      ]),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  // Event Name Text Field
                  // Event Location Text Field
                  // Date input field
                ],
              ),
              Column(
                children: [
                  // Status Badge
                  // Paid By selection Dropdown
                ],
              )
            ],
          ),
          SingleChildScrollView(
              // Person list
              child: Column(
            children: List.generate(_ticketPersons.length, (index) {
              final ticketPerson = _ticketPersons[index];
              return Card(
                child: Column(children: [
                  Row(
                    children: [
                      Text(ticketPerson.nickName),
                      Text('Paid Ticket'),
                    ],
                  ),
                  Column(children: [
                    Column(
                        children: List.generate(
                            _personItems![_ticketPersons[index].id]!.length,
                            (jindex) {
                      final personId = _ticketPersons[index].id;
                      final items = _personItems![personId];
                      final currItem = items![jindex];
                      final ratio = _splitRatios!['${currItem.id}:$personId'];
                      final amt = currItem.amount * ratio!;

                      return Row(children: [
                        Text(currItem.name),
                        Text('.....${ratio.toStringAsFixed(2)}%'),
                        Text('........\$'),
                        Text(amt.toStringAsFixed(2))
                      ]);
                    })),
                    Text(
                        'Total: \$${_personTotals?[ticketPerson.id]!.toStringAsFixed(2)}')
                  ]),
                ]),
              );
            }),
          )
              // Floating button to Edit Items
              ),
          Row(
              // Subtotal
              // Tax
              // Tip - Only thing that can be edited here
              // Total
              )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.image_sharp), label: 'Open/Add Images'),
        const BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done')
      ]),
    );
  }
}
