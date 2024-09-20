import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: FilledButton(
              onPressed: () {
                Navigator.of(context).pushNamed('sudoku_page');
              },
              child: const Text("Sudoku"),
            ),
          ),
          ListTile(
            title: FilledButton(
              onPressed: () {},
              child: const Text("Game 2"),
            ),
          ),
          ListTile(
            title: FilledButton(
              onPressed: () {},
              child: const Text("Game 3"),
            ),
          ),
        ],
      ),
    );
  }
}
