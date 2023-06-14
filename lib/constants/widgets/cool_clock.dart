import 'dart:async';
import 'dart:math' as math;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:health_tick/Theme/colors.dart';
import 'package:health_tick/constants/widgets/button1.dart';
import 'package:health_tick/constants/widgets/button2.dart';

class CoolClockThings extends StatefulWidget {
  final Function timerCompletionCallback; // Callback function
  const CoolClockThings({
    Key? key,
    required this.timerCompletionCallback,
  }) : super(key: key);

  @override
  State<CoolClockThings> createState() => _CoolClockThingsState();
}

class _CoolClockThingsState extends State<CoolClockThings>
    with SingleTickerProviderStateMixin {
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  late AnimationController animationController;
  late Animation<double> animation;
  Timer? timer;
  bool isRunning = false;
  bool isPaused = false;
  bool switchValue = false;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: maxSeconds),
    );
    animation = Tween<double>(begin: maxSeconds.toDouble(), end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1),
      ),
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        stopTimer();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      seconds = maxSeconds;
    });
    animationController.reset();
    animationController.forward();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    animationController.stop();
    animationController.reset();
    timer?.cancel();
    setState(() {
      seconds = maxSeconds;
    });
    isRunning = false;
    isPaused = false;
    widget.timerCompletionCallback();
  }

  void resetTimer() {
    animationController.reset();
    animationController.forward();
    animationController.reset();
    timer?.cancel();
    setState(() {
      seconds = maxSeconds;
    });
    isRunning = false;
    isPaused = false;
  }

  void toggleTimer() {
    if (isRunning) {
      if (isPaused) {
        // Resume the timer
        animationController.forward();
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            if (seconds > 0) {
              seconds--;
            } else {
              stopTimer();
            }
          });
        });
      } else {
        // Pause the timer
        animationController.stop();
        timer?.cancel();
      }
      isPaused = !isPaused; // Update isPaused value
    } else {
      startTimer();
      isRunning = true; // Update isRunning value
    }
  }

  Future<void> playAlarmSound() async {
    const alarmPath = 'assets/sounds/countdown_tick.mp3';

    try {
      final audioPlayer = AudioPlayer();
      print('Before audioPlayer.play()');
      audioPlayer.play(alarmPath, volume: 1.0);
      print('After audioPlayer.play()');
      audioPlayer.setReleaseMode(ReleaseMode.LOOP);
      audioPlayer.onPlayerCompletion.listen((event) {
        audioPlayer.seek(Duration.zero);
        audioPlayer.resume();
      });
    } catch (e) {
      print('Error playing alarm sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Stack(
              children: [
                CustomPaint(
                  painter: GreyCirclePainter(),
                  size: const Size(200, 200),
                ),
                CustomPaint(
                  painter: WhiteCirclePainter(),
                  size: const Size(175, 175),
                ),
                AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    return CustomPaint(
                      painter: GreenCirclePainter(
                        animationValue: animation.value,
                      ),
                      size: const Size(200, 200),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    return CustomPaint(
                      painter: DashPainter(animationValue: animation.value),
                      size: const Size(125, 125),
                    );
                  },
                ),
                buildTime(),
                buildText(),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            Switch(
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              value: switchValue,
              onChanged: (newValue) {
                setState(() {
                  switchValue = newValue;
                  print('Switch value: $switchValue');
                  if (newValue && seconds <= 5) {
                    print("Playing alarm sound...");
                    playAlarmSound();
                  }
                });
              },
            ),
            const Text(
              "Sounds On",
              style: TextStyle(color: whiteColor),
            )
          ],
        ),
        const SizedBox(height: 20),
        SmallButton(
          onTap: toggleTimer,
          label: isRunning ? (isPaused ? 'RESUME' : 'PAUSE') : 'START',
        ),
        const SizedBox(height: 10),
        isRunning
            ? TransparentButton(
                onTap: stopTimer,
                label: "LET'S STOP I'M FULL NOW",
              )
            : const SizedBox(height: 10)
      ],
    );
  }

  Widget buildTime({double offsetX = 65.0, double offsetY = 65.0}) {
    String timeText = '00:$seconds';
    if (seconds < 10) {
      timeText = '00:0$seconds'; // Update time text with leading zero
    }
    return Positioned(
      left: offsetX,
      top: offsetY,
      child: Text(
        timeText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget buildText({double offsetX = 40.0, double offsetY = 100.0}) {
    return Positioned(
      left: offsetX,
      top: offsetY,
      child: const Text(
        'minutes remaining',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
    );
  }
}

// Custom painters and other code...

class GreyCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 1.5;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class WhiteCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final centerX = size.width / 1.75;
    final centerY = size.height / 1.75;
    final radius = size.width / 1.5;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class GreenCirclePainter extends CustomPainter {
  final double animationValue;

  GreenCirclePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    if (animationValue == 0) {
      return; // Skip drawing the arc when animation value is 0
    }

    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2 - paint.strokeWidth / 2;

    final progressAngle = 2 *
        3.1415 *
        (animationValue / 30); // Calculate the angle based on animation value

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -3.1415 / 2, // Start angle at -90 degrees (12 o'clock position)
      progressAngle, // Sweep the arc in a counter-clockwise direction
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashPainter extends CustomPainter {
  final int dashCount = 30;
  final double dashLength = 8.0;
  final double dashSpacing = 4.0;
  final Color dashColor = Colors.green;
  final Color dashGreyColor = Colors.grey;

  final double animationValue;

  DashPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 1.25;
    final centerY = size.height / 1.25;
    final radius = size.width / 1.6;

    final angleIncrement = 2 * math.pi / dashCount;

    final dashPaint = Paint()..strokeWidth = 2.0;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = -math.pi / 2 + angleIncrement * i;

      final startX = centerX + math.cos(startAngle) * radius;
      final startY = centerY + math.sin(startAngle) * radius;

      final endX = centerX + math.cos(startAngle) * (radius + dashLength);
      final endY = centerY + math.sin(startAngle) * (radius + dashLength);

      final startPoint = Offset(startX, startY);
      final endPoint = Offset(endX, endY);

      final currentDashColor =
          i < animationValue.toInt() ? dashColor : dashGreyColor;

      dashPaint.color = currentDashColor;

      canvas.drawLine(startPoint, endPoint, dashPaint);
    }
  }

  @override
  bool shouldRepaint(DashPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
