import 'dart:io';
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/screens/connected_screen/connected_screen_dashboard.dart';
import 'package:bureau_couple/getx/features/screens/matches/matches_dashboard.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:bureau_couple/src/views/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:bureau_couple/src/views/home/matches/matches_screen.dart';
import 'package:bureau_couple/src/views/home/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import 'connect/connections.dart';

bool isClick = false;
class HomeDashboardScreen extends StatefulWidget {
  final LoginResponse response;

  const HomeDashboardScreen({super.key, required this.response, });

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {


  Future<bool> onBackMove(BuildContext context) {
    if (isClick == true) {
      setState(() {
        isClick = false;
      });
      return Future.value(false);
    } else {
      return onBackPressed(context);
    }
  }
  onBackPressed(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.exit_to_app_sharp, color: primaryColor),
              SizedBox(width: 10),
              Text('Close Application?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
            content: const Text('Are you sure you want to exit the Application?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No', style: TextStyle(fontSize: 15, color: primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop(false); //Will not exit the App
                },
              ),
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 15, color: primaryColor),
                ),
                onPressed: () {
                  exit(0);
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // Get.find<ProfileController>().getUserDetailsApi();
    Get.find<ProfileController>().getProfileDetail();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('=============check');

    });
    super.initState();
  }
   int index = 0;
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () => onBackMove(context),
      child: Scaffold(
        body: [
          HomeScreen(response: widget.response),
          const MatchesDashboard(initialIndex: 0,),
          ConnectDashboard(initialIndex: 0,),
          const ProfileScreen(),
        ][index],
        bottomNavigationBar: bottomBar(),

      ),
    );
  }

  SingleChildScrollView bottomBar() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(icHome,
                      height: 24,
                      width: 24,
                      color: index ==0 ? primaryColor : color353839,),
                      const SizedBox(height: 5,),
                      Text("Home",style: styleSatoshiMedium(size: 12,
                          color: index ==0 ? primaryColor : color353839,),)
                    ],
                  ),
                )),
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      index = 1;
                    });

                  },
                  child: Column(
                    children: [
                      Image.asset(icHomeHeart,
                        height: 24,
                        width: 24,
                        color: index ==1 ? primaryColor : color353839,),
                      const SizedBox(height: 5,),
                      Text("Matches",style: styleSatoshiMedium(size: 12,
                          color: index ==1 ? primaryColor : color353839,),)
                    ],
                  ),
                )),

            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      index = 2;
                    });

                  },
                  child: Column(
                    children: [
                      Image.asset(icConnect,
                        height: 24,
                        width: 24,
                        color: index ==2 ? primaryColor : color353839,),
                      const SizedBox(height: 5,),
                      Text("Connected",style: styleSatoshiMedium(
                          size: 12,
                          color:index ==2 ? primaryColor : color353839,),)
                    ],
                  ),
                )),
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      index = 3;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(icProfilePlaceHolder,
                        height: 24,
                        width: 24,
                       /* color: index ==3 ? primaryColor : color353839,*/),
                      const SizedBox(height: 5,),
                      Text("Profile",style: styleSatoshiMedium(size: 12,
                           color: index == 3 ? primaryColor : color353839,)
                        ,)
                    ],
                  ),
                )),


          ],
        ),
      ),
    );
  }
}
