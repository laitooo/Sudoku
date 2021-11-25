class Board {
  final List<List<int>> data;
  final List<List<int>> mySolution;
  final List<List<bool>> isSolved;
  final List<List<bool>> isCorrect;

  Board(this.data, this.mySolution, this.isSolved, this.isCorrect);

  bool hasError() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        final value = data[i][j];
        if (value == 0) return false;

        for (int k = 0; k < i; k++) {
          if (data[k][j] == value) {
            return true;
          }
        }

        for (int k = 0; k < j; k++) {
          if (data[i][k] == value) {
            return true;
          }
        }

        var x1, x2, y1, y2;
        if (j < 3) {
          y1 = 0;
          y2 = 2;
        } else if (j > 5) {
          y1 = 6;
          y2 = 8;
        } else {
          y1 = 3;
          y2 = 5;
        }
        if (i < 3) {
          x1 = 0;
          x2 = 2;
        } else if (i > 5) {
          x1 = 6;
          x2 = 8;
        } else {
          x1 = 3;
          x2 = 5;
        }

        for (int a = x1; a <= x2; a++) {
          for (int b = y1; b <= y2; b++) {
            if (a == i && b == j) continue;
            if (value == data[a][b]) {
              return true;
            }
          }
        }
      }
    }

    return false;
  }

  bool hasRightSolution() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (isSolved[i][j]) continue;
        if (mySolution[i][j] != data[i][j]) return false;
      }
    }
    return true;
  }

  bool isSolutionEmpty() {
    for (int i=0; i<9; i++) {
      for (int j=0; j<9; j++) {
        if (isSolved[i] [j]) continue;
        if (mySolution[i][j] == 0) return true;
      }
    }
    return false;
  }
}
