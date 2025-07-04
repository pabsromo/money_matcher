import 'package:flutter/material.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/db/events_dao.dart';
import 'package:money_matcher/db/group_persons_dao.dart';
import 'package:money_matcher/db/groups_dao.dart';
import 'package:money_matcher/db/item_persons_dao.dart';
import 'package:money_matcher/db/items_dao.dart';
import 'package:money_matcher/db/persons_dao.dart';
import 'package:money_matcher/db/tickets_dao.dart';
import 'package:money_matcher/features/presentation/data_entry/widgets/double_editing_controller.dart';
import 'package:money_matcher/features/presentation/data_entry/widgets/double_text_field.dart';

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

  late DoubleEditingController _taxAmtController;
  late DoubleEditingController _tipAmtController;

  late FocusNode _taxAmtFocusNode;
  late FocusNode _tipAmtFocusNode;

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
    _taxAmtController.dispose();
    _tipAmtController.dispose();
    _taxAmtFocusNode.dispose();
    _tipAmtFocusNode.dispose();
    super.dispose();
  }

  Future<void> _initAsync() async {
    if (!mounted) return;

    await _loadData();

    await _initControllers();

    setState(() {
      _everythingLoaded = true;
    });
  }

  Future<void> _loadData() async {
    Ticket? currTicket = await _ticketsDao.getTicketById(widget.ticketId);
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

    // Calculations
    final subtotal = await _calculateSubtotal(currItems);
    double tip = currTicket.tipInDollars;
    if (currTicket.tipType == 'percent') {
      tip = await _calculateTip(subtotal, currTicket.tipInPercent);
    }
    final total = await _calculateTotal(subtotal, currTicket.taxes, tip);

    await _ticketsDao.updateSubtotal(widget.ticketId, subtotal);
    await _ticketsDao.updateTipInDollars(widget.ticketId, tip);
    await _ticketsDao.updateTotal(widget.ticketId, total);

    currTicket = await _ticketsDao.getTicketById(widget.ticketId);

    setState(() {
      _currEvent = currEvent;
      _currTicket = currTicket!;
      _ticketPersons = ticketPersons;
      _personItems = personItems;
      _splitRatios = splitRatios;
      _personTotals = personTotals;
    });

    // await _updateControllerValues();
  }

  // TODO: Initialize controllers and focus nodes
  Future<void> _initControllers() async {
    if (!mounted) return;

    // Controller Setting
    _taxAmtController = DoubleEditingController(value: _currTicket.taxes);
    _tipAmtController =
        DoubleEditingController(value: _currTicket.tipInDollars);

    final taxAmtFocusNode = FocusNode();
    final tipAmtFocusNode = FocusNode();

    taxAmtFocusNode.addListener(() async {
      if (!taxAmtFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          final newAmt = _taxAmtController.doubleValue;
          if (newAmt != null) {
            await _ticketsDao.updateTax(_currTicket.id, newAmt);
            await _loadData();
            await _updateControllerValues();
          }
        });
      }
    });

    tipAmtFocusNode.addListener(() async {
      if (!tipAmtFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          final newAmt = _tipAmtController.doubleValue;
          if (newAmt != null) {
            if (_currTicket.tipType == 'percent') {
              await _ticketsDao.updateTipInPercent(_currTicket.id, newAmt);
              await _loadData();
              await _updateControllerValues();
            } else {
              await _ticketsDao.updateTipInDollars(_currTicket.id, newAmt);
              await _loadData();
              await _updateControllerValues();
            }
          }
        });
      }
    });

    _taxAmtFocusNode = taxAmtFocusNode;
    _tipAmtFocusNode = tipAmtFocusNode;
  }

  Future<void> _updateControllerValues() async {
    setState(() {
      _taxAmtController.text = _currTicket.taxes.toStringAsFixed(2);
      _tipAmtController.text = _currTicket.tipInDollars.toStringAsFixed(2);
    });
  }

  Future<double> _calculateSubtotal(List<Item> items) async {
    double calculatedSubtotal = 0;
    for (var item in items) {
      calculatedSubtotal += item.amount;
    }
    return calculatedSubtotal;
  }

  Future<double> _calculateTotal(
      double subtotal, double taxes, double tip) async {
    return subtotal + taxes + tip;
  }

  Future<double> _calculateTip(double subtotal, double tip) async {
    return subtotal * tip / 100;
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
              label: const Text('Export'),
              icon: const Icon(Icons.outbox),
              onPressed: () {},
            ),
            TextButton.icon(
              label: const Text('Send'),
              icon: const Icon(Icons.share),
              onPressed: () {},
            )
          ],
        )
      ]),
      body: Column(
        children: [
          const Row(
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
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(_ticketPersons.length, (index) {
                  final ticketPerson = _ticketPersons[index];
                  final personId = ticketPerson.id;
                  final items = _personItems![personId]!;
                  final taxPerPerson = _currTicket.taxes / _personItems!.length;
                  final tipPerPerson =
                      _currTicket.tipInDollars / _personItems!.length;
                  final total =
                      _personTotals![personId]! + taxPerPerson + tipPerPerson;

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top row with nickname and "Paid Ticket"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ticketPerson.nickName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text('Paid Ticket'),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Table-like layout of item rows
                          Column(
                            children: List.generate(items.length, (jindex) {
                              final currItem = items[jindex];
                              final ratio =
                                  _splitRatios!['${currItem.id}:$personId'];
                              final amt = currItem.amount * ratio!;

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(currItem.name),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          '${(ratio * 100).toStringAsFixed(2)}%'),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '\$${amt.toStringAsFixed(2)}',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 12),
                          const Divider(),

                          // Total aligned bottom right
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Column(children: [
                              Text(
                                'Tax: \$${taxPerPerson.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Tip: \$${tipPerPerson.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Total: \$${total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4EA), // soft forest green background
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF374151), // same red as the text
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151), // pastel red text
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: Text(
                          '\$${_currTicket.subtotal.toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF374151), // same red as the text
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Taxes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151), // pastel red text
                          ),
                        ),
                      ),
                      DoubleTextField(
                        controller: _taxAmtController,
                        focusNode: _taxAmtFocusNode,
                        normalPrefix: '\$',
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 2),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(
                                        0xFF374151), // same red as the text
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Tip(notax)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF374151), // pastel red text
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final tipMode = _currTicket.tipType == 'dollar'
                                  ? 'percent'
                                  : 'dollar';
                              await _ticketsDao.updateTipType(
                                  _currTicket.id, tipMode);
                              await _ticketsDao.updateTipInDollars(
                                  _currTicket.id, 0);
                              await _ticketsDao.updateTipInPercent(
                                  _currTicket.id, 0);
                              await _loadData();
                              await _updateControllerValues();
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _currTicket.tipType == 'dollar' ? '\$' : '%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      DoubleTextField(
                        controller: _tipAmtController,
                        focusNode: _tipAmtFocusNode,
                        labelText: '',
                        amt: _currTicket.tipInPercent,
                        tipType: _currTicket.tipType,
                        normalPrefix: '\$',
                        focusedPrefix: _currTicket.tipType == 'dollar'
                            ? '\$'
                            : '%', // or some dynamic value
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFFFEBEB), // softer red for total section
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 2),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    Color(0xFFB91C1C), // same red as the text
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Full Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB91C1C), // pastel red text
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Text(
                            '\$${_currTicket.total.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.image_sharp), label: 'Open/Add Images'),
        BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done')
      ]),
    );
  }
}
