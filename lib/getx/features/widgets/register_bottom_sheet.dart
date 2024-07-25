import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/constants/fonts.dart';
import '../../../src/views/signup/signup_dashboard.dart';

class RegisterBottomSheet extends StatefulWidget {
  final String emailOrPhone;
  RegisterBottomSheet ({super.key, required this.emailOrPhone});

  @override
  State<RegisterBottomSheet> createState() => _RegisterBottomSheetState();
}

class _RegisterBottomSheetState extends State<RegisterBottomSheet> {
 @override
  void initState() {
   Future.delayed(const Duration(seconds: 2), () {
     Get.back();
     Navigator.push(
       context,
       MaterialPageRoute(builder: (builder) => SignUpOnboardScreen()),
     );
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControl) {
      return  GetBuilder<ProfileController>(builder: (profileControl) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          decoration:  BoxDecoration(
              color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.paddingSizeDefault),
                topRight: Radius.circular(Dimensions.paddingSizeDefault)
            )
          ),

          width: Get.size.width,
          child:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
              Center(
              child: LoadingAnimationWidget.inkDrop(
              color: Theme.of(context).primaryColor,
              size: 50,
            ),),
                  sizedBoxDefault(),
                  Center(
                    child: Text(
                      'You Will Receive Verification Otp & Details On Your ${widget.emailOrPhone}',
                      textAlign: TextAlign.center,
                      style: kManrope16SemiBold828282.copyWith(color: Colors.black,fontWeight: FontWeight.w700,
                      fontSize: Dimensions.fontSize18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}