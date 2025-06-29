import 'package:flutter/material.dart';
import 'package:money_matcher/db/auth_database.dart';

class ItemResponsibilityScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;
  final int eventId;
  final int ticketId;

  const ItemResponsibilityScreen(
      {super.key,
      required this.db,
      required this.userId,
      required this.eventId,
      required this.ticketId});

  @override
  State<ItemResponsibilityScreen> createState() =>
      _ItemResponsibilityScreenState();
}

class _ItemResponsibilityScreenState extends State<ItemResponsibilityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Responsibilies'),
      ),
      body: Container(),
    );
  }
}
