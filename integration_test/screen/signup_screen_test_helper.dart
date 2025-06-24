import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SignupScreen {
  late WidgetTester tester;

  SignupScreen(this.tester);

  final _signupScreenLocator = find.byKey(const Key("signupScreen"));
  final _firstNameInputLocator = find.byKey(const Key('firstNameTextForm'));
  final _lastNameInputLocator = find.byKey(const Key('lastNameTextForm'));
  final _nickNameInputLocator = find.byKey(const Key('nickNameTextForm'));
  final _usernameInputLocator = find.byKey(const Key("usernameTextForm"));
  final _emailInputLocator = find.byKey(const Key("emailTextForm"));
  final _initialPassInputLocator =
      find.byKey(const Key("initialPasswordTextForm"));
  final _confirmPassInputLocator =
      find.byKey(const Key("confirmPasswordTextForm"));
  final _signupButtonLocator = find.byKey(const Key("signupBtn"));

  Future<bool> isOnSignup() async {
    await tester.pumpAndSettle();
    return _signupScreenLocator.evaluate().isNotEmpty;
  }

  // FORMS INPUTS //
  Future<void> insertFirstname(String firstName) async {
    await tester.enterText(_firstNameInputLocator, firstName);
    await tester.pumpAndSettle();
  }

  Future<void> insertLastname(String lastName) async {
    await tester.enterText(_lastNameInputLocator, lastName);
    await tester.pumpAndSettle();
  }

  Future<void> insertNickname(String nickName) async {
    await tester.enterText(_nickNameInputLocator, nickName);
    await tester.pumpAndSettle();
  }

  Future<void> insertUsername(String username) async {
    await tester.enterText(_usernameInputLocator, username);
    await tester.pumpAndSettle();
  }

  Future<void> insertEmail(String email) async {
    await tester.enterText(_emailInputLocator, email);
    await tester.pumpAndSettle();
  }

  Future<void> insertInitialPassword(String password) async {
    await tester.enterText(_initialPassInputLocator, password);
    await tester.pumpAndSettle();
  }

  Future<void> insertConfirmPassword(String password) async {
    await tester.enterText(_confirmPassInputLocator, password);
    await tester.pumpAndSettle();
  }

  // BUTTONS //
  Future<void> signup() async {
    await tester.tap(_signupButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }
}
