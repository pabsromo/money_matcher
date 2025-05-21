import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SummaryScreen {
  late WidgetTester tester;

  SummaryScreen(this.tester);

  final _itemPageIconLocator = find.byIcon(Icons.edit);
  final _personPageIconLocator = find.byIcon(Icons.person);

  Future<void> goToItemScreen() async {
    await tester.tap(_itemPageIconLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> goToPersonScreen() async {
    await tester.tap(_personPageIconLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }
}
