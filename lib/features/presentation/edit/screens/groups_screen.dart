import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/edit/screens/persons_screen.dart';
import '../../../../db/auth_database.dart';
import '../../../../db/users_dao.dart';
import '../../../../db/persons_dao.dart';
import '../../../../db/groups_dao.dart';
import '../../../../db/group_persons_dao.dart';

class GroupsScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;

  const GroupsScreen({super.key, required this.db, required this.userId});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  Person? _mainPerson;
  List<Person>? _userPersons;
  List<Group>? _userGroups;
  // List<GroupPerson>? _groupPersons;
  Map<int, List<Person>>? _groupPersons;
  final ScrollController _groupScrollController = ScrollController();
  final ScrollController _avatarScrollController = ScrollController();

  late UsersDao _usersDao;
  late PersonsDao _personsDao;
  late GroupsDao _groupsDao;
  late GroupPersonsDao _groupPersonsDao;

  Set<int> _activePersonIds = {};
  bool _isLoading = true;

  late List<TextEditingController> groupControllers;

  @override
  void initState() {
    super.initState();
    _usersDao = UsersDao(widget.db);
    _personsDao = PersonsDao(widget.db);
    _groupsDao = GroupsDao(widget.db);
    _groupPersonsDao = GroupPersonsDao(widget.db);
    _initializeData(); // Do all async loading in one method
  }

  Future<void> _initializeData() async {
    setState(() => _isLoading = true);
    final Map<int, List<Person>> groupPersons = {};

    final mainPerson = await _personsDao.getMainPersonByUserId(widget.userId);
    final userPersons = await _personsDao.getPersonsByUserId(widget.userId);
    final userGroups = await _groupsDao.getGroupsByUserId(widget.userId);
    for (var group in userGroups) {
      var persons = await _personsDao.getPersonsByGroupId(group.id);
      groupPersons[group.id] = persons;
    }

    if (!mounted) return;

    setState(() {
      _mainPerson = mainPerson;
      _userPersons = userPersons;
      _userGroups = userGroups;
      _groupPersons = groupPersons;
      groupControllers = _userGroups!
          .map((group) => TextEditingController(text: group.groupName))
          .toList();
    });
    setState(() => _isLoading = false);
  }

  // Future<void> _loadMainPerson() async {
  //   final person = await _personsDao.getMainPersonByUserId(widget.userId);
  //   if (mounted) {
  //     setState(() {
  //       _mainPerson = person;
  //     });
  //   }
  // }

  Future<void> _loadPersons() async {
    final persons = await _personsDao.getPersonsByUserId(widget.userId);
    if (mounted) {
      setState(() {
        _userPersons = persons;
      });
    }
  }

  Future<void> _loadGroups() async {
    final groups = await _groupsDao.getGroupsByUserId(widget.userId);
    if (mounted) {
      setState(() {
        _userGroups = groups ?? [];
        groupControllers = _userGroups!
            .map((group) => TextEditingController(text: group.groupName))
            .toList();
      });
    }
  }

  void _addGroup() async {
    await _groupsDao.createGroup('', widget.userId);
    await _loadGroups();
  }

  void _deleteGroup(int index) async {
    await _groupsDao.deleteGroup(_userGroups![index].id);
    await _loadGroups();
  }

  bool _checkChosen(int index) {
    return _userGroups![index].isChosenGroup;
  }

  Future<void> _changeChosenGroup(int index) async {
    int? unchosenGroupId =
        await _groupsDao.getChosenGroupByUserId(widget.userId);

    if (unchosenGroupId != null) {
      await _groupsDao.setChosenGroupById(unchosenGroupId, false);
    }

    int chosenGroupId = _userGroups![index].id;
    await _groupsDao.setChosenGroupById(chosenGroupId, true);
  }

  Future<void> _loadGroupPersons() async {
    // go through all groups of the user and get the persons associated with that group
    // final groupPersons = await _groupPersonsDao.getGroupPersonsByGroupId()
  }

  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key('groupsScreen'),
        appBar: AppBar(
          title: const Text('Groups'),
        ),
        body: (_isLoading || _userGroups == null || _userPersons == null)
            ? const Center(child: CircularProgressIndicator())
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT SIDE: Group cards
                  Expanded(
                      flex: 3,
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: _groupScrollController,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children:
                                List.generate(groupControllers.length, (index) {
                              return Card(
                                  elevation: 2,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller:
                                                  groupControllers[index],
                                              decoration: const InputDecoration(
                                                  hintText: 'Group Name'),
                                              textInputAction:
                                                  TextInputAction.done,
                                              onFieldSubmitted: (value) {
                                                int groupId =
                                                    _userGroups![index].id;
                                                _groupsDao.setGroupNameById(
                                                    groupId, value);
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () =>
                                                _deleteGroup(index),
                                          ),
                                          Switch(
                                            value: _checkChosen(index),
                                            activeColor: Colors.blue,
                                            onChanged: (bool value) async {
                                              await _changeChosenGroup(index);
                                              await _loadGroups();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                          _groupPersons!.length, (jndex) {
                                        return Chip(
                                          label: Text(_groupPersons![
                                                  _userGroups![index]
                                                      .id]![jndex]
                                              .nickName),
                                        );
                                      }),
                                    ),
                                  ]));
                            }),
                          ),
                        ),
                      )),

                  // RIGHT SIDE: Settings and scrollable icons
                  Container(
                    width: 70,
                    // padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PersonsScreen(
                                    db: widget.db, userId: widget.userId),
                              ),
                            );
                            await _loadPersons();
                          },
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                            child: Scrollbar(
                          thumbVisibility: true,
                          controller: _avatarScrollController,
                          child: SingleChildScrollView(
                            child: Column(
                              children: _userPersons == null
                                  ? []
                                  : List.generate(_userPersons!.length,
                                      (index) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                final personId =
                                                    _userPersons![index].id;
                                                if (_activePersonIds
                                                    .contains(personId)) {
                                                  _activePersonIds
                                                      .remove(personId);
                                                } else {
                                                  _activePersonIds
                                                      .add(personId);
                                                }
                                              });
                                            },
                                            child: CircleAvatar(
                                              radius: 24,
                                              backgroundColor:
                                                  _activePersonIds.contains(
                                                          _userPersons![index]
                                                              .id)
                                                      ? Colors.blueAccent
                                                      : null,
                                              child: Text(_userPersons![index]
                                                  .nickName),
                                            ),
                                          )

                                          // child: CircleAvatar(
                                          //   radius: 24,
                                          //   child: Text(_userPersons![index].nickName),
                                          // ),
                                          );
                                    }),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: _addGroup,
            tooltip: 'Add Group',
            child: const Icon(Icons.group_add),
          ),
        ));
  }
}
