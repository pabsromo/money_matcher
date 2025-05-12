import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_gradient_button.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_field.dart';
import 'package:money_matcher/features/presentation/summary/pages/summary_page.dart';

import '../../../../core/theme/app_pallete.dart';

import '../../../domain/entities/Person.dart';

class PersonPage extends StatefulWidget {
  static Route<List<Person>> route({required List<Person> persons}) =>
      MaterialPageRoute(builder: (_) => PersonPage(persons: persons));

  // static route() => MaterialPageRoute(
  //     builder: (context) => const PersonPage()
  // );
  final List<Person> persons;
  const PersonPage({super.key, required this.persons});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final formKey = GlobalKey<FormState>();
  late List<TextEditingController> nameControllers;

  @override
  void initState() {
    super.initState();
    nameControllers = widget.persons
        .map((person) => TextEditingController(text: person.name))
        .toList();
  }

  @override
  void dispose() {
    for (var c in nameControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _savePersons() {
    if (formKey.currentState?.validate() ?? false) {
      final updatedPersons = List.generate(
        nameControllers.length,
        (i) => Person(name: nameControllers[i].text),
      );
      Navigator.pop(context, updatedPersons);
    }
  }

  void _addPerson() {
    setState(() {
      nameControllers.add(TextEditingController());
    });
  }

  void _removePerson(int index) {
    setState(() {
      nameControllers[index].dispose();
      nameControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Items")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text(
                'Edit Items',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Scrollable list of item fields
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
                              EditField(
                                hintText: 'Item ${index + 1} Name',
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

              // Buttons: Add + Save
              Row(
                children: [
                  Expanded(
                    child: EditGradientButton(
                      buttonText: 'ADD PERSON',
                      onPressed: _addPerson,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: EditGradientButton(
                      buttonText: 'SAVE PERSONS',
                      onPressed: _savePersons,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: RichText(
                  text: TextSpan(
                    text: 'Go back?',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: ' Click Here',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
