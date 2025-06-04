import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/item.dart';
import '../../../../shared/domain/entities/person.dart';

class PersonSummaryCard extends StatelessWidget {
  final Person person;
  final List<Item> personItems;

  const PersonSummaryCard({
    super.key,
    required this.person,
    required this.personItems,
  });

  @override
  Widget build(BuildContext context) {
    double totalOwed = 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder( 
        borderRadius: BorderRadius.circular(12),
      ),
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
                if (person.payingParty)
                  const Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: Icon(Icons.star, color: Colors.teal, size: 20),
                  ),
                const SizedBox(width: 8),
                Text(
                  person.name,
                  key: Key('personName_${person.name}'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (personItems.isEmpty)
              const Text(
                'No items',
                style: TextStyle(color: Colors.grey),
              )
            else ...[
              // Header Row
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Item',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'Split Rate',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Cost',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // List of items
              ...personItems.map((item) {
                final totalPrice = double.tryParse(item.price) ?? 0.0;
                final splitCount = item.associatedPersonNames.length;
                final personShare =
                    splitCount > 0 ? totalPrice / splitCount : 0.0;
                totalOwed += personShare;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    key: Key(item.name),
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(item.name, key: Key(item.name)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                            child: Text('x1/$splitCount', key: Key(item.name))),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('\$${personShare.toStringAsFixed(2)}',
                              key: Key(item.name)),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Divider(thickness: 1.2),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Text('Total',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '\$${totalOwed.toStringAsFixed(2)}',
                          key: const Key('totalOwed'),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
