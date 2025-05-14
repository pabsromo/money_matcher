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
        child: Column(
          children: [
            // RESPONSIBILITIES SECTION
            // ITEM CARDS SECTION
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text(
                              'Price: \$${item.price}\nShared with: ${item.associatedPersonNames.join(', ')}',
                            ),
                            leading: const Icon(Icons.shopping_cart),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              child: const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),

            // TOTALS SECTION
            const Text(
              'Totals...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Persons',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.persons.length,
                      itemBuilder: (context, index) {
                        final person = widget.persons[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(person.name),
                            leading: const Icon(Icons.shopping_cart),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
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
