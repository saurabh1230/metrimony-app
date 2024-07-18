import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';

button({
  required BuildContext context,
  required Function() onTap,
  required String title,
  double ? height,
  double ? width,
  double ? radius,
  double ? fontSize,
  TextStyle  ? style,
  Color ? color,

}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ??double.infinity,
      height:height?? 48,
      decoration:  BoxDecoration(
        border: Border.all(
          width: 0.6,
          color: Colors.white
        ),
        borderRadius: BorderRadius.circular(radius??32),
        color:color ?? primaryColor,
          // gradient:LinearGradient(
          //   colors: [Color(0xffffffff), Color(0xfff7345f)],
          //   stops: [0.001, 0.5],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // )

      ),
      child: Center(
        child: Text(title,
          style:style ?? styleSatoshiBold(size: fontSize ??18, color: Colors.white),),
      ),
    ),
  );
}

connectLoadingButton({
  required BuildContext context,
  double ? height,
  double ? width,
  double ? radius,
  Color ? color,


}) {
  return Container(
    width: width ??double.infinity,
    height:height?? 48,
    decoration:  BoxDecoration(
      border: Border.all(
          width: 0.6,
          color: primaryColor,
      ),
      borderRadius: BorderRadius.circular(radius??32),
      color:color ?? primaryColor,
      // gradient:LinearGradient(
      //   colors: [Color(0xffffffff), Color(0xfff7345f)],
      //   stops: [0.001, 0.5],
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomCenter,
      // )

    ),
    child: Center(
      child: LoadingAnimationWidget.waveDots(
        color: primaryColor,
        size: 20,
      ),
    ),
  );
}

loadingButton({
  required BuildContext context,
  double ? height,
  double ? width,
  double ? radius,
  Color ? color,


}) {
  return Container(
    width: width ??double.infinity,
    height:height?? 48,
    decoration:  BoxDecoration(
      border: Border.all(
          width: 0.6,
          color: Colors.white
      ),
      borderRadius: BorderRadius.circular(radius??32),
      color:color ?? primaryColor,
      // gradient:LinearGradient(
      //   colors: [Color(0xffffffff), Color(0xfff7345f)],
      //   stops: [0.001, 0.5],
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomCenter,
      // )

    ),
    child: Center(
    child: LoadingAnimationWidget.waveDots(
      color: Colors.white,
    size: 20,
    ),
  ),
    );
}
elevatedButton({
  required BuildContext context,
  required Function() onTap,
  required String title,
  double ? height,
  double ? width,
  double ? radius,
  // double ? paddingVerticle,
  // double ? paddinghorizontal,
  TextStyle  ? style,
  Color ? color,

}) {
  return GestureDetector(
    onTap: onTap,
    child: Material(
      borderRadius: BorderRadius.circular(32),
      elevation: 2,
      child: Container(
        width: width ??double.infinity,
        height:height?? 48,
        // padding: EdgeInsets.symmetric(horizontal: paddinghorizontal ?? 0,vertical: paddingVerticle ?? 0),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(radius??32),
          color: color ?? Colors.white,
        ),
        child: Center(
          child: Text(title,
            style:style ?? styleSatoshiBold(size: 18, color: Colors.white),),
        ),
      ),
    ),
  );
}
elevatedSmallButton({
  required BuildContext context,
  required Function() onTap,
  required String title,
  // double ? height,
  // double ? width,
  double ? radius,
  double ? paddingVerticle,
  double ? paddinghorizontal,
  TextStyle  ? style,
  Color ? color,

}) {
  return GestureDetector(
    onTap: onTap,
    child: Material(
      borderRadius: BorderRadius.circular(32),
      elevation: 2,
      child: Container(
        // width: width ??double.infinity,
        // height:height?? 48,
        padding: EdgeInsets.symmetric(horizontal: paddinghorizontal ?? 0,vertical: paddingVerticle ?? 0),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(radius??32),
          color: color ?? Colors.white,
        ),
        child: Center(
          child: Text(title,
            style:style ?? styleSatoshiBold(size: 18, color: Colors.white),),
        ),
      ),
    ),
  );
}
elevatedSmallLoadingButton({
  required BuildContext context,

  // double ? height,
  // double ? width,
  double ? radius,
  double ? paddingVerticle,
  double ? paddinghorizontal,
  TextStyle  ? style,
  Color ? color,

}) {
  return GestureDetector(
    child: Material(
      borderRadius: BorderRadius.circular(32),
      elevation: 2,
      child: Container(
        // width: width ??double.infinity,
        // height:height?? 48,
        padding: EdgeInsets.symmetric(horizontal: paddinghorizontal ?? 0,vertical: paddingVerticle ?? 0),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(radius??32),
          color: color ?? Colors.white,
        ),
        child: Center(
          child: LoadingAnimationWidget.waveDots(
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    ),
  );
}
loadingElevatedButton({
  required BuildContext context,

  double ? height,
  double ? width,
  double ? radius,
  Color ? color,

}) {
  return Material(
    borderRadius: BorderRadius.circular(32),
    elevation: 2,
    child: Container(
      width: width ??double.infinity,
      height:height?? 48,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(radius??32),
        color: color ?? Colors.white,
      ),
      child: Center(
        child: LoadingAnimationWidget.waveDots(
          color: Colors.white,
          size: 20,
        ),
      ),
    ),
  );
}

socialMediaButton({
  required BuildContext context,
  required Function() onTap,
  required String title,
  required String image,

}) {
  return GestureDetector(
    onTap: onTap,
    child:  Container(
      width: double.infinity,
      height: 48,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          border: Border.all(
              width: 0.3,
              color: lightGrey.withOpacity(0.30)
          )
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image,
              height: 24,
              width: 24,),
            const SizedBox(width: 10,),
            Text(title,
              style: kManrope16MediumBlack,),
          ],
        ),
      ),
    ),
  );
}

