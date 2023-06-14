import 'package:flutter/material.dart';
import 'package:health_tick/Theme/colors.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: darkblueColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Nom Nom :)',
            style: TextStyle(color: whiteColor, fontSize: 24),
          ),
          Text(
            'You have 10 minutes to eat before the Pause. Focus on eating slowly',
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
