import 'package:flutter/material.dart';

class ResponsibilityCard extends StatefulWidget {
  const ResponsibilityCard({Key? key}) : super(key: key);

  @override
  _ResponsibilityCardState createState() => _ResponsibilityCardState();
}

class _ResponsibilityCardState extends State<ResponsibilityCard> {
  List<String> nums = ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
