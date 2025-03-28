import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_gradient_button.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_field.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../summary/pages/summary_page.dart';

class ItemPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const ItemPage()
  );
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final item1Controller = TextEditingController();
  final item2Controller = TextEditingController();
  final Item3Controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    item1Controller.dispose();
    item2Controller.dispose();
    Item3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Edit Items', style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(height: 30),
              EditField(hintText: 'Item 1', controller: item1Controller,),
              const SizedBox(height: 15),
              EditField(hintText: 'Item 2', controller: item2Controller,),
              const SizedBox(height: 15),
              EditField(
                hintText: 'Item 3',
                controller: Item3Controller,
                isObscureText: true,
              ),
              const SizedBox(height:20),
              EditGradientButton(
                buttonText: 'SAVE ITEMS',
                onPressed: () {
                  Navigator.push(
                    context,
                    SummaryPage.route()
                  );
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                    Navigator.push(
                      context,
                      SummaryPage.route(),
                  );
                },
                child: RichText(
                  text: TextSpan(text: 'Already have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.gradient2,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ]
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
