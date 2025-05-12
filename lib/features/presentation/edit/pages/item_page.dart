import 'package:flutter/material.dart';
import 'package:money_matcher/core/theme/app_pallete.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_field.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_gradient_button.dart';
import '../../../domain/entities/Item.dart';

class ItemPage extends StatefulWidget {
  static Route<List<Item>> route({required List<Item> items}) =>
      MaterialPageRoute(builder: (_) => ItemPage(items: items));

  final List<Item> items;
  const ItemPage({super.key, required this.items});

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

              // Buttons: Add + Save
              Row(
                children: [
                  Expanded(
                    child: EditGradientButton(
                      buttonText: 'ADD ITEM',
                      onPressed: _addItem,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: EditGradientButton(
                      buttonText: 'SAVE ITEMS',
                      onPressed: _saveItems,
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
