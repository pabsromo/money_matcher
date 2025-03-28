import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_gradient_button.dart';
import 'package:money_matcher/features/presentation/edit/widgets/edit_field.dart';
import 'package:money_matcher/features/presentation/summary/pages/summary_page.dart';

import '../../../../core/theme/app_pallete.dart';

class PersonPage extends StatefulWidget {
  static route() => MaterialPageRoute(
      builder: (context) => const PersonPage()
  );
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final person1Controller = TextEditingController();
  final person2Controller = TextEditingController();
  final person3Controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    person1Controller.dispose();
    person2Controller.dispose();
    person3Controller.dispose();
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
                const Text('Edit Persons', style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(height: 30),
                EditField(hintText: 'person 1', controller: person1Controller,),
                const SizedBox(height: 15),
                EditField(hintText: 'person 2', controller: person2Controller,),
                const SizedBox(height: 15),
                EditField(
                  hintText: 'person 3',
                  controller: person3Controller,
                  isObscureText: true,
                ),
                const SizedBox(height:20),
                EditGradientButton(
                  buttonText: "SAVE PERSONS",
                  onPressed: () {
                    Navigator.push(
                      context,
                      SummaryPage.route(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      SummaryPage.route()
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
