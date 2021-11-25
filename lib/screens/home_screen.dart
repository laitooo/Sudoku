import 'package:flutter/material.dart';
import 'package:sudoku/screens/PlayScreen.dart';
import 'package:sudoku/utils/enums.dart';
import 'package:sudoku/widgets/main_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sudoku',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 150),
            MainButton(
              text: 'Easy',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return PlayScreen(
                      mode: GameMode.easy,
                    );
                  }),
                );
              },
            ),
            SizedBox(height: 30),
            MainButton(
              text: 'Normal',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return PlayScreen(
                      mode: GameMode.normal,
                    );
                  }),
                );
              },
            ),
            SizedBox(height: 30),
            MainButton(
              text: 'Hard',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return PlayScreen(
                      mode: GameMode.hard,
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
