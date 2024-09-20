import 'package:classic_games/feature/homepage/homepage.dart';
import 'package:classic_games/feature/sudoku-game/sudoku_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(),
        'sudoku_page': (context) => SudokuPage()
      },
    );
  }
}
