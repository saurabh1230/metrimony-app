import 'package:bureau_couple/src/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:like_button/like_button.dart';

import '../../constants/textstyles.dart';
import 'buttons.dart';
Widget backButton({
  required BuildContext context,
  required String image,
  required Function() onTap,
}) {
  return  Align(
    alignment: Alignment.centerLeft,
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SizedBox(
        height: 40,
        width: 40,
        child: Material(
          clipBehavior: Clip.hardEdge,
          elevation:4,
          borderRadius: BorderRadius.circular(40),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(image,
            ),
          ),
        ),
      ),
    ),
  );
}




class ToastUtil {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

customContainer({
  required Widget child,
  required double radius,
  required Color color,
  required Function() click,
   double ? horizontal,
   double? vertical,

}) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap:click,
    child: Container(
      decoration : BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius)
      ),
      padding:  EdgeInsets.symmetric(horizontal: horizontal ?? 7.0,vertical:vertical?? 2),
      child: child,
    ),
  );
}

customDecoratedContainer({
  required Widget child,
  required double radius,
  required Color color,
  required double height,
  double? width,




}) {
  return Container(
    clipBehavior: Clip.hardEdge,
    height: height,
    width:width ??1.sw,
    decoration : BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius)
    ),
    child: child,
  );
}


Widget customShimmer({
  required double height,
  // required double width,
}) {
  return Opacity(
    opacity: 0.3,
    child: Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      child: Container(
        // width: height,
        height: height,
        //margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
            color: Colors.white,
            ),
      ),
    ),
  );
}




class CustomRefreshIndicator extends StatelessWidget {
  final Function onRefresh;
  final Widget child;
  const CustomRefreshIndicator({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 100,
      backgroundColor: Colors.white,
      color: primaryColor,
      strokeWidth: 4,
      onRefresh: () async {
        onRefresh();
      },
      child: child,
    );
  }
}


likeButton({
  required Function() click,
  required Color likedColor,
  required Color unlikeColor,
}) {
  return  LikeButton(
    onTap: click(),
    size: 22,
    circleColor:
    const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
    bubblesColor: BubblesColor(
      dotPrimaryColor: Color(0xff33b5e5),
      dotSecondaryColor: Color(0xff0099cc),
    ),
    likeBuilder: (bool isLiked) {
      return Image.asset(
        icSaved,
        color: isLiked ? likedColor : unlikeColor,
        // height: 22,
        // width: 22,
      );
    },
  );
}


Widget customCard({
  required Widget child,
  required Function() tap,
  required Color borderColor,
}) {
  return GestureDetector(
    onTap:tap ,
    child: Card(
        elevation: 2,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(12)
    ),  child: child,
        ),
    ),
  );
}