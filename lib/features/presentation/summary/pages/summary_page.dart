import 'package:flutter/material.dart';
import 'package:money_matcher/core/theme/app_pallete.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_gradient_button.dart';

import '../../edit/pages/item_page.dart';
import '../../edit/pages/person_page.dart';
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
            const Row(
              children: [
                // First Column
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // Adjust alignment as needed
                    children: [
                      Text("Column 1, Item 1"),
                      Text("Column 1, Item 2"),
                      Text("Column 1, Item 3"),
                    ],
                  ),
                ),

                // Second Column
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Column 2, Item 1"),
                      Text("Column 2, Item 2"),
                      Text("Column 2, Item 3"),
                    ],
                  ),
                ),
              ],
            ),
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true, // Prevents unnecessary space usage
                itemCount: nums.length,
                itemBuilder: (context, index) {
                  final p = nums[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: SummaryCard(
                        title: 'Person $p',
                        color: AppPallete.gradient1,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20,),
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
