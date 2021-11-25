import 'dart:math';

import 'package:sudoku/generator/sudoku.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/utils/enums.dart';

class Generator {
  generateBoard(GameMode mode) {
    final cells = generateSudoku();
    print(cells);
    return Board(
      cells,
      List.generate(9, (index) => List.generate(9, (index) => 0)),
      generateIsSolved(mode),
      List.generate(9, (index) => List.generate(9, (index) => false)),
    );
  }

  generateIsSolved(GameMode mode) {
    double p;
    switch (mode) {
      case GameMode.easy:
        p = 0.3;
        break;
      case GameMode.normal:
        p = 0.5;
        break;
      case GameMode.hard:
        p = 0.7;
        break;
    }
    final solved = List.generate(
        9, (index) => List.generate(9, (index) => Random().nextDouble() >= p));
    return solved;
  }

  generateSudoku() {
    while (true) {
      final sudoku = Sudoku(2000);
      if (sudoku.solved == 81) return sudoku.cells;
    }
  }
}
