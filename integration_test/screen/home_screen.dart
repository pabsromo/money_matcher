import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeScreen {
  late WidgetTester tester;

  HomeScreen(this.tester);

  final _logoutButtonLocator = find.byIcon(Icons.logout);

  //// BUTTONS ////

  Future<bool> isOnHome() async {
    await tester.pumpAndSettle();
    return _logoutButtonLocator.evaluate().isNotEmpty;
  }
}
