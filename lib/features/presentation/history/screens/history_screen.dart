import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('historyScreen'),
      appBar: AppBar(
        title: const Text('Past Tickets'),
      ),
      body: Container(),
    );
  }
}
