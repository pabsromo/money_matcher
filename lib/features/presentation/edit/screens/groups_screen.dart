import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/edit/screens/persons_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../db/auth_database.dart';
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
  // ignore: unused_field
  Person? _mainPerson;
  List<Person>? _userPersons;
  List<Group>? _userGroups;
  Map<int, List<Person>>? _groupPersons;
  final ScrollController _groupScrollController = ScrollController();
  final ScrollController _avatarScrollController = ScrollController();

  late PersonsDao _personsDao;
  late GroupsDao _groupsDao;
  late GroupPersonsDao _groupPersonsDao;

  final Set<int> _activePersonIds = {};
  bool _isLoading = true;
  int _currentIndex = 0;

  late List<TextEditingController> groupControllers;
  late List<FocusNode> groupFocusNodes;

  @override
  void initState() {
    super.initState();
    _personsDao = PersonsDao(widget.db);
    _groupsDao = GroupsDao(widget.db);
    _groupPersonsDao = GroupPersonsDao(widget.db);
    _initializeData();
  }

  @override
  void dispose() {
    for (var controller in groupControllers) {
      controller.dispose();
    }
    for (var node in groupFocusNodes) {
      node.dispose();
    }
    super.dispose();
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

      groupFocusNodes = List.generate(_userGroups!.length, (index) {
        final node = FocusNode();
        node.addListener(() {
          if (!node.hasFocus) {
            final groupId = _userGroups![index].id;
            final newName = groupControllers[index].text;
            _groupsDao.setGroupNameById(groupId, newName);
          }
        });
        return node;
      });
    });
    setState(() => _isLoading = false);
  }

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
        _userGroups = groups;

        groupControllers = _userGroups!
            .map((group) => TextEditingController(text: group.groupName))
            .toList();

        groupFocusNodes = List.generate(_userGroups!.length, (index) {
          final node = FocusNode();
          node.addListener(() {
            if (!node.hasFocus) {
              final groupId = _userGroups![index].id;
              final newName = groupControllers[index].text;
              _groupsDao.setGroupNameById(groupId, newName);
            }
          });
          return node;
        });
      });
    }
  }

  void _addGroup() async {
    final id = await _groupsDao.createGroup('', widget.userId);
    _groupPersons![id] = [];
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
    Group? unchosenGroup =
        await _groupsDao.getChosenGroupByUserId(widget.userId);

    if (unchosenGroup != null) {
      await _groupsDao.setChosenGroupById(unchosenGroup.id, false);
    }

    int chosenGroupId = _userGroups![index].id;
    await _groupsDao.setChosenGroupById(chosenGroupId, true);
  }

  void _editPersons() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PersonsScreen(db: widget.db, userId: widget.userId),
      ),
    );
    await _loadPersons();
  }

  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('groupsScreen'),
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
      body: (_isLoading || _userGroups == null || _userPersons == null)
          ? const Center(child: CircularProgressIndicator())
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _groupScrollController,
                      child: SingleChildScrollView(
                        controller: _groupScrollController,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children:
                              List.generate(groupControllers.length, (index) {
                            return GestureDetector(
                              onTap: () async {
                                final groupId = _userGroups![index].id;

                                for (var personId in _activePersonIds) {
                                  await _groupPersonsDao.addPersonToGroup(
                                      groupId, personId);
                                }

                                final updatedPersons = await _personsDao
                                    .getPersonsByGroupId(groupId);

                                setState(() {
                                  _groupPersons![groupId] = updatedPersons;
                                  _activePersonIds.clear();
                                });
                              },
                              child: Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              key: Key('group $index'),
                                              controller:
                                                  groupControllers[index],
                                              focusNode: groupFocusNodes[index],
                                              decoration: const InputDecoration(
                                                  hintText: 'Group Name'),
                                              textInputAction:
                                                  TextInputAction.done,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.blueGrey),
                                            onPressed: () =>
                                                _deleteGroup(index),
                                          ),
                                          Switch(
                                            key: Key('group_${index}_switch'),
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: _groupPersons != null &&
                                              _userGroups != null &&
                                              _groupPersons![
                                                      _userGroups![index].id] !=
                                                  null &&
                                              _groupPersons![
                                                      _userGroups![index].id]!
                                                  .isNotEmpty
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: Wrap(
                                                key: Key(
                                                    'group_${index}_add_area'),
                                                spacing: 4.0,
                                                runSpacing: 4.0,
                                                children: _groupPersons![
                                                        _userGroups![index].id]!
                                                    .map((person) {
                                                  return GestureDetector(
                                                    onLongPress: () async {
                                                      final groupId =
                                                          _userGroups![index]
                                                              .id;
                                                      await _groupPersonsDao
                                                          .removePersonFromGroup(
                                                              groupId,
                                                              person.id);
                                                      final updatedPersons =
                                                          await _personsDao
                                                              .getPersonsByGroupId(
                                                                  groupId);

                                                      if (!mounted) return;
                                                      setState(() {
                                                        _groupPersons![
                                                                groupId] =
                                                            updatedPersons;
                                                      });

                                                      Fluttertoast.showToast(
                                                        msg:
                                                            '${person.nickName} removed from group.',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.TOP,
                                                        backgroundColor:
                                                            Colors.black87,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      );
                                                    },
                                                    child: Chip(
                                                      label:
                                                          Text(person.nickName),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            )
                                          : Padding(
                                              key: Key(
                                                  'group_${index}_add_area'),
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child:
                                                  const Text('No persons yet'),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    )),
                Container(
                  width: 70,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: _avatarScrollController,
                          child: SingleChildScrollView(
                            controller: _avatarScrollController,
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
                                                _activePersonIds.add(personId);
                                              }
                                            });
                                          },
                                          child: CircleAvatar(
                                            key: Key(
                                                _userPersons![index].nickName),
                                            radius: 24,
                                            backgroundColor:
                                                _activePersonIds.contains(
                                                        _userPersons![index].id)
                                                    ? Colors.blueAccent
                                                    : null,
                                            child: Text(
                                                _userPersons![index].nickName),
                                          ),
                                        ),
                                      );
                                    }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.blueGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_edit),
            label: 'Edit Persons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Add Group',
          ),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) {
            _editPersons();
          } else if (index == 1) {
            _addGroup();
          }
        },
      ),
    );
  }
}
