import 'package:flutter/material.dart';
import 'package:health_tick/Theme/colors.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: darkblueColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Break Time',
            style: TextStyle(color: whiteColor, fontSize: 24),
          ),
          Text(
            'Take a five minute break to check-in on your level of fullness',
            style: TextStyle(
              color: greyColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
