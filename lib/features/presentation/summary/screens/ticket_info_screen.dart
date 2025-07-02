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
      appBar: AppBar(title: const Text('Summary'), actions: [
        Row(
          children: [
            TextButton.icon(
              label: Text('Export'),
              icon: const Icon(Icons.outbox),
              onPressed: () {},
            ),
            TextButton.icon(
              label: Text('Send'),
              icon: const Icon(Icons.share),
              onPressed: () {},
            )
          ],
        )
      ]),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  // Event Name Text Field
                  // Event Location Text Field
                  // Date input field
                ],
              ),
              Column(
                children: [
                  // Status Badge
                  // Paid By selection Dropdown
                ],
              )
            ],
          ),
          SingleChildScrollView(
              // Person list
              // Floating button to Edit Items
              ),
          Row(
              // Subtotal
              // Tax
              // Tip - Only thing that can be edited here
              // Total
              )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.image_sharp), label: 'Open/Add Images'),
        const BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done')
      ]),
    );
  }
}
