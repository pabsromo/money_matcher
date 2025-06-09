// import 'package:flutter_test/flutter_test.dart';
// import 'package:money_matcher/main.dart' as money_matcher;
// import '../screen/person_screen.dart';
// import '../screen/summary_screen.dart';

void main() {
  // group('Adding Persons:', () {
  //   testWidgets(
  //     'Validate Initial Empty Person Card',
  //     (WidgetTester tester) async {
  //       // Launch the app
  //       await tester.pumpWidget(const money_matcher.MyApp());

  //       await tester.pumpAndSettle(); // Wait for UI to fully build

  //       //// PREPARATIONS ////
  //       final summaryScreen = SummaryScreen(tester);
  //       final personScreen = PersonScreen(tester);

  //       //// ACTIONS ////
  //       await summaryScreen.goToPersonScreen();
  //       await personScreen.addPerson();

  //       //// VALIDATIONS ////
  //       final newCard = await personScreen.getFirstPerson();
  //       final personName = await personScreen.getPersonCardName(newCard);

  //       expect(personName, equals(""),
  //           reason: "Person Name should be empty by default");
  //     },
  //     timeout: const Timeout(Duration(minutes: 1)),
  //   );

  //   testWidgets("Saving Person's Name in Summary Page",
  //       (WidgetTester tester) async {
  //     // Launch the app
  //     await tester.pumpWidget(const money_matcher.MyApp());

  //     await tester.pumpAndSettle(); // Wait for UI to fully build

  //     String expectedName = "Bob";

  //     //// PREPARATIONS ////
  //     final summaryScreen = SummaryScreen(tester);
  //     final personScreen = PersonScreen(tester);

  //     //// ACTIONS ////
  //     await summaryScreen.goToPersonScreen();
  //     await personScreen.addPerson();
  //     final newCard = await personScreen.getFirstPerson();
  //     await personScreen.updateTargetPersonName(newCard, expectedName);
  //     await personScreen.savePersons();

  //     final firstPerson = await summaryScreen.getFirstPersonSummary();
  //     final personSummaryDetails = await summaryScreen
  //         .getPersonSummaryCardDetails(firstPerson, expectedName);

  //     //// VALIDATIONS ////
  //     String actualName = personSummaryDetails['personName'];
  //     expect(actualName, equals(expectedName),
  //         reason: "Expected Name: $expectedName, but Actual Name: $actualName");
  //   });
  // });
}
