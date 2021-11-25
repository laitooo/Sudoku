import 'package:flutter/material.dart';

class TimerText extends StatefulWidget {
  final bool isRunning;

  const TimerText({Key key, this.isRunning}) : super(key: key);

  @override
  _TimerTextState createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  int seconds = 0;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    updateTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayTime(seconds),
      style: TextStyle(
        color: Colors.blue,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String displayTime(int seconds) {
    int mins = seconds ~/ 60;
    int remain = seconds % 60;
    return (mins > 9 ? "$mins" : "0$mins") +
        ":" +
        (remain > 9 ? "$remain" : "0$remain");
  }

  void updateTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (widget.isRunning && !isDisposed) {
        setState(() {
          seconds++;
        });
        updateTimer();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
