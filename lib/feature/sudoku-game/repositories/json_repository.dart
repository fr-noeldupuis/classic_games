import 'dart:convert';
import 'dart:math';
import 'package:classic_games/utils/logging.dart';
import 'package:flutter/services.dart' show rootBundle;

class SudokuJsonRepository {
  late final Map<String, List<SudokuGridDTO>> _sudokuGrids;

  SudokuJsonRepository() {}

  initializeRepository() async {
    logger.d("Sudoku Grids started loading");
    String jsonString = await rootBundle.loadString('assets/sudoku_grids.json');

    List<dynamic> jsonResponse = jsonDecode(jsonString);

    List<SudokuGridDTO> grids =
        jsonResponse.map((data) => SudokuGridDTO.fromJson(data)).toList();

    Map<String, List<SudokuGridDTO>> gridMap = {};

    for (SudokuGridDTO grid in grids) {
      if (!gridMap.containsKey(grid.difficulty)) {
        gridMap[grid.difficulty] = [];
      }
      gridMap[grid.difficulty]!.add(grid);
    }
    _sudokuGrids = gridMap;
    logger.d("Sudoku Grids loaded");
  }

  getRandomGrid(String? difficulty) {
    difficulty ??= "Simple";
    List<SudokuGridDTO> grids = _sudokuGrids[difficulty]!;
    logger.d("Grids length = ${grids.length}");
    Random random = Random();
    int index = random.nextInt(grids.length);
    return grids[index];
  }
}

class SudokuGridDTO {
  final String initialGrid;
  final String solutionGrid;
  final String difficulty;

  SudokuGridDTO({
    required this.initialGrid,
    required this.solutionGrid,
    required this.difficulty,
  });

  factory SudokuGridDTO.fromJson(Map<String, dynamic> json) {
    return SudokuGridDTO(
      initialGrid: json['Puzzle'],
      solutionGrid: json['Solution'],
      difficulty: json['Difficulty'],
    );
  }
}
