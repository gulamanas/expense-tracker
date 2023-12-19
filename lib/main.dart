import 'package:expense_tracker/pages/home_page.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.purple),
      ),
      // theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
