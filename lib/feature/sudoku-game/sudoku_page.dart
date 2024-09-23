import 'package:flutter/material.dart';

class SudokuPage extends StatelessWidget {
  const SudokuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: FilledButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  'sudoku/sudoku_game',
                  arguments: {'difficulty': 'Easy'},
                );
              },
              child: const Text("Easy"),
            ),
          ),
          ListTile(
            title: FilledButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  'sudoku/sudoku_game',
                  arguments: {'difficulty': 'Simple'},
                );
              },
              child: const Text("Simple"),
            ),
          ),
          ListTile(
            title: FilledButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  'sudoku/sudoku_game',
                  arguments: {'difficulty': 'Intermediate'},
                );
              },
              child: const Text("Intermediate"),
            ),
          ),
          ListTile(
            title: FilledButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  'sudoku/sudoku_game',
                  arguments: {'difficulty': 'Hard'},
                );
              },
              child: const Text("Hard"),
            ),
          ),
        ],
      ),
    );
  }
}
