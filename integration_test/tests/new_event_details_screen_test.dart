import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:money_matcher/db/group_persons_dao.dart';
import 'package:money_matcher/db/groups_dao.dart';
import 'package:money_matcher/main.dart' as money_matcher;
import 'package:drift/native.dart';
import '../screen/event_details_screen_test_helper.dart';
import '../screen/home_screen_test_helper.dart';
import '../screen/login_screen_test_helper.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/db/users_dao.dart';
import 'package:money_matcher/db/persons_dao.dart';

import '../screen/scanning_screen_test_helper.dart';

void main() {
  String defaultUser = "pabromo";
  String validEmail = "pabsromo@gmail.com";
  // String invalidEmail = "bademail";
  String validPassword = "Password123!";
  // String invalidPassword = "password";
  // String shortInvalidPassword = "passy";
  // String chars101 =
  // "charscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharss";

  group('Input Validation', () {
    testWidgets('Verify error text for empty Event Name',
        (WidgetTester tester) async {});
    testWidgets('Verify error text for empty Event Location',
        (WidgetTester tester) async {});
    testWidgets('Verify error text for empty Event Date',
        (WidgetTester tester) async {});
    testWidgets('Verify error texts for multiple empty inputs',
        (WidgetTester tester) async {});
  });

  group('Chosen Group Logic', () {
    testWidgets('Verify able to choose Chosen Group with no initial group',
        (WidgetTester tester) async {});
    testWidgets('Verify able to change Chosen Group with initial group',
        (WidgetTester tester) async {});
    testWidgets('Verify unable to proceed without Group',
        (WidgetTester tester) async {});
    testWidgets('Verify unable to proceed without Persons in Chosen Group',
        (WidgetTester tester) async {});
  });

  group('Flow and Data Persistence Logic', () {
    testWidgets(
        'Verify Event Screen appears after Clicking on New Ticket from Home Screen',
        (WidgetTester tester) async {
      // PREPARATIONS //
      // Prep data
      final db = AuthDatabase.custom(NativeDatabase.memory());
      final usersDao = UsersDao(db);

      usersDao.deleteAll();
      usersDao.createUser(defaultUser, validEmail, validPassword);

      // Launch the app
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // Prep Screen Test Helpers
      final loginScreen = LoginScreenTestHelper(tester);
      final homeScreen = HomeScreenTestHelper(tester);
      final eventDetailsScreen = EventDetailsScreenTestHelper(tester);

      // ACTIONS //
      await loginScreen.insertUsername(defaultUser);
      await loginScreen.insertPassword(validPassword);
      await loginScreen.login();
      await homeScreen.clickNewTicket();

      // VALIDATIONS //
      expect(find.byKey(const Key("eventDetailsScreen")), findsOneWidget,
          reason: "Should be on Event Details Screen");

      expect(find.text('No Group Selected'), findsOneWidget,
          reason: 'No group should be selected');

      expect(await eventDetailsScreen.getChipFinder(), findsNothing);

      expect(await eventDetailsScreen.getEventName(), equals(''),
          reason: 'Name default is empty');

      expect(await eventDetailsScreen.getEventLocation(), equals(''),
          reason: 'Location default is empty');

      expect(await eventDetailsScreen.getEventDate(), equals(''),
          reason: 'Date default is empty');
    });
    testWidgets('Verify with Valid Event able to proceed to Scan Screen',
        (WidgetTester tester) async {
      // PREPARATIONS //
      // Prep data
      final db = AuthDatabase.custom(NativeDatabase.memory());
      final usersDao = UsersDao(db);
      final personsDao = PersonsDao(db);
      final groupsDao = GroupsDao(db);
      final groupPersonsDao = GroupPersonsDao(db);

      /* Creates...
        User pabromo with nickname pabs
        Person cami
        Group 'test group' with persons pabs and cami
      */
      usersDao.deleteAll();
      usersDao.createUser(defaultUser, validEmail, validPassword);
      final userId = await usersDao.getUserByUsername('pabromo');
      personsDao.createPerson('', '', 'pabs', '', userId!.id, true);
      personsDao.createPerson('', '', 'cami', '', userId.id, false);
      final groupId = await groupsDao.createGroup('test group', userId.id);
      groupsDao.setChosenGroupById(groupId, true);
      groupPersonsDao.addPersonToGroup(groupId, 0);
      groupPersonsDao.addPersonToGroup(groupId, 1);

      // Launch the app
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // Prep Screen Test Helpers
      final loginScreen = LoginScreenTestHelper(tester);
      final homeScreen = HomeScreenTestHelper(tester);
      final eventDetailsScreen = EventDetailsScreenTestHelper(tester);

      // ACTIONS //
      await loginScreen.insertUsername(defaultUser);
      await loginScreen.insertPassword(validPassword);
      await loginScreen.login();
      await homeScreen.clickNewTicket();
      await eventDetailsScreen.insertEventName('test event');
      await eventDetailsScreen.insertLocation('test location');
      await eventDetailsScreen.chooseDate(16, 06, 2025);
      await eventDetailsScreen.clickDone();

      // should be in scan screen by now
      // await Future.delayed(const Duration(seconds: 5), () {});
      // VALIDATIONS //
      expect(find.byKey(const Key('scanningScreen')), findsOneWidget,
          reason: "Should be on Scanning Screen");
    });
    testWidgets('Verify same event details after coming back from Scan Screen',
        (WidgetTester tester) async {
      // PREPARATIONS //
      // Prep data
      final db = AuthDatabase.custom(NativeDatabase.memory());
      final usersDao = UsersDao(db);
      final personsDao = PersonsDao(db);
      final groupsDao = GroupsDao(db);
      final groupPersonsDao = GroupPersonsDao(db);

      /* Creates...
        User pabromo with nickname pabs
        Person cami
        Group 'test group' with persons pabs and cami
      */
      await usersDao.deleteAll();
      await usersDao.createUser(defaultUser, validEmail, validPassword);
      final userId = await usersDao.getUserByUsername('pabromo');
      final pabsId =
          await personsDao.createPerson('', '', 'pabs', '', userId!.id, true);
      final camiId =
          await personsDao.createPerson('', '', 'cami', '', userId.id, false);
      final groupId = await groupsDao.createGroup('test group', userId.id);
      await groupsDao.setChosenGroupById(groupId, true);
      await groupPersonsDao.addPersonToGroup(groupId, pabsId);
      await groupPersonsDao.addPersonToGroup(groupId, camiId);

      // Launch the app
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // Prep Screen Test Helpers
      final loginScreen = LoginScreenTestHelper(tester);
      final homeScreen = HomeScreenTestHelper(tester);
      final eventDetailsScreen = EventDetailsScreenTestHelper(tester);
      final scanningScreen = ScanningScreenTestHelper(tester);

      // ACTIONS //
      await loginScreen.insertUsername(defaultUser);
      await loginScreen.insertPassword(validPassword);
      await loginScreen.login();
      await homeScreen.clickNewTicket();
      await eventDetailsScreen.insertEventName('test event');
      await eventDetailsScreen.insertLocation('test location');
      await eventDetailsScreen.chooseDate(16, 06, 2025);
      await eventDetailsScreen.clickDone();

      expect(find.byKey(const Key('scanningScreen')), findsOneWidget,
          reason: "Should be on Scanning Screen");

      await scanningScreen.clickBack();

      // VALIDATIONS //
      expect(find.byKey(const Key("eventDetailsScreen")), findsOneWidget,
          reason: "Should be on Event Details Screen");

      expect(find.text('test group'), findsOneWidget,
          reason: 'No group should be selected');

      expect(await eventDetailsScreen.getChipFinder(), findsExactly(2));

      expect(await eventDetailsScreen.getEventName(), equals('test event'),
          reason: 'Name default is empty');

      expect(
          await eventDetailsScreen.getEventLocation(), equals('test location'),
          reason: 'Location default is empty');

      expect(await eventDetailsScreen.getEventDate(),
          equals('Monday, June 16th 2025'),
          reason: 'Date default is empty');
    });
    testWidgets('Verify event gets persisted after value in Event Name',
        (WidgetTester tester) async {});
    testWidgets('Verify event gets persisted after value in Event Location',
        (WidgetTester tester) async {});
    testWidgets('Verify event gets persisted after value in Event Date',
        (WidgetTester tester) async {});
    testWidgets(
        'Verify event gets persisted after values in Event Name, Location, and Date',
        (WidgetTester tester) async {});
    testWidgets(
        'Verify NO event gets persisted after NO values in Event Name, Location, and Date',
        (WidgetTester tester) async {});
    testWidgets(
        'Verify fresh event after going back to home and proceeding to New Ticket again',
        (WidgetTester tester) async {});
  });
}
