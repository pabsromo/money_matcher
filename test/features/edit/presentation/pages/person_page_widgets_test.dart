import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_matcher/main.dart' as money_matcher;
import 'package:money_matcher/features/presentation/edit/pages/person_page.dart';
import 'package:money_matcher/shared/domain/entities/person.dart';
import '../../../../../integration_test/screen/person_screen.dart';

void main() {
  // testWidgets('testAddPersonCard | Make sure adding Person card works',
  //     (WidgetTester tester) async {
  //   // Create a testable widget with the PersonPage
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: PersonPage(persons: []),
  //     ),
  //   );

  //   // Wait for initial frame to settle
  //   await tester.pumpAndSettle();

  //   // Tap the Floating Action Button to add a new person
  //   final fabFinder = find.byType(FloatingActionButton);
  //   expect(fabFinder, findsOneWidget);
  //   await tester.tap(fabFinder);

  //   // Wait for animations/state to settle
  //   await tester.pumpAndSettle();

  //   // Now check if a new person card was added.
  //   // Adjust the expectation below based on your UI.
  //   expect(
  //       find.text('Name'), findsOneWidget); // if default name is 'New Person'

  //   // Or if the name field is empty and shows a hint or placeholder
  //   // expect(find.byType(TextField), findsWidgets); and check contents or count

  //   // If you use ListView/ListTile or custom widgets to represent people
  //   // you can use:
  //   // expect(find.byType(PersonCardWidget), findsOneWidget);
  // });
}
