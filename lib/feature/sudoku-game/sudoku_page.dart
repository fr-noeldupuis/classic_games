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
                Navigator.of(context).pushNamed('sudoku/sudoku_game');
              },
              child: const Text("New Game"),
            ),
          ),
        ],
      ),
    );
  }
}
