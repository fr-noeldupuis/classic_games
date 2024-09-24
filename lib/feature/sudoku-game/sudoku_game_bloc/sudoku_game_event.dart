part of 'sudoku_game_bloc.dart';

sealed class SudokuGameEvent extends Equatable {
  const SudokuGameEvent();

  @override
  List<Object> get props => [];
}

final class SudokuGameSelectCellEvent extends SudokuGameEvent {
  const SudokuGameSelectCellEvent(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

final class SudokuGameClickNumberEvent extends SudokuGameEvent {
  const SudokuGameClickNumberEvent(this.number);

  final int number;

  @override
  List<Object> get props => [number];
}

final class SudokuGameClickEraseEvent extends SudokuGameEvent {
  const SudokuGameClickEraseEvent();

  @override
  List<Object> get props => [];
}

final class SudokuGameSwitchAnnotateMode extends SudokuGameEvent {
  const SudokuGameSwitchAnnotateMode();

  @override
  List<Object> get props => [];
}

final class SudokuGameClickMenuEvent extends SudokuGameEvent {
  const SudokuGameClickMenuEvent();

  @override
  List<Object> get props => [];
}
