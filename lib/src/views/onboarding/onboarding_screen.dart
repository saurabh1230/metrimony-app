import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/views/onboarding/welcome_screen.dart';
import 'package:bureau_couple/src/views/signIn/signin_option_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'intro1.dart';
import 'intro2.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final pageController = PageController();
  bool animate1 = false;
  bool animate2 = true;
  double percent = 0.1;
  double percent1 = 0.0;
  double percent2 = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    animation: true,
                    startAngle: 60,
                    percent: percent,
                    animateFromLastPercent: animate1,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: percent1 == 0.0 ? Colors.redAccent : Colors.blue,
                    backgroundColor: colorDCDCDC,
                  ),
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    animation: true,
                    startAngle: 120,
                    percent: percent,
                    animateFromLastPercent: animate2,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: percent2 == 0.0 ? Colors.redAccent : Colors.blue,
                    backgroundColor: colorDCDCDC,
                  ),
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    animation: true,
                    percent: percent,
                    animateFromLastPercent: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: primaryColor,
                    backgroundColor: colorDCDCDC,
                    center: GestureDetector(
                      onTap: () {
                        if (pageController.page == 0) {
                          pageController.animateToPage(
                            1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn,
                          );
                          setState(() {
                            percent = 0.5;
                            percent1 = 0.5;
                          });
                        } else if (pageController.page == 1) {
                          // Navigate directly to WelcomeScreen after the second intro screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignInOptionScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: Icon(
                          percent == 1.0 ? Icons.done : Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                Intro1(
                  onBackTap: () {
                    // Handle back navigation or any logic if needed
                  },
                ),
                Intro2(
                  onBackTap: () {
                    pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                    setState(() {
                      animate1 = false;
                      animate2 = true;
                      percent = 0.5;
                      percent1 = 0.0;
                    });
                  },
                ),
                // Remove the third intro screen (Intro3)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
