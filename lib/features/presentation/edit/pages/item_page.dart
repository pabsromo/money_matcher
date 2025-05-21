import 'package:flutter/material.dart';
import 'package:money_matcher/core/theme/app_pallete.dart';
import '../../../../shared/domain/entities/item.dart';
import '../../../../shared/domain/entities/person.dart';
import '../widgets/edit_item_associations_dialog.dart';

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
          associatedPersonNames: widget.items[i].associatedPersonNames,
        ),
      );
      Navigator.pop(context, updatedItems);
    }
  }

  void _addItem() {
    setState(() {
      nameControllers.add(TextEditingController());
      priceControllers.add(TextEditingController());
      widget.items.add(Item(name: '', price: ''));
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

  void _showEditAssociationsDialog(Item item) async {
    final result = await showDialog<Set<String>>(
      context: context,
      builder: (context) => EditItemAssociationsDialog(
        item: item,
        allPersons: widget.persons,
      ),
    );

    if (result != null) {
      setState(() {
        item.associatedPersonNames = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Edit Items")),
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
                                  Expanded(
                                    child: TextFormField(
                                      controller: nameControllers[index],
                                      decoration: const InputDecoration(
                                        hintText: 'Item name',
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.group,
                                        color: Colors.blue),
                                    onPressed: () =>
                                        _showEditAssociationsDialog(
                                            widget.items[index]),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _removeItem(index),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Price:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: priceControllers[index],
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        hintText: 'Enter price',
                                        prefixText: '\$',
                                        prefixStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.black,
                                        ),
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8),
                                      ),
                                      style: const TextStyle(fontSize: 16),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Price is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: widget
                                      .items[index].associatedPersonNames
                                      .map((personName) {
                                    final person = widget.persons.firstWhere(
                                      (p) => p.name == personName,
                                      orElse: () => Person(
                                          name: personName,
                                          color: Colors.grey,
                                          payingParty: false),
                                    );

                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: person.color,
                                            child: Text(
                                              person.name[0].toUpperCase(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            person.name,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
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
        tooltip: 'Add Person',
        child: const Icon(Icons.add),
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
