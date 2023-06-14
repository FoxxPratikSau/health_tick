import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountdownClock extends StatefulWidget {
  @override
  _CountdownClockState createState() => _CountdownClockState();
}

class _CountdownClockState extends State<CountdownClock> {
  int secondsRemaining = 30;
  bool isCountingDown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 12,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 6,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.green,
                width: 6,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  painter: ClockPainter(),
                ),
                Text(
                  '00:$secondsRemaining',
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                if (!isCountingDown) {
                  startCountdown();
                }
              },
              child: Text(
                isCountingDown ? 'Pause' : 'Start',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startCountdown() {
    setState(() {
      isCountingDown = true;
    });
    countdownTimer();
  }

  void countdownTimer() async {
    while (secondsRemaining > 0) {
      await Future.delayed(Duration(seconds: 1));
      if (!isCountingDown) {
        break;
      }
      setState(() {
        secondsRemaining--;
      });
      if (secondsRemaining == 5) {
        playAlarm();
      }
    }
    setState(() {
      isCountingDown = false;
      secondsRemaining = 30;
    });
  }

  void playAlarm() {
    // Use your own method to play the alarm sound or video.
    // In this example, we're using the Flutter's services to play a local asset.
    SystemSound.play(SystemSoundType.alert);
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final tickMarkRadius = radius - 12;
    for (var i = 0; i < 60; i++) {
      final tickMarkLength = i % 5 == 0 ? 12.0 : 6.0;
      canvas.drawLine(
        center + Offset(0.0, -tickMarkRadius),
        center + Offset(0.0, -tickMarkRadius + tickMarkLength),
        paint,
      );
      canvas.rotate(2 * pi / 60);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
