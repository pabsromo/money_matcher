import 'package:flutter_test/flutter_test.dart';
import 'package:money_matcher/main.dart' as money_matcher;
import 'package:drift/native.dart';
import '../screen/home_screen.dart';
import '../screen/login_screen.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/db/users_dao.dart';

void main() {
  group('Logging In:', () {
    testWidgets(
      'Validate able to log in with existing user',
      (WidgetTester tester) async {
        // Prep data
        final db = AuthDatabase.custom(NativeDatabase.memory());
        final usersDao = UsersDao(db);

        usersDao.deleteAll();
        usersDao.createUser("pabromo", "pabsromo@gmail.com", "password");

        final usersDao2 = UsersDao(db);

        User? u = await usersDao2.getUserByUsername("pabromo");

        print(u);

        // Launch the app
        await tester.pumpWidget(money_matcher.MyApp(db: db));

        await tester.pumpAndSettle(); // Wait for UI to fully build

        //// PREPARATIONS ////
        final loginScreen = LoginScreen(tester);
        final homeScreen = HomeScreen(tester);

        //// ACTIONS ////
        await loginScreen.insertUsername("pabromo");
        await loginScreen.insertPassword("password");
        await loginScreen.login();

        //// VALIDATIONS ////
        final isOnHome = await homeScreen.isOnHome();

        expect(isOnHome, equals(true), reason: "Should be logged in!");
      },
      timeout: const Timeout(Duration(minutes: 1)),
    );

    testWidgets(
      'Verify able to log user out back to log in screen',
      (WidgetTester tester) async {},
      timeout: const Timeout(Duration(minutes: 1)),
    );

    testWidgets(
      'Validate unable to log in with non-existent user',
      (WidgetTester tester) async {
        // Launch the app
        final db = AuthDatabase.custom(NativeDatabase.memory());
        await tester.pumpWidget(money_matcher.MyApp(db: db));

        await tester.pumpAndSettle(); // Wait for UI to fully build

        //// PREPARATIONS ////
        final loginScreen = LoginScreen(tester);

        //// ACTIONS ////
        await loginScreen.insertUsername("pabromo");
        await loginScreen.insertPassword("password");
        await loginScreen.login();

        //// VALIDATIONS ////
        expect(find.text("Invalid username or password"), findsOneWidget);
      },
      timeout: const Timeout(Duration(minutes: 1)),
    );
  });

  group('Signing Up:', () {
    testWidgets('Validate able to create new user and log in',
        (WidgetTester tester) async {});
    testWidgets('Validate able to create new user, log out, and log back in',
        (WidgetTester tester) async {});
    testWidgets('Validate unable to create new user with no username',
        (WidgetTester tester) async {});

    testWidgets('Validate unable to create new user with no email',
        (WidgetTester tester) async {});

    testWidgets('Validate unable to create new user with no intial password',
        (WidgetTester tester) async {});

    testWidgets('Validate unable to create new user with no sanity password',
        (WidgetTester tester) async {});

    testWidgets('Validate unable to create new user with differing passwords',
        (WidgetTester tester) async {});
  });
}
