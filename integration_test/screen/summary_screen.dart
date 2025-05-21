import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SummaryScreen {
  late WidgetTester tester;

  SummaryScreen(this.tester);

  final _itemPageIconLocator = find.byIcon(Icons.edit);
  final _personPageIconLocator = find.byIcon(Icons.person);

  //// BUTTONS ////
  Future<void> goToItemScreen() async {
    await tester.tap(_itemPageIconLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> goToPersonScreen() async {
    await tester.tap(_personPageIconLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  //// GET INFORMATON ////
  Future<Finder> getFirstPersonSummary() async {
    final personSummaryCardFinder = find.byType(Card).first;
    return personSummaryCardFinder;
  }

  Future<Map<String, dynamic>> getPersonSummaryCardDetails(
      Finder cardFinder, String findName) async {
    final Map<String, dynamic> result = {};

    final nameText =
        tester.widget<Text>(find.byKey(Key('personName_$findName')));
    final nameString = nameText.data;

    String? totalOwedString = "";

    final totalOwedFinder = find.byKey(const Key('totalOwed'));
    if (totalOwedFinder.evaluate().isNotEmpty) {
      totalOwedString = tester.widget<Text>(totalOwedFinder).data;
    }

    result['personName'] = nameString;
    result['totalOwed'] = totalOwedString;

    return result;
  }
}
