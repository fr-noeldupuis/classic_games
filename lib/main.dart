import 'package:classic_games/feature/homepage/homepage.dart';
import 'package:classic_games/feature/sudoku-game/repositories/json_repository.dart';
import 'package:classic_games/feature/sudoku-game/sudoku_game.dart';
import 'package:classic_games/feature/sudoku-game/sudoku_page.dart';
import 'package:classic_games/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  SudokuJsonRepository sudokuJsonRepository = SudokuJsonRepository();
  await sudokuJsonRepository.initializeRepository();

  runApp(RepositoryProvider(
    create: (context) => sudokuJsonRepository,
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Homepage(),
        'sudoku/sudoku_home': (context) => const SudokuPage(),
        'sudoku/sudoku_game': (context) => const SudokuGame(),
      },
    );
  }
}
