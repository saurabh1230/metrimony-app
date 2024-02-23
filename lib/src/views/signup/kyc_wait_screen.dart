import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/views/signIn/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../constants/fonts.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/common_widgets.dart';

class KycWaitScreen extends StatelessWidget {
  const KycWaitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: backButton(context: context, image: icCross, onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder) => const SignInScreen()));
              // onBackPressed(context) ;
            }),
          )
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
                Align(
                  alignment: Alignment.center,
                  child: Text('Kyc Verification',
                    style: styleSatoshiBold(size: 22, color: Colors.black),),
                ),
                sizedBox8(),
                Text("Please while kyc verfication under process you will get notified when. verification is done!",
                  textAlign: TextAlign.center,
                  style: styleSatoshiRegular(size: 18, color: Colors.black),),
                // Spacer(),
                SizedBox(height: 40,),
                button(context: context, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => const SignInScreen()));
                }, title: "Go back")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
