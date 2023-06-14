import 'package:flutter/material.dart';
import 'package:health_tick/Theme/colors.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: darkblueColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Finish Your Meal',
            style: TextStyle(color: whiteColor, fontSize: 24),
          ),
          Center(
            child: Text(
              'You can eat until you feel full.',
              style: TextStyle(
                color: greyColor,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
