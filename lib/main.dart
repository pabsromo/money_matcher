import 'package:flutter/material.dart';
import 'db/auth_database.dart';
import 'features/presentation/auth/pages/login_screen.dart';

void main() {
  final db = AuthDatabase();
  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final AuthDatabase db;
  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Matcher',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(db: db),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'core/theme/theme.dart';
// import 'features/presentation/summary/pages/summary_page.dart';
// import 'shared/domain/entities/item.dart';
// import 'shared/domain/entities/person.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize as empty lists
//     final List<Item> items = [];
//     final List<Person> persons = [];

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: AppTheme.darkThemeMode,
//       home: SummaryPage(
//         items: items, // Passing empty list
//         persons: persons, // Passing empty list
//       ),
//     );
//   }
// }
