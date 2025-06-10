import 'package:flutter/material.dart';

class ManualEntryScreen extends StatefulWidget {
  const ManualEntryScreen({super.key});

  @override
  _ManualEntryScreenState createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends State<ManualEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('manualEntryScreen'),
      appBar: AppBar(
        title: const Text('Manual Entry'),
      ),
      body: Container(),
    );
  }
}
