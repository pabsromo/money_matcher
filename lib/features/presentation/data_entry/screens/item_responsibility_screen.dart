import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/db/group_persons_dao.dart';
import 'package:money_matcher/db/groups_dao.dart';
import 'package:money_matcher/db/items_dao.dart';
import 'package:money_matcher/db/item_persons_dao.dart';
import 'package:money_matcher/features/presentation/data_entry/widgets/animated_bottom_nav_bar.dart';
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
  bool _everythingLoaded = false;

  late List<Item?> _currItems;
  late List<Person?> _groupPersons;
  Map<int, List<Person>>? _itemPersons;
  final Set<int> _activePersonIds = {};

  late ItemsDao _itemsDao;
  late GroupsDao _groupsDao;
  late GroupPersonsDao _groupPersonsDao;
  late ItemPersonsDao _itemPersonsDao;

  @override
  void initState() {
    super.initState();
    _itemsDao = ItemsDao(widget.db);
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
    final currItems = await _itemsDao.getItemsByTicketId(widget.ticketId);
    final chosenGroup = await _groupsDao.getChosenGroupByUserId(widget.userId);
    final groupPersons =
        await _groupPersonsDao.getPersonsByGroupId(chosenGroup!.id);

    final Map<int, List<Person>> itemPersons = {};
    for (var item in currItems) {
      itemPersons[item.id] = await _itemPersonsDao.getPersonsByItemId(item.id);
    }

    setState(() {
      _currItems = currItems;
      _groupPersons = groupPersons;
      _itemPersons = itemPersons;
    });
  }

  String _calculateResponsibilityPercent(Person person, Item? item) {
    final personCount = _itemPersons![item!.id]!.length;
    final personPercent = (1 / personCount) * 100;
    return '${personPercent.toStringAsFixed(0)}%';
  }

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
        // actions: [
        //   Container(
        //       decoration: BoxDecoration(
        //           color: const Color.fromARGB(255, 245, 245, 105)),
        //       child: Padding(
        //           padding: const EdgeInsets.only(right: 8.0),
        //           child: Text('Paid By:',
        //               style:
        //                   TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
        //       // child: Column(
        //       //   mainAxisAlignment: MainAxisAlignment.center,
        //       //   children: [
        //       //     // const Text('Paid By',
        //       //     //     style:
        //       //     //         TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        //       //     // DropdownButton<String>(
        //       //     //   value: _dropdownValue.nickName,
        //       //     //   onChanged: (String? newValue) async {
        //       //     //     if (newValue != null) {
        //       //     //       final nonNullPersons =
        //       //     //           _groupPersons.whereType<Person>().toList();

        //       //     //       if (nonNullPersons.isEmpty) return;

        //       //     //       final newPerson = nonNullPersons.firstWhere(
        //       //     //         (p) => p.nickName == newValue,
        //       //     //         orElse: () => nonNullPersons.first,
        //       //     //       );

        //       //     //       await _ticketsDao.updatePrimaryPayer(
        //       //     //           widget.ticketId, newPerson.id);

        //       //     //       setState(() {
        //       //     //         _dropdownValue = newPerson;
        //       //     //       });
        //       //     //     }
        //       //     //   },
        //       //     //   items: _groupPersons
        //       //     //       .map<DropdownMenuItem<String>>((Person? person) {
        //       //     //     return DropdownMenuItem<String>(
        //       //     //       value: person!.nickName,
        //       //     //       child: Text(
        //       //     //         person.nickName,
        //       //     //         style: const TextStyle(fontSize: 12),
        //       //     //       ),
        //       //     //     );
        //       //     //   }).toList(),
        //       //     //   underline: Container(), // removes default underline
        //       //     //   isDense: true,
        //       //     //   style: const TextStyle(color: Colors.black),
        //       //     //   dropdownColor: Colors.white,
        //       //     // ),
        //       //   ],
        //       // ),
        //       ),
        // ],
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
                              padding: const EdgeInsets.all(8.0),
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
                                                                .all(5.0),
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
                                                            if (!mounted) {
                                                              return;
                                                            }
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
                                                                Text(_calculateResponsibilityPercent(
                                                                    person,
                                                                    _currItems[
                                                                        index])), // TODO: make this dynamic from value set in db
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
                                  // TODO: add the adjust dialog later. Just split evenly for everyone for now
                                  // IconButton(
                                  //   onPressed: () {},
                                  //   icon: const Column(
                                  //     children: [
                                  //       Icon(Icons.percent),
                                  //       Text('Adjust')
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        )));
                  })))),
          SizedBox(
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
      bottomNavigationBar: AnimatedBottomNavBar(onTap: _done),

      // bottomNavigationBar: BottomNavigationBar(
      //     backgroundColor: Colors.white,
      //     elevation: 10,
      //     selectedItemColor: Colors.green,
      //     unselectedItemColor: Colors.blueAccent,
      //     selectedFontSize: 14,
      //     unselectedFontSize: 14,
      //     items: const [
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.group), label: 'Change Group'),
      //       // BottomNavigationBarItem(
      //       //     icon: Icon(Icons.edit), label: 'Edit Items'),
      //       BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done')
      //     ],
      //     onTap: (i) {
      //       setState(() {
      //         switch (i) {
      //           case 0:
      //             _done();
      //             break;
      //           case 1:
      //             // edit items
      //             // TODO: when the manually edit items screen is done
      //             break;
      //           default:
      //         }
      //         // switch (index) {
      //         //   case 0:
      //         //     // change group
      //         //     _changeGroup();
      //         //     break;
      //         //   case 1:
      //         //     // edit items
      //         //     // TODO: when the manually edit items screen is done
      //         //     break;
      //         //   case 2:
      //         //     // done
      //         //     _done();
      //         //     break;
      //         //   default:
      //         // }
      //       });
      //     }),
    );
  }
}
