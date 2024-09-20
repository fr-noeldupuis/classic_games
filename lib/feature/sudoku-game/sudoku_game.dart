import 'package:flutter/material.dart';

class SudokuGame extends StatelessWidget {
  const SudokuGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
            ),
            itemCount: 81,
            itemBuilder: (context, index) {
              return SudokuGridCell(
                index: index,
                value: 4,
                annotations: List.filled(9, true),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SudokuGridCell extends StatelessWidget {
  const SudokuGridCell(
      {super.key, required this.index, this.value, required this.annotations});

  final int index;
  final int? value;
  final List<bool> annotations;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: _getBorderTypeFromIndex(index),
        ),
        child: SudokuGridCellContent(value: value, annotations: annotations));
  }

  BoxBorder _getBorderTypeFromIndex(int index) {
    int rowNumber = index ~/ 9;
    int columnNumber = index % 9;

    BorderSide defaultSide = const BorderSide(color: Colors.black, width: 0.5);
    BorderSide thickSide = const BorderSide(color: Colors.black, width: 2.0);

    BorderSide top = defaultSide;
    BorderSide right = defaultSide;
    BorderSide bottom = defaultSide;
    BorderSide left = defaultSide;

    if (rowNumber % 3 == 0) {
      top = thickSide;
    }
    if (columnNumber % 3 == 0) {
      left = thickSide;
    }
    if (rowNumber == 8) {
      bottom = thickSide;
    }
    if (columnNumber == 8) {
      right = thickSide;
    }

    return Border(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
    );
  }
}

class SudokuGridCellContent extends StatelessWidget {
  const SudokuGridCellContent(
      {super.key, this.value, required this.annotations});

  final int? value;
  final List<bool> annotations;

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      return Center(
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 9,
          itemBuilder: (context, index) {
            return Center(
              child: Text(
                annotations[index] ? (index + 1).toString() : " ",
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            );
          });
    }
  }
}
