import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'sudoku_game_event.dart';
part 'sudoku_game_state.dart';

class SudokuGameBloc extends Bloc<SudokuGameEvent, SudokuGameState> {
  SudokuGameBloc({
    required dynamic initialGrid,
    required dynamic currentGrid,
    required dynamic solutionGrid,
  }) : super(
          SudokuGameFillMode(
              initialGrid: initialGrid,
              currentGrid: currentGrid,
              solutionGrid: solutionGrid),
        ) {
    on<SudokuGameSelectCellEvent>((event, emit) {
      if (state is SudokuGameAnnotateMode) {
        emit(SudokuGameSelectedCellAnnotateMode(
          initialGrid: state.initialGrid,
          currentGrid: state.currentGrid,
          solutionGrid: state.solutionGrid,
          annotations: state.annotations,
          selectedCellIndex: event.index,
        ));
      } else {
        emit(SudokuGameSelectedCellFillMode(
          initialGrid: state.initialGrid,
          currentGrid: state.currentGrid,
          solutionGrid: state.solutionGrid,
          annotations: state.annotations,
          selectedCellIndex: event.index,
        ));
      }
    });
  }
}
