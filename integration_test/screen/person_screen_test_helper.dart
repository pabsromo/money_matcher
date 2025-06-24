import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class PersonScreenTestHelper {
  late WidgetTester tester;

  PersonScreenTestHelper(this.tester);

  final _addPersonIconLocator = find.byType(FloatingActionButton);
  final _savePersonIconLocator = find.byIcon(Icons.save);

  //// BUTTONS ////
  Future<void> addPerson() async {
    await tester.tap(_addPersonIconLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> savePersons() async {
    await tester.tap(_savePersonIconLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  // Add one for finding the first person element
  Future<Finder> getFirstPerson() async {
    final personCardFinder = find.byType(Card).first;
    return personCardFinder;
  }

  // Extract Edit Person Name from CardFinder
  Future<String> getPersonCardName(Finder cardFinder) async {
    final nameFinder =
        find.descendant(of: cardFinder, matching: find.byType(TextField));
    final textField = tester.widget<TextField>(nameFinder);
    final controller = textField.controller;
    return controller?.text ?? '';
  }

  //// UPDATE FIELDS ////
  Future<void> updateTargetPersonName(Finder cardFinder, String newName) async {
    final nameFinder =
        find.descendant(of: cardFinder, matching: find.byType(TextField));

    await tester.enterText(nameFinder, newName);
    await tester.pumpAndSettle();
  }
}
