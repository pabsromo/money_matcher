import 'package:flutter/material.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/entities/person.dart';

class EditItemAssociationsDialog extends StatefulWidget {
  final Item item;
  final List<Person> allPersons;

  const EditItemAssociationsDialog({
    Key? key,
    required this.item,
    required this.allPersons,
  }) : super(key: key);

  @override
  State<EditItemAssociationsDialog> createState() =>
      _EditItemAssociationsDialogState();
}

class _EditItemAssociationsDialogState
    extends State<EditItemAssociationsDialog> {
  late Set<String> selectedNames;

  @override
  void initState() {
    super.initState();
    selectedNames = Set.from(widget.item.associatedPersonNames);
  }

  void _toggleSelectAll(bool? selectAll) {
    setState(() {
      if (selectAll == true) {
        selectedNames = widget.allPersons.map((p) => p.name).toSet();
      } else {
        selectedNames.clear();
      }
    });
  }

  bool get _isAllSelected => selectedNames.length == widget.allPersons.length;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Item Responsibilities for ${widget.item.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text(
                'Select All',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: _isAllSelected,
              onChanged: _toggleSelectAll,
            ),
            const Divider(),
            ...widget.allPersons.map((person) {
              final isSelected = selectedNames.contains(person.name);
              return CheckboxListTile(
                value: isSelected,
                title: Text(person.name),
                secondary: CircleAvatar(
                  backgroundColor: person.color,
                  child: Text(
                    person.name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                onChanged: (bool? selected) {
                  setState(() {
                    if (selected == true) {
                      selectedNames.add(person.name);
                    } else {
                      selectedNames.remove(person.name);
                    }
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(selectedNames),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
