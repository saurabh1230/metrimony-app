import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_dropdown_button_field.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/colors.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheetHolder extends StatelessWidget {
  final Widget child;
  CustomBottomSheetHolder ({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControl) {
      return  GetBuilder<ProfileController>(builder: (profileControl) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeDefault,),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius15),
                  topRight: Radius.circular(Dimensions.radius15),
                ),
            ),
            width: Get.size.width,
            child: Column(
              children: [
                child
          
              ],
            )
          ),
        );
      });
    });
  }
}