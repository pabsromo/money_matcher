import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_gradient_button.dart';

import '../../edit/pages/item_page.dart';
import '../../edit/pages/person_page.dart';

class SummaryPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const SummaryPage(),
  );
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Responsibility Graph', style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(height: 40,),
            const Text('This is where the graph will go'),
            const SizedBox(height: 40,),
            Container(
              width: double.infinity, // Full width
              child: const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),
            const Text('Totals...', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 20),
            EditGradientButton(
              buttonText: 'Edit Items',
              onPressed: () {
                Navigator.push(
                  context,
                  ItemPage.route()
                );
              },
            ),
            const SizedBox(height: 20),
            EditGradientButton(
              buttonText: 'Edit Persons',
              onPressed: () {
                Navigator.push(
                    context,
                    PersonPage.route()
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
