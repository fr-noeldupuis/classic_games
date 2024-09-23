part of 'sudoku_game_bloc.dart';

abstract class SudokuGameState extends Equatable {
  SudokuGameState({
    required this.initialGrid,
    required this.currentGrid,
    required this.solutionGrid,
    String? annotations,
  }) : annotations = annotations ?? List.generate(729, (index) => "0").join();

  final String initialGrid;
  final String currentGrid;
  final String solutionGrid;
  final String annotations;

  @override
  List<Object> get props =>
      [initialGrid, currentGrid, solutionGrid, annotations];

  SudokuGameState copyWith({
    String? initialGrid,
    String? currentGrid,
    String? solutionGrid,
    String? annotations,
  });
}

class SudokuGameInitial extends SudokuGameState {
  SudokuGameInitial({
    required super.initialGrid,
    required super.currentGrid,
    required super.solutionGrid,
    super.annotations,
  });

  @override
  copyWith({
    String? initialGrid,
    String? currentGrid,
    String? solutionGrid,
    String? annotations,
  }) {
    return SudokuGameInitial(
      initialGrid: initialGrid ?? this.initialGrid,
      currentGrid: currentGrid ?? this.currentGrid,
      solutionGrid: solutionGrid ?? this.solutionGrid,
      annotations: annotations ?? this.annotations,
    );
  }
}

final class SudokuGameAnnotateMode extends SudokuGameInitial {
  SudokuGameAnnotateMode({
    required super.initialGrid,
    required super.currentGrid,
    required super.solutionGrid,
    super.annotations,
  });
}

final class SudokuGameFillMode extends SudokuGameInitial {
  SudokuGameFillMode({
    required super.initialGrid,
    required super.currentGrid,
    required super.solutionGrid,
    super.annotations,
  });
}

final class SudokuGameSelectedCellAnnotateMode extends SudokuGameAnnotateMode {
  SudokuGameSelectedCellAnnotateMode({
    required super.initialGrid,
    required super.currentGrid,
    required super.solutionGrid,
    super.annotations,
    required this.selectedCellIndex,
  });

  final int selectedCellIndex;

  @override
  List<Object> get props =>
      [initialGrid, currentGrid, solutionGrid, annotations, selectedCellIndex];
}

final class SudokuGameSelectedCellFillMode extends SudokuGameFillMode {
  SudokuGameSelectedCellFillMode({
    required super.initialGrid,
    required super.currentGrid,
    required super.solutionGrid,
    super.annotations,
    required this.selectedCellIndex,
  });

  final int selectedCellIndex;

  @override
  List<Object> get props =>
      [initialGrid, currentGrid, solutionGrid, annotations, selectedCellIndex];
}

final class SudokuGameSuccess extends SudokuGameInitial {
  SudokuGameSuccess({
    required super.initialGrid,
    required super.currentGrid,
    required super.solutionGrid,
    super.annotations,
  });
}
