import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_gradient_button.dart';

import '../../../domain/entities/Item.dart';
import '../../../domain/entities/Person.dart';
import '../../edit/pages/item_page.dart';
import '../../edit/pages/person_page.dart';

class SummaryPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SummaryPage(),
      );
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  List<Item> items = [
    Item(name: 'Apple', price: '2.50'),
    Item(name: 'Banana', price: '1.00'),
    Item(name: 'Orange', price: '1.75'),
  ];

  List<Person> persons = [
    Person(name: 'Joe'),
    Person(name: 'Doe'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Responsibility Graph',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

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
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text('Price: \$${item.price}'),
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
                      itemCount: persons.length,
                      itemBuilder: (context, index) {
                        final person = persons[index];
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

            const SizedBox(height: 20),
            EditGradientButton(
              buttonText: 'Edit Items',
              onPressed: () async {
                final updatedItems = await Navigator.push<List<Item>>(
                  context,
                  ItemPage.route(items: items),
                );

                if (updatedItems != null) {
                  setState(() {
                    items = updatedItems;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            EditGradientButton(
              buttonText: 'Edit Persons',
              onPressed: () async {
                final updatedPersons = await Navigator.push<List<Person>>(
                  context,
                  PersonPage.route(persons: persons),
                );

                if (updatedPersons != null) {
                  setState(() {
                    persons = updatedPersons;
                  });
                }
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