connectButton({
  required BuildContext context,
  required Function() onTap,
  required String title,
  double ? height,
  double ? width,
  double ? radius,
  double ? fontSize,
  TextStyle  ? style,
  Color ? color,
  bool showIcon = false,

}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ??double.infinity,
      height:height?? 48,
      decoration:  BoxDecoration(
        border: Border.all(
            width: 0.6,
            color: primaryColor
        ),
        borderRadius: BorderRadius.circular(radius??32),
        color:color ?? Colors.white,
        // gradient:LinearGradient(
        //   colors: [Color(0xffffffff), Color(0xfff7345f)],
        //   stops: [0.001, 0.5],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // )
      ),
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) Icon(Icons.add, color: primaryColor, size: 15),
            // Icon(Icons.add,color: primaryColor,size: 15,),
            Text(title,
              style:style ?? styleSatoshiBold(size: fontSize ??18, color: primaryColor),),
          ],
        ),
      ),
    ),
  );
}

connectButtonLoading({
  required BuildContext context,

  double ? height,
  double ? width,
  double ? radius,
  double ? fontSize,
  TextStyle  ? style,
  Color ? color,
  bool showIcon = false,

}) {
  return Container(
    width: width ??double.infinity,
    height:height?? 48,
    decoration:  BoxDecoration(
      border: Border.all(
          width: 0.6,
          color: primaryColor
      ),
      borderRadius: BorderRadius.circular(radius??32),
      color:color ?? Colors.white,
      // gradient:LinearGradient(
      //   colors: [Color(0xffffffff), Color(0xfff7345f)],
      //   stops: [0.001, 0.5],
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomCenter,
      // )
    ),
    child: Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon) Icon(Icons.add, color: primaryColor, size: 15),
          // Icon(Icons.add,color: primaryColor,size: 15,),
          Center(
            child: LoadingAnimationWidget.waveDots(
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    ),
  );
}


connectWithoutIconButton({
  required BuildContext context,
  required Function() onTap,
  required String title,
  double ? height,
  double ? width,
  double ? radius,
  double ? fontSize,
  TextStyle  ? style,
  Color ? color,
  Widget? iconWidget,

}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ??double.infinity,
      height:height?? 48,
      decoration:  BoxDecoration(
        border: Border.all(
            width: 0.6,
            color: primaryColor
        ),
        borderRadius: BorderRadius.circular(radius??32),
        color:color ?? Colors.white,
        // gradient:LinearGradient(
        //   colors: [Color(0xffffffff), Color(0xfff7345f)],
        //   stops: [0.001, 0.5],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // )
      ),
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget ?? Icon(Icons.add,color: primaryColor,size: 15,),
            Text(title,
              style:style ?? styleSatoshiBold(size: fontSize ??18, color: primaryColor),),
          ],
        ),
      ),
    ),
  );
}
