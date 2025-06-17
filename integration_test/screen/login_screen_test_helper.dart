import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class LoginScreenTestHelper {
  late WidgetTester tester;

  LoginScreenTestHelper(this.tester);

  final _usernameInputLocator = find.byKey(const Key("usernameInput"));
  final _passwordInputLocator = find.byKey(const Key("passwordInput"));
  final _loginButtonLocator = find.byKey(const Key("loginBtn"));
  final _createAccountButtonLocator = find.byKey(const Key(("createAccntBtn")));

  //// BUTTONS ////
  Future<void> login() async {
    await tester.tap(_loginButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> createAccount() async {
    await tester.tap(_createAccountButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  //// UPDATE FIELDS ////
  Future<void> insertUsername(String username) async {
    await tester.enterText(_usernameInputLocator, username);
    await tester.pumpAndSettle();
  }

  Future<void> insertPassword(String password) async {
    await tester.enterText(_passwordInputLocator, password);
    await tester.pumpAndSettle();
  }
}
