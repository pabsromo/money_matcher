import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class GroupsScreenTestHelper {
  late WidgetTester tester;

  GroupsScreenTestHelper(this.tester);

  final _addGroupButtonLocator = find.byIcon(Icons.groups);
  final _editPersonsButtonLocator = find.byIcon(Icons.mode_edit);
  final _backButtonLocator = find.byIcon(Icons.arrow_back);

  // BUTTONS //
  Future<void> clickBack() async {
    await tester.tap(_backButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickAddGroup() async {
    await tester.tap(_addGroupButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickEditPersons() async {
    await tester.tap(_editPersonsButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickTargetPerson(String name) async {
    final targetPersonLocator = find.byKey(Key(name));
    await tester.tap(targetPersonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickTargetGroupAddPersonArea(int place) async {
    final targetAreaLocator = find.byKey(Key('group_${place}_add_area'));
    await tester.tap(targetAreaLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickTargetGroupSwitch(int place) async {
    final targetSwitchLocator = find.byKey(Key('group_${place}_switch'));
    await tester.tap(targetSwitchLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  // INPUTS //
  Future<void> insertGroupNameInSequence(int place, String name) async {
    final targetFieldLocator = find.byKey(Key('group $place'));
    await tester.enterText(targetFieldLocator, name);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  // TEXTS //

  // HELPERS //
}
