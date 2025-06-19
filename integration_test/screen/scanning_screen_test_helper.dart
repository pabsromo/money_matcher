import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ScanningScreenTestHelper {
  late WidgetTester tester;

  ScanningScreenTestHelper(this.tester);

  final _backButtonLocator = find.byType(BackButton);

  // BUTTONS //
  Future<void> clickBack() async {
    await tester.tap(_backButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  // INPUTS //

  // TEXTS //
}
