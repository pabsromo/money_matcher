import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:money_matcher/main.dart' as money_matcher;
import 'package:drift/native.dart';
import '../screen/home_screen_test_helper.dart';
import '../screen/login_screen_test_helper.dart';
import '../screen/signup_screen_test_helper.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/db/users_dao.dart';

void main() {
  String defaultFirstName = 'Pablo';
  String defaultLastName = 'Romo';
  String defaultNickName = 'pabs';
  String defaultUser = "pabromo";
  String validEmail = "pabsromo@gmail.com";
  String invalidEmail = "bademail";
  String validPassword = "Password123!";
  String invalidPassword = "password";
  String shortInvalidPassword = "passy";
  String chars101 =
      "charscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharscharss";

  group('Logging In:', () {
    testWidgets(
      'Verify able to log in with existing user',
      (WidgetTester tester) async {
        // Prep data
        final db = AuthDatabase.custom(NativeDatabase.memory());
        final usersDao = UsersDao(db);

        usersDao.deleteAll();
        usersDao.createUser(defaultUser, validEmail, validPassword);

        // Launch the app
        await tester.pumpWidget(money_matcher.MyApp(db: db));
        await tester.pumpAndSettle();

        //// PREPARATIONS ////
        final loginScreen = LoginScreenTestHelper(tester);

        //// ACTIONS ////
        await loginScreen.insertUsername(defaultUser);
        await loginScreen.insertPassword(validPassword);
        await loginScreen.login();

        //// VALIDATIONS ////
        expect(find.byKey(const Key("homeScreen")), findsOneWidget,
            reason: "Should be logged in!");
      },
      timeout: const Timeout(Duration(minutes: 1)),
    );
    testWidgets(
      'Verify able to log user out back to log in screen',
      (WidgetTester tester) async {
        // Prep data
        final db = AuthDatabase.custom(NativeDatabase.memory());
        final usersDao = UsersDao(db);

        usersDao.deleteAll();
        usersDao.createUser(defaultUser, validEmail, validPassword);

        // Launch the app
        await tester.pumpWidget(money_matcher.MyApp(db: db));
        await tester.pumpAndSettle();

        // PREPARATIONS //
        final loginScreen = LoginScreenTestHelper(tester);
        final homeScreen = HomeScreenTestHelper(tester);

        //// PHASE 1 ////
        // ACTIONS //
        await loginScreen.insertUsername(defaultUser);
        await loginScreen.insertPassword(validPassword);
        await loginScreen.login();

        // VALIDATIONS //
        final isOnHome = await homeScreen.isOnHome();

        expect(isOnHome, equals(true), reason: "Should be logged in!");

        //// PHASE 2 ////
        // ACTIONS //
        await homeScreen.logout();

        // VALIDATIONS //
        expect(find.byKey(const Key("loginScreen")), findsOneWidget);
      },
      timeout: const Timeout(Duration(minutes: 1)),
    );
    testWidgets(
      'Verify unable to log in with non-existent user',
      (WidgetTester tester) async {
        // Launch the app
        final db = AuthDatabase.custom(NativeDatabase.memory());
        await tester.pumpWidget(money_matcher.MyApp(db: db));
        await tester.pumpAndSettle();

        //// PREPARATIONS ////
        final loginScreen = LoginScreenTestHelper(tester);

        //// ACTIONS ////
        await loginScreen.insertUsername(defaultUser);
        await loginScreen.insertPassword(validPassword);
        await loginScreen.login();

        //// VALIDATIONS ////
        expect(find.text("Invalid username or password"), findsOneWidget);
      },
      timeout: const Timeout(Duration(minutes: 1)),
    );
  });

  group('Signing Up:', () {
    testWidgets('Verify able to create new user and log in',
        (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      //// PREPARATIONS ////
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      //// ACTIONS ////
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      await signupScreen.insertEmail(validEmail);
      await signupScreen.insertInitialPassword(validPassword);
      await signupScreen.insertConfirmPassword(validPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      //// VALIDATIONS ////
      expect(find.byKey(const Key("homeScreen")), findsOneWidget,
          reason: "Should be logged in!");
    });
    testWidgets('Verify able to create new user, log out, and log back in',
        (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      //// PREPARATIONS ////
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);
      final homeScreen = HomeScreenTestHelper(tester);

      //// PHASE 1 ////
      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      await signupScreen.insertEmail(validEmail);
      await signupScreen.insertInitialPassword(validPassword);
      await signupScreen.insertConfirmPassword(validPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(find.byKey(const Key("homeScreen")), findsOneWidget,
          reason: "Should be logged in!");

      //// PHASE 2 ////
      // ACTIONS //
      await homeScreen.logout();

      await loginScreen.insertUsername(defaultUser);
      await loginScreen.insertPassword(validPassword);
      await loginScreen.login();

      // VALIDATIONS //
      expect(find.byKey(const Key("homeScreen")), findsOneWidget,
          reason: "Should be logged in!");
    });
    // Verify unable to create new user without a first name
    // Verify unable to create new user without a last name
    // Verify unable to create new user without nickname
    testWidgets('Verify unable to create new user with no username',
        (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      //// PREPARATIONS ////
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      //// PHASE 1 ////
      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      // no username
      await signupScreen.insertEmail(validEmail);
      await signupScreen.insertInitialPassword(validPassword);
      await signupScreen.insertConfirmPassword(validPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(find.text("Enter username"), findsOneWidget,
          reason: "User should have to input username!");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");
    });

    testWidgets('Verify unable to create new user with no email',
        (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // PREPARATIONS //
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      //// PHASE 1 ////
      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      // no email
      await signupScreen.insertInitialPassword(validPassword);
      await signupScreen.insertConfirmPassword(validPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(find.text("Enter email"), findsOneWidget,
          reason: "User should have no email");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");
    });

    testWidgets('Verify unable to create new user with no intial password',
        (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // PREPARATIONS //
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      //// PHASE 1 ////
      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      await signupScreen.insertEmail(validEmail);
      // no initial password
      await signupScreen.insertConfirmPassword(validPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(find.text("Enter password"), findsOneWidget,
          reason: "User have no initial password");

      expect(find.text("Passwords do not match"), findsOneWidget,
          reason: "User should have differing passwords");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");
    });

    testWidgets('Verify unable to create new user with no confirm password',
        (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // PREPARATIONS //
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      //// PHASE 1 ////
      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      await signupScreen.insertEmail(validEmail);
      await signupScreen.insertInitialPassword(validPassword);
      // no confirm password
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(find.text("Confirm your password"), findsOneWidget,
          reason: "User have no confirm password");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");
    });

    testWidgets('Verify unable to create new user with differing passwords',
        (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // PREPARATIONS //
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      //// PHASE 1 ////
      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      await signupScreen.insertEmail(validEmail);
      await signupScreen.insertInitialPassword(validPassword);
      await signupScreen.insertConfirmPassword(invalidPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(find.text("Passwords do not match"), findsOneWidget,
          reason: "User should have differing passwords");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");
    });

    testWidgets('Verify bad email gets rejected', (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // PREPARATIONS //
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      await signupScreen.insertEmail(invalidEmail);
      await signupScreen.insertInitialPassword(validPassword);
      await signupScreen.insertConfirmPassword(validPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(find.text("Email must be valid"), findsOneWidget,
          reason: "User should have invalid email");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");
    });

    testWidgets('Verify an invalid password is rejected',
        (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // PREPARATIONS //
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      await signupScreen.insertEmail(invalidEmail);
      await signupScreen.insertInitialPassword(invalidPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.insertConfirmPassword(invalidPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(
          find.text(
              "Password must be at least 8 chars, at least have one letter, at least one number, and at least one special character"),
          findsOneWidget,
          reason: "User should have invalid password");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");

      // ACTIONS //
      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      await signupScreen.insertEmail(invalidEmail);
      await signupScreen.insertInitialPassword(shortInvalidPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.insertConfirmPassword(shortInvalidPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(
          find.text("Password must be at least 8 characters"), findsOneWidget,
          reason: "User should have invalid password");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");
    });

    testWidgets('Verify a very long username is rejected',
        (WidgetTester tester) async {
      // Launch the app
      final db = AuthDatabase.custom(NativeDatabase.memory());
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      //// PREPARATIONS ////
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(chars101);
      await signupScreen.insertEmail(invalidEmail);
      await signupScreen.insertInitialPassword(invalidPassword);
      await signupScreen.insertConfirmPassword(validPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(find.text("Username must be equal to or less than 32 characters"),
          findsOneWidget,
          reason: "User should have invalid username");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");
    });

    testWidgets('verify an existing username is rejected',
        (WidgetTester tester) async {
      // Prep data
      final db = AuthDatabase.custom(NativeDatabase.memory());
      final usersDao = UsersDao(db);

      usersDao.deleteAll();
      usersDao.createUser(defaultUser, validEmail, validPassword);

      // Launch the app
      await tester.pumpWidget(money_matcher.MyApp(db: db));
      await tester.pumpAndSettle();

      // PREPARATIONS //
      final loginScreen = LoginScreenTestHelper(tester);
      final signupScreen = SignupScreen(tester);

      // ACTIONS //
      await loginScreen.createAccount();

      await signupScreen.insertFirstname(defaultFirstName);
      await signupScreen.insertLastname(defaultLastName);
      await signupScreen.insertNickname(defaultNickName);
      await signupScreen.insertUsername(defaultUser);
      await signupScreen.insertEmail(validEmail);
      await signupScreen.insertInitialPassword(validPassword);
      await signupScreen.insertConfirmPassword(validPassword);
      FocusManager.instance.primaryFocus?.unfocus(); // lower keyboard
      await tester.pumpAndSettle();
      await signupScreen.signup();

      // VALIDATIONS //
      expect(find.text("Username already taken"), findsOneWidget,
          reason: "User should have invalid username");

      expect(find.byKey(const Key("signupScreen")), findsOneWidget,
          reason: "User should still be on signup screen");
    });
  });
}
