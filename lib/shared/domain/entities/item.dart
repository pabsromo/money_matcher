class Item {
  String name;
  String price;
  Set<String> associatedPersonNames; // Use names as identifiers

  Item({
    required this.name,
    required this.price,
    Set<String>? associatedPersonNames,
  }) : associatedPersonNames = associatedPersonNames ?? {};
}
