import 'package:bloc/bloc.dart';
import 'package:classic_games/utils/logging.dart';
import 'package:equatable/equatable.dart';

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
    on<SudokuGameSwitchAnnotateMode>(
      (event, emit) {
        logger.d(
            'Runtime type = ${state.runtimeType.toString()} -- ${state is SudokuGameFillMode}');
        if (state is SudokuGameFillMode) {
          logger.d('Switching to Annotate Mode');
          if (state is SudokuGameSelectedCellFillMode) {
            logger.d('Switching to Selected Cell Annotate Mode');
            emit(SudokuGameSelectedCellAnnotateMode(
              initialGrid: state.initialGrid,
              currentGrid: state.currentGrid,
              solutionGrid: state.solutionGrid,
              annotations: state.annotations,
              selectedCellIndex:
                  (state as SudokuGameSelectedCellFillMode).selectedCellIndex,
            ));
          } else {
            logger.d('Switching to Annotate Mode');
            emit(SudokuGameAnnotateMode(
              initialGrid: state.initialGrid,
              currentGrid: state.currentGrid,
              solutionGrid: state.solutionGrid,
              annotations: state.annotations,
            ));
          }
        } else {
          if (state is SudokuGameSelectedCellAnnotateMode) {
            logger.d('Switching to Selected Cell Fill Mode');
            emit(SudokuGameSelectedCellFillMode(
              initialGrid: state.initialGrid,
              currentGrid: state.currentGrid,
              solutionGrid: state.solutionGrid,
              annotations: state.annotations,
              selectedCellIndex: (state as SudokuGameSelectedCellAnnotateMode)
                  .selectedCellIndex,
            ));
          } else {
            logger.d('Switching to Fill Mode');
            emit(SudokuGameFillMode(
              initialGrid: state.initialGrid,
              currentGrid: state.currentGrid,
              solutionGrid: state.solutionGrid,
              annotations: state.annotations,
            ));
          }
        }
      },
    );
    on<SudokuGameClickNumberEvent>(
      (event, emit) {
        logger.d('Click Number Event: ${event.number}');
        if (state is SudokuGameSelectedCellAnnotateMode) {
          final selectedCellIndex =
              (state as SudokuGameSelectedCellAnnotateMode).selectedCellIndex;
          final int annotationIndex =
              9 * selectedCellIndex + (event.number - 1);
          final value = state.annotations[annotationIndex] == "1" ? "0" : "1";
          final annotations = state.annotations
              .replaceRange(annotationIndex, annotationIndex + 1, value);
          emit(SudokuGameSelectedCellAnnotateMode(
            initialGrid: state.initialGrid,
            currentGrid: state.currentGrid,
            solutionGrid: state.solutionGrid,
            annotations: annotations,
            selectedCellIndex: selectedCellIndex,
          ));
        } else if (state is SudokuGameSelectedCellFillMode) {
          logger.d('Click Number Event: ${event.number}');
          final selectedCellIndex =
              (state as SudokuGameSelectedCellFillMode).selectedCellIndex;
          final currentGrid = state.currentGrid.replaceRange(selectedCellIndex,
              selectedCellIndex + 1, event.number.toString());
          final annotations = state.annotations.replaceRange(
              selectedCellIndex * 9, selectedCellIndex * 9 + 9, "0" * 9);
          logger.d(currentGrid);
          logger.d(solutionGrid);
          if (currentGrid == state.solutionGrid) {
            emit(SudokuGameSuccess(
              initialGrid: initialGrid,
              currentGrid: currentGrid,
              solutionGrid: solutionGrid,
              annotations: annotations,
            ));
          } else {
            emit(SudokuGameSelectedCellFillMode(
              initialGrid: state.initialGrid,
              currentGrid: currentGrid,
              solutionGrid: state.solutionGrid,
              annotations: annotations,
              selectedCellIndex: selectedCellIndex,
            ));
          }
        }
      },
    );
    on<SudokuGameClickEraseEvent>(
      (event, emit) {
        final selectedCellIndex =
            (state as SudokuGameSelectedCellFillMode).selectedCellIndex;
        final currentGrid = state.currentGrid
            .replaceRange(selectedCellIndex, selectedCellIndex + 1, ".");
        emit(SudokuGameSelectedCellFillMode(
          initialGrid: state.initialGrid,
          currentGrid: currentGrid,
          solutionGrid: state.solutionGrid,
          annotations: state.annotations,
          selectedCellIndex: selectedCellIndex,
        ));
      },
    );
  }
}
