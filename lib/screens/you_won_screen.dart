import 'package:flutter/material.dart';
import 'package:sudoku/screens/PlayScreen.dart';
import 'package:sudoku/screens/home_screen.dart';
import 'package:sudoku/utils/enums.dart';
import 'package:sudoku/widgets/main_button.dart';

class YouWonScreen extends StatelessWidget {
  final int minutes;
  final int seconds;
  final GameMode mode;

  const YouWonScreen({
    Key key,
    @required this.minutes,
    @required this.seconds,
    @required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'You won in $minutes minutes and $seconds seconds',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 150),
              MainButton(
                text: 'Play again',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return PlayScreen(
                        mode: mode,
                      );
                    }),
                  );
                },
              ),
              SizedBox(height: 30),
              MainButton(
                text: 'Go home',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
