import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/item.dart';
import '../../../../shared/domain/entities/person.dart';
import '../../edit/pages/item_page.dart';
import '../../edit/pages/person_page.dart';
import '../widgets/person_summary_card.dart';

class SummaryPage extends StatefulWidget {
  static route({required List<Item> items, required List<Person> persons}) =>
      MaterialPageRoute(
        builder: (context) => SummaryPage(items: items, persons: persons),
      );

  final List<Item> items;
  final List<Person> persons;
  const SummaryPage({super.key, required this.items, required this.persons});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  late List<Item> _items;
  late List<Person> _persons;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
    _persons = List.from(widget.persons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _persons.map((person) {
            // Filter items associated with this person by name
            final personItems = _items
                .where(
                  (item) => item.associatedPersonNames.contains(person.name),
                )
                .toList();

            return PersonSummaryCard(
              person: person,
              personItems: personItems,
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Persons',
          ),
        ],
        onTap: (index) async {
          if (index == 0) {
            final updatedItems = await Navigator.push<List<Item>>(
              context,
              ItemPage.route(items: _items, persons: _persons),
            );
            if (updatedItems != null) {
              setState(() {
                _items = updatedItems;
              });
            }
          } else if (index == 1) {
            final updatedPersons = await Navigator.push<List<Person>>(
              context,
              PersonPage.route(persons: _persons),
            );
            if (updatedPersons != null) {
              setState(() {
                _persons = updatedPersons;
              });
            }
          }
        },
      ),
    );
  }
}
