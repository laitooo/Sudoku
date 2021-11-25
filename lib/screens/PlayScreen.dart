import 'package:flutter/material.dart';
import 'package:sudoku/logic/generator.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/screens/home_screen.dart';
import 'package:sudoku/screens/you_won_screen.dart';
import 'package:sudoku/utils/enums.dart';
import 'package:sudoku/widgets/main_button.dart';
import 'package:sudoku/widgets/timer_text.dart';

class PlayScreen extends StatefulWidget {
  final GameMode mode;

  const PlayScreen({
    Key key,
    @required this.mode,
  }) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isPlaying = true;
  Board board;

  @override
  void initState() {
    super.initState();
    board = Generator().generateBoard(widget.mode);
  }

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.width - 50) / 9;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }),
        );
        return false;
      },
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 10),
                child: IconButton(
                  icon: Icon(Icons.close),
                  iconSize: 30,
                  color: Colors.black.withOpacity(0.5),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }),
                    );
                  },
                ),
              ),
              Center(child: TimerText(isRunning: isPlaying)),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Table(
                  children: getRows(size),
                  border: TableBorder.symmetric(
                    outside: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    inside: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: MainButton(
                  text: 'Finish',
                  onPressed: () {
                    if (board.isSolutionEmpty()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            child: Text('You have missing fields'),
                          ),
                        ),
                      );
                    } else {
                      if (board.hasRightSolution()) {
                        setState(() {
                          isPlaying = false;
                        });
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return YouWonScreen(
                              seconds: 24,
                              minutes: 2,
                              mode: widget.mode,
                            );
                          }),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              child: Text('You have incorrect fields'),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  customCell(int i, int j, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: (j == 3 || j == 6)
            ? Border(
                left: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              )
            : null,
      ),
      child: InkWell(
        child: Center(
          child: Text(
            board.isSolved[i][j]
                ? board.data[i][j] == 0
                    ? ''
                    : board.data[i][j].toString()
                : board.mySolution[i][j] == 0
                    ? ''
                    : board.mySolution[i][j].toString(),
            style: TextStyle(
              color: board.isSolved[i][j] ? Colors.blue : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: board.isSolved[i][j]
            ? null
            : () {
                setState(() {
                  if (board.mySolution[i][j] == 9) {
                    board.mySolution[i][j] = 0;
                  } else {
                    board.mySolution[i][j]++;
                  }
                });
              },
      ),
    );
  }

  List<TableCell> getRowCells(int row, double size) {
    return List.generate(
      9,
      (index) => TableCell(
        child: customCell(row, index, size),
      ),
    );
  }

  List<TableRow> getRows(double size) {
    return List.generate(
      9,
      (index) {
        return TableRow(
          children: getRowCells(index, size),
          decoration: BoxDecoration(
              border: (index == 3 || index == 6)
                  ? Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    )
                  : null),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    isPlaying = false;
  }
}
