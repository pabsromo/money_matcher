import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SignupScreen {
  late WidgetTester tester;

  SignupScreen(this.tester);

  final _signupScreenLocator = find.byKey(const Key("signupScreen"));
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
