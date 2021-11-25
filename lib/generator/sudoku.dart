class Sudoku {
  List<List<int>> cells;
  int tries;
  int solved = 0;

  Sudoku(this.tries) {
    cells = List.generate(9, (index) => List.generate(9, (index) => 0));

    while (tries > 0) {
      tries--;
      int row = solved ~/ 9;
      int col = solved % 9;
      if (row > 8) break;
      solve(row, col);
    }
    print('*****' * 10);
    print('solved cells = ' + solved.toString());
  }

  void solve(int row, int col) {
    final nums = List.generate(9, (index) => index + 1);
    nums.shuffle();

    bool foundSolution = false;
    while (nums.isNotEmpty) {
      int num = nums.removeAt(0);
      if (checkRow(row, num) && checkCol(col, num) && checkBox(row, col, num)) {
        cells[row][col] = num;
        solved++;
        foundSolution = true;
        break;
      }
    }

    if (!foundSolution) {
      deleteRow(row);
      solved = row * 9;
    }
  }

  bool checkRow(int row, int num) {
    for (int i = 0; i < 9; i++) {
      if (cells[row][i] == num) {
        //print('error row : row = $row col = $i\n num = $num cell = ${cells[row][i]}');
        //print(this.toString());
        return false;
      }
    }
    return true;
  }

  bool checkCol(int col, int num) {
    for (int i = 0; i < 9; i++) {
      if (cells[i][col] == num) {
        //print('error col : row = $i col = $col\n num = $num cell = ${cells[i][col]}');
        //print(this.toString());
        return false;
      }
    }
    return true;
  }

  bool checkBox(int row, int col, int num) {
    final a = row ~/ 3, b = col ~/ 3;
    //print('test box : row = $row col = $col a = $a b = $b');
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (cells[(a * 3) + i][(b * 3) + j] == num) {
          //print('error box : row = $row col = $col a = $a b = $b \n num = $num '
          //    'cell = ${cells[(a*3) +i][(b*3) + j]}');
          //print(this.toString());
          return false;
        }
      }
    }
    return true;
  }

  void deleteRow(int row) {
    cells[row] = List.generate(9, (index) => 0);
  }

  bool hasZero() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (cells[i][j] == 0) return true;
      }
    }
    return false;
  }

  @override
  String toString() {
    String tmp = '';
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        tmp += cells[i][j].toString() + ' ';
      }
      tmp += '\n';
    }
    return tmp;
  }
}
