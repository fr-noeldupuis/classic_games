import 'package:classic_games/feature/sudoku-game/repositories/json_repository.dart';
import 'package:classic_games/feature/sudoku-game/sudoku_game_bloc/sudoku_game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SudokuGame extends StatelessWidget {
  const SudokuGame({super.key});

  @override
  Widget build(BuildContext context) {
    SudokuGridDTO sudokuGridDTO =
        context.read<SudokuJsonRepository>().getRandomGrid("Easy");
    return BlocProvider(
      create: (context) => SudokuGameBloc(
        initialGrid: sudokuGridDTO.initialGrid,
        currentGrid: sudokuGridDTO.solutionGrid.replaceRange(
            sudokuGridDTO.initialGrid.indexOf("\."),
            sudokuGridDTO.initialGrid.indexOf("\.") + 1,
            "."),
        solutionGrid: sudokuGridDTO.solutionGrid,
      ),
      child: BlocListener<SudokuGameBloc, SudokuGameState>(
        listener: (context, state) {
          if (state is SudokuGameSuccess) {
            _successMessage(context);
          }
        },
        child: BlocBuilder<SudokuGameBloc, SudokuGameState>(
          builder: (context, state) {
            SudokuGameInitial currentState = state as SudokuGameInitial;
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9,
                          ),
                          itemCount: 81,
                          itemBuilder: (context, index) {
                            return SudokuGridCell(
                              index: index,
                              onTap: () =>
                                  currentState.initialGrid[index] == "."
                                      ? context
                                          .read<SudokuGameBloc>()
                                          .add(SudokuGameSelectCellEvent(index))
                                      : null,
                              selected: _isCellSelected(context, state, index),
                              value: currentState.currentGrid[index] == "."
                                  ? null
                                  : int.parse(currentState.currentGrid[index]),
                              annotations: List.generate(
                                  9,
                                  (i) => currentState.currentGrid[index] == "."
                                      ? currentState
                                              .annotations[index * 9 + i] ==
                                          "1"
                                      : false),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: GridView.count(
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              children: List.generate(
                                12,
                                (index) {
                                  if (index == 3) {
                                    return GridCommandButton(
                                      icon: const FaIcon(
                                        FontAwesomeIcons.eraser,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<SudokuGameBloc>()
                                            .add(SudokuGameClickEraseEvent());
                                      },
                                    );
                                  }
                                  if (index == 7) {
                                    return GridCommandButton(
                                      icon: const FaIcon(
                                        FontAwesomeIcons.pen,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        context.read<SudokuGameBloc>().add(
                                            SudokuGameSwitchAnnotateMode());
                                      },
                                      backgroundColor:
                                          state is SudokuGameAnnotateMode
                                              ? Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.3)
                                              : null,
                                    );
                                  }
                                  if (index == 11) {
                                    return GridCommandButton(
                                      icon: const FaIcon(
                                        FontAwesomeIcons.bars,
                                        size: 20,
                                      ),
                                      onPressed: () {},
                                    );
                                  }
                                  return GridCommandButton(
                                    text: (index + 1 - (index ~/ 4)).toString(),
                                    onPressed: () {
                                      context.read<SudokuGameBloc>().add(
                                            SudokuGameClickNumberEvent(
                                              index + 1 - (index ~/ 4),
                                            ),
                                          );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _isCellSelected(BuildContext context, SudokuGameState state, int index) {
    if (state is SudokuGameSelectedCellFillMode) {
      return state.selectedCellIndex == index;
    } else if (state is SudokuGameSelectedCellAnnotateMode) {
      return state.selectedCellIndex == index;
    }
    return false;
  }

  void _successMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Congratulations!"),
            content: const Text(
                "You have successfully completed the Sudoku puzzle!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }
}

class GridCommandButton extends StatelessWidget {
  const GridCommandButton({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.backgroundColor,
  }) : assert(text != null || icon != null);

  final String? text;
  final Widget? icon;
  final Function()? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: const BoxConstraints.tightFor(
          width: 50,
          height: 50,
        ),
        fillColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        child: text != null
            ? Text(
                text!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )
            : icon,
      ),
    );
  }
}

class SudokuGridCell extends StatelessWidget {
  const SudokuGridCell({
    super.key,
    required this.index,
    this.value,
    required this.annotations,
    this.selected = false,
    this.onTap,
  });

  final int index;
  final int? value;
  final List<bool> annotations;
  final bool selected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            border: _getBorderTypeFromIndex(index),
            color: selected
                ? Theme.of(context).primaryColor.withOpacity(0.3)
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: SudokuGridCellContent(value: value, annotations: annotations)),
    );
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
