import 'package:flutter/material.dart';
import 'package:money_matcher/core/theme/app_pallete.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_gradient_button.dart';

import '../../edit/pages/item_page.dart';
import '../../edit/pages/person_page.dart';
import '../widgets/boxes.dart';
import '../widgets/lines.dart';
import '../widgets/summary_card.dart';

class SummaryPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const SummaryPage(),
  );
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  List<String> nums = ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Responsibility Graph',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Ensures Boxes and Lines take full screen height
            Container(
              height: MediaQuery.of(context).size.height * 0.5, // Adjust this based on needs
              child: Stack(
                children: const <Widget>[
                  Lines(),
                  IgnorePointer(
                    child: Boxes(left: 2, right: 2),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),
            const Text(
              'Totals...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // ListView inside SingleChildScrollView needs a constrained height
            Container(
              constraints: const BoxConstraints(
                minHeight: 100, // Ensures it has space but doesn't expand infinitely
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Prevents nested scroll conflict
                itemCount: nums.length,
                itemBuilder: (context, index) {
                  final p = nums[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SummaryCard(
                      title: 'Person $p',
                      color: AppPallete.gradient1,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            EditGradientButton(
              buttonText: 'Edit Items',
              onPressed: () {
                Navigator.push(
                  context,
                  ItemPage.route(),
                );
              },
            ),
            const SizedBox(height: 20),
            EditGradientButton(
              buttonText: 'Edit Persons',
              onPressed: () {
                Navigator.push(
                  context,
                  PersonPage.route(),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
