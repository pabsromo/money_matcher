import 'package:flutter_test/flutter_test.dart';
import 'package:money_matcher/main.dart' as money_matcher;
import '../screen/person_screen.dart';
import '../screen/summary_screen.dart';
import 'package:flutter/material.dart';

void main() {
  group('Adding Persons (Widget Test):', () {
    testWidgets(
      'Validate Initial Empty Person Card',
      (WidgetTester tester) async {
        // Launch the app
        await tester.pumpWidget(const money_matcher.MyApp());

        await tester.pumpAndSettle(); // Wait for UI to fully build

        //// PREPARATIONS ////
        final summaryScreen = SummaryScreen(tester);
        final personScreen = PersonScreen(tester);

        //// ACTIONS ////
        await summaryScreen.goToPersonScreen();
        await personScreen.addPerson();

        //// VALIDATIONS ////
        final newCard = await personScreen.getFirstPerson();
        final personName =
            await (await personScreen.getPersonCardName(newCard));

        expect(personName, equals(""),
            reason: "Person Name should be empty by default");
      },
      timeout: const Timeout(Duration(minutes: 1)),
    );
  });
}
