import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'features/presentation/summary/pages/summary_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const SummaryPage(),
    );
  }
}
