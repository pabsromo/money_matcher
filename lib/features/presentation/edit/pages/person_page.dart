import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_gradient_button.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_field.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../domain/entities/person.dart';

class PersonPage extends StatefulWidget {
  static Route<List<Person>> route({required List<Person> persons}) =>
      MaterialPageRoute(builder: (_) => PersonPage(persons: persons));

  final List<Person> persons;
  const PersonPage({super.key, required this.persons});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final formKey = GlobalKey<FormState>();
  late List<TextEditingController> nameControllers;
  late List<Color> personColors;

  final List<Color> availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.pink,
    Colors.cyan,
  ];

  @override
  void initState() {
    super.initState();

    nameControllers = widget.persons
        .map((person) => TextEditingController(text: person.name))
        .toList();

    personColors = widget.persons.map((p) => p.color).toList();

    // Assign default color if any are missing
    for (int i = personColors.length; i < nameControllers.length; i++) {
      personColors.add(_getNextColor());
    }
  }

  @override
  void dispose() {
    for (var c in nameControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Color _getNextColor() {
    return availableColors[personColors.length % availableColors.length];
  }

  void _savePersons() {
    if (formKey.currentState?.validate() ?? false) {
      final updatedPersons = List.generate(
        nameControllers.length,
        (i) => Person(
          name: nameControllers[i].text,
          color: personColors[i],
        ),
      );
      Navigator.pop(context, updatedPersons);
    }
  }

  void _addPerson() {
    setState(() {
      nameControllers.add(TextEditingController());
      personColors.add(_getNextColor());
    });
  }

  void _removePerson(int index) {
    setState(() {
      nameControllers[index].dispose();
      nameControllers.removeAt(index);
      personColors.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit People")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text(
                'Edit People',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(nameControllers.length, (index) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: personColors[index],
                                    child: Text(
                                      nameControllers[index]
                                              .text
                                              .characters
                                              .firstOrNull
                                              ?.toUpperCase() ??
                                          '?',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text("Person ${index + 1}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _removePerson(index),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              EditField(
                                hintText: 'Name',
                                controller: nameControllers[index],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPerson,
        backgroundColor: AppPallete.gradient2, // or any preferred color
        child: const Icon(Icons.person_add),
        tooltip: 'Add Person',
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Save',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            _savePersons();
          }
        },
      ),
    );
  }
}
