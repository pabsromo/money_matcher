import 'package:flutter/material.dart';
import 'package:money_matcher/core/theme/app_pallete.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_field.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/entities/person.dart'; // Assuming you have a Person entity

class ItemPage extends StatefulWidget {
  static Route<List<Item>> route({
    required List<Item> items,
    required List<Person> persons, // Add persons to route
  }) =>
      MaterialPageRoute(
        builder: (_) => ItemPage(items: items, persons: persons),
      );

  final List<Item> items;
  final List<Person> persons; // Add persons parameter
  const ItemPage({
    super.key,
    required this.items,
    required this.persons, // Receive persons in the constructor
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final formKey = GlobalKey<FormState>();
  late List<TextEditingController> nameControllers;
  late List<TextEditingController> priceControllers;

  @override
  void initState() {
    super.initState();
    nameControllers = widget.items
        .map((item) => TextEditingController(text: item.name))
        .toList();
    priceControllers = widget.items
        .map((item) => TextEditingController(text: item.price))
        .toList();
  }

  @override
  void dispose() {
    for (var c in nameControllers) {
      c.dispose();
    }
    for (var c in priceControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _saveItems() {
    if (formKey.currentState?.validate() ?? false) {
      final updatedItems = List.generate(
        nameControllers.length,
        (i) => Item(
          name: nameControllers[i].text,
          price: priceControllers[i].text,
        ),
      );
      Navigator.pop(context, updatedItems);
    }
  }

  void _addItem() {
    setState(() {
      nameControllers.add(TextEditingController());
      priceControllers.add(TextEditingController());
    });
  }

  void _removeItem(int index) {
    setState(() {
      nameControllers[index].dispose();
      priceControllers[index].dispose();
      nameControllers.removeAt(index);
      priceControllers.removeAt(index);
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

              // You can access persons here and display them if needed
              if (widget.persons.isNotEmpty) ...[
                const Text(
                  'Persons:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ...widget.persons.map((person) => Text(person.name)).toList(),
                const SizedBox(height: 20),
              ],

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
                                  Text("Item ${index + 1}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _removeItem(index),
                                  ),
                                ],
                              ),
                              EditField(
                                hintText: 'Item ${index + 1} Name',
                                controller: nameControllers[index],
                              ),
                              const SizedBox(height: 10),
                              EditField(
                                hintText: 'Item ${index + 1} Price',
                                controller: priceControllers[index],
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
        onPressed: _addItem,
        backgroundColor: AppPallete.gradient2, // or any preferred color
        child: const Icon(Icons.add),
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
            _saveItems();
          }
        },
      ),
    );
  }
}
