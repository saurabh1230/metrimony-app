import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/views/signIn/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';

import '../../constants/sizedboxe.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/common_widgets.dart';

class KycWaitScreen extends StatelessWidget {
  const KycWaitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: button(context: context, onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const SignInScreen()));
            }, title: "Go back"),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const SignInScreen()));
            }, icon: const Icon(Icons.close,color: Colors.white,))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sizedBox16(),
                  Image.asset(icWait,
                    height: 180,
                    width: 180,),
                  sizedBox16(),
                  Text(
                    'Thank You For Registering with us',
                    style: kManrope25Black.copyWith(fontSize: 16),
                  ),
                  sizedBox8(),
                  Center(
                    child: Text(
                      'You Will be Notified When Your Profile\n Gets approved',
                      textAlign: TextAlign.center,
                      style: kManrope14Medium626262.copyWith(color: Colors.black),
                    ),
                  ),
                  // Spacer(),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
