import 'package:bureau_couple/getx/features/widgets/custom_button%20_widget.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/theme.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/string.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/utils/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';

class HomeProfileHolder extends StatelessWidget {
  final String img;
  final String name;
  // final String email;
  final Function() tap;
  const HomeProfileHolder({super.key, required this.img, required this.name,/* required this.email, */required this.tap});

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        color: darkBlueColor.withOpacity(0.90),
      ),
      child: Row(
        children: [
          ClipOval(child: CustomImageWidget(image: img,height: 60,width: 60,)),
          sizedBoxWidth15(),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringUtils.capitalize(name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styleSatoshiBold(size: Dimensions.fontSize20, color: Colors.white),),
              sizedBox4(),
              // Text(StringUtils.capitalize(email),
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: styleSatoshiLight(size: Dimensions.fontSize10, color: Colors.white),),
              CustomButtonWidget(
                height: 30,width: 100,isBold: false,
                buttonText: 'EDIT PROFILE',
                fontSize: Dimensions.fontSize12,
                onPressed: tap,)
            ],
          ),


        ],
      ),
    );
  }
}
