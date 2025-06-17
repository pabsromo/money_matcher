import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeScreenTestHelper {
  late WidgetTester tester;

  HomeScreenTestHelper(this.tester);

  final _logoutButtonLocator = find.byIcon(Icons.logout);
  final _newTicketButtonLocator = find.byKey(const Key('eventDetailsBtn'));
  final _pastTicketsButtonLocator = find.byKey(const Key('historyBtn'));
  final _groupsButtonLocator = find.byKey(const Key('groupsBtn'));
  final _settingsButtonLocator = find.byKey(const Key('settingsBtn'));

  //// BUTTONS ////
  Future<void> logout() async {
    await tester.tap(_logoutButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickNewTicket() async {
    await tester.tap(_newTicketButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickPastTickets() async {
    await tester.tap(_pastTicketsButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickGroups() async {
    await tester.tap(_groupsButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickSettings() async {
    await tester.tap(_settingsButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<bool> isOnHome() async {
    await tester.pumpAndSettle();
    return _logoutButtonLocator.evaluate().isNotEmpty;
  }
}
