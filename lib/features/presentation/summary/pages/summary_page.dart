import 'package:flutter/material.dart';

import '../../../domain/entities/item.dart';
import '../../../domain/entities/person.dart';
import '../../edit/pages/item_page.dart';
import '../../edit/pages/person_page.dart';

class SummaryPage extends StatefulWidget {
  static route({required List<Item> items, required List<Person> persons}) =>
      MaterialPageRoute(
        builder: (context) => SummaryPage(items: items, persons: persons),
      );

  List<Item> items;
  List<Person> persons;
  SummaryPage({super.key, required this.items, required this.persons});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: widget.persons.map((person) {
            // Filter items associated with this person by name
            final personItems = widget.items
                .where(
                  (item) => item.associatedPersonNames.contains(person.name),
                )
                .toList();

            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: person.color,
                          radius: 8,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          person.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (personItems.isEmpty)
                      const Text('No items',
                          style: TextStyle(color: Colors.grey)),
                    ...personItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(item.name)),
                            Text('\$${item.price}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
              ItemPage.route(items: widget.items, persons: widget.persons),
            );
            if (updatedItems != null) {
              setState(() {
                widget.items = updatedItems;
              });
            }
          } else if (index == 1) {
            final updatedPersons = await Navigator.push<List<Person>>(
              context,
              PersonPage.route(persons: widget.persons),
            );
            if (updatedPersons != null) {
              setState(() {
                widget.persons = updatedPersons;
              });
            }
          }
        },
      ),
    );
  }
}
