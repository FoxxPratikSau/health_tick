import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tick/Theme/colors.dart';
import 'package:health_tick/constants/widgets/cool_clock.dart';
import 'package:health_tick/screens/Home/view1/page1.dart';
import 'package:health_tick/screens/Home/view2/page2.dart';
import 'package:health_tick/screens/Home/view3/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OutlinePage extends StatefulWidget {
  const OutlinePage({super.key});

  @override
  State<OutlinePage> createState() => _OutlinePageState();
}

final _controller = PageController();
int currentPageIndex = 0;

class _OutlinePageState extends State<OutlinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkblueColor,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: const Color.fromARGB(255, 4, 21, 29),
          leading: const Icon(
            Icons.arrow_back,
            color: greyColor,
          ),
          title: Text(
            'Mindful Meal Timer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: greyColor,
              fontFamily: GoogleFonts.getFont('Roboto').fontFamily,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const ScaleEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: whiteColor,
                  dotColor: greyColor,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 1,
              child: PageView(
                controller: _controller,
                children: const [
                  Page1(),
                  Page2(),
                  Page3(),
                ],
              ),
            ),
            CoolClockThings(
              timerCompletionCallback: handleTimerCompletion,
            ),
            // CountdownClock()
            // // SmoothPageIndicator(controller: _controller, count: 3),
          ],
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleTimerCompletion() {
    setState(() {
      currentPageIndex = (currentPageIndex + 1) % 3; // Update the page index
      _controller.animateToPage(
        currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }
}
