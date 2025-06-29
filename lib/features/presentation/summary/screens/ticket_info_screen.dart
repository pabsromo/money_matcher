import 'package:flutter/material.dart';
import 'package:money_matcher/db/auth_database.dart';

class TicketInfoScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;
  final int eventId;
  final int ticketId;

  const TicketInfoScreen({
    super.key,
    required this.db,
    required this.userId,
    required this.eventId,
    required this.ticketId,
  });

  @override
  State<TicketInfoScreen> createState() => _TicketInfoScreenState();
}

class _TicketInfoScreenState extends State<TicketInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('ticketInfoScreen'),
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
