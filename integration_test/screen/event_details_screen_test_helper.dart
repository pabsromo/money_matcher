import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class EventDetailsScreenTestHelper {
  late WidgetTester tester;

  EventDetailsScreenTestHelper(this.tester);

  final _eventNameInputLocator = find.byKey(const Key('eventNameInput'));
  final _eventLocationInputLocator =
      find.byKey(const Key('eventLocationInput'));
  final _eventDateInputLocator = find.byKey(const Key('eventDateInput'));
  final _doneButtonLocator = find.byKey(const Key('doneBtn'));
  final _editGroupButtonLocator = find.byIcon(Icons.edit);

  // BUTTONS //
  Future<void> clickDone() async {
    await tester.tap(_doneButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickEditGroup() async {
    await tester.tap(_editGroupButtonLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  // INPUTS //
  Future<void> insertEventName(String eventName) async {
    await tester.enterText(_eventNameInputLocator, eventName);
    await tester.pumpAndSettle();
  }

  Future<void> insertLocation(String location) async {
    await tester.enterText(_eventLocationInputLocator, location);
    await tester.pumpAndSettle();
  }

  Future<void> chooseDate(int day, int month, int year) async {
    await tester.tap(_eventDateInputLocator);
    await tester.pumpAndSettle();
    await tester.tap(find.text(day.toString()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
  }

  // TEXTS //
  Future<String> getEventName() async {
    return await getControllerText('eventNameInput');
  }

  Future<String> getEventLocation() async {
    return await getControllerText('eventLocationInput');
  }

  Future<String> getEventDate() async {
    return await getControllerText('eventDateInput');
  }

  Future<String?> getChosenGroupText() async {
    // final _locator = find.byKey(const Key('chosenGroupText'));
    final groupText =
        tester.widget<Text>(find.byKey(const Key('chosenGroupText')));
    return groupText.data;
  }

  Future<Finder> getChipFinder() async {
    final wrapFinder = find.byKey(const Key('chipWrap'));
    expect(wrapFinder, findsOneWidget); // Ensure it exists
    final chipFinder = find.descendant(
      of: wrapFinder,
      matching: find.byType(Chip),
    );
    return chipFinder;
  }

  // HELPERS //
  Future<String> getControllerText(String key) async {
    final nameField = tester.widget<TextFormField>(
      find.byKey(Key(key)),
    );
    final nameController = nameField.controller!;
    return nameController.text;
  }
}
