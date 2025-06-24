import 'package:flutter/material.dart';
import '../../../../db/auth_database.dart';
import '../../../../db/persons_dao.dart';

class PersonsScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;

  const PersonsScreen({super.key, required this.db, required this.userId});

  @override
  State<PersonsScreen> createState() => _PersonsScreenState();
}

class _PersonsScreenState extends State<PersonsScreen> {
  // ignore: unused_field
  Person? _mainPerson;
  List<Person>? _userPersons;
  late PersonsDao _personsDao;
  late List<TextEditingController> _personControllers;

  @override
  void initState() {
    super.initState();
    _personsDao = PersonsDao(widget.db);
    _loadPersons();
    _loadMainPerson();
  }

  Future<void> _loadPersons() async {
    final persons = await _personsDao.getPersonsByUserId(widget.userId);
    if (mounted) {
      setState(() {
        _userPersons = persons;
        _personControllers = _userPersons!
            .map((person) => TextEditingController(text: person.nickName))
            .toList();
      });
    }
  }

  Future<void> _loadMainPerson() async {
    final person = await _personsDao.getMainPersonByUserId(widget.userId);
    if (mounted) {
      setState(() {
        _mainPerson = person;
      });
    }
  }

  Future<void> _addPerson() async {
    _personsDao.createPerson('', '', '', '', widget.userId, false);
    _loadPersons();
  }

  void _deletePerson(int index) {
    _personsDao.deletePersonById(_userPersons![index].id);
    _loadPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('personsScreen'),
      appBar: AppBar(
        title: const Text('Edit Persons'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: List.generate(_personControllers.length, (index) {
          return Card(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _personControllers[index],
                          decoration:
                              const InputDecoration(hintText: 'Nickname'),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) {
                            int personId = _userPersons![index].id;
                            _personsDao.setPersonNicknameById(personId, value);
                          },
                        ),
                      ),
                      _userPersons![index].isMain
                          ? const Text('(you)')
                          : IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.blueGrey),
                              onPressed: () => _deletePerson(index),
                            )
                    ],
                  )));
        }),
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: _addPerson,
          tooltip: 'Add Person',
          child: const Icon(Icons.person_add)),
    );
  }
}
