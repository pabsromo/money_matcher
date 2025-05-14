import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'features/presentation/summary/pages/summary_page.dart';
import 'features/domain/entities/item.dart';
import 'features/domain/entities/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize as empty lists
    final List<Item> items = [];
    final List<Person> persons = [];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: SummaryPage(
        items: items, // Passing empty list
        persons: persons, // Passing empty list
      ),
    );
  }
}
