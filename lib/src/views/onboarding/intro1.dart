import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/material.dart';



class Intro1 extends StatefulWidget {
  final Function onBackTap;
  const Intro1({Key? key, required this.onBackTap}) : super(key: key);

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(icPinkTint,
              height: 60,
            ),
          ),

          Stack(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.asset(icOnboarding1,
                      // height: 400,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(
                          icOnboarding2,
                          // height: 400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: 20,
                right: 0,
                child: Image.asset(
                  icOnboardingHeart,
                  height: 80,
                ),
              ),
              Positioned(
                top: 15,
                left: 20,
                child: Image.asset(
                  icSmileEmoji,
                  height: 20,
                  width: 20,),
              ),
              Positioned(
                bottom: 30,
                left: 50,
                child: Image.asset(
                  icHeartFire,
                  height: 20,
                  width: 20,),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text("Explore Connections and Unity on Your Journey Together.",
              textAlign: TextAlign.center,
              style: styleSatoshiBold(size: 23, color: Colors.black),),
          ),
        ],
      ),
    );
  }
}
