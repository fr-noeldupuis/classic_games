import 'dart:math';

import 'package:flutter/material.dart';

class SudokuGame extends StatelessWidget {
  const SudokuGame({super.key});

  final String currentGrid =
      "...8.4.1111.2.3.4.55566.7.9999.765.4.2...8.4.1111.2.3.4.55566.7.9999.765.4.211234";
  final String currentGridAnnotations =
      "011010000001011101110101010000001100001101001011110011000101100110111001110011101000100001011000111011001001100111101111000101101110010010011100000000100001101101000111111011001111001101110011101011011111111111101001011011000101111110100111101011011000101010000000110111101111111000100100010001010000110001001100011111000100010001011110110000100011000111101011110001001111100000011001010000000111101100010010001101010110110001011010000110001000000101001001011111010100010111100110011100001101010101101001110000101101010101100110100100100001000001000111101011100101000100011111000100001110010000100000001001101001111010001100111001100011101011111001101111011011010010011101110011100100010110111000001010100010110010110110101110101";

  String generateBinaryString(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextBool() ? '1' : '0').join('');
  }

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
                value: currentGrid[index] == "."
                    ? null
                    : int.parse(currentGrid[index]),
                annotations: List.generate(
                    9,
                    (i) => currentGrid[index] == "."
                        ? currentGridAnnotations[index * 9 + i] == "1"
                        : false),
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
