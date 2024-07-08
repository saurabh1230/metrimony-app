import 'package:bureau_couple/src/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:like_button/like_button.dart';
import 'package:dotted_border/dotted_border.dart';

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
        child: Image.asset(image,
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
    bubblesColor: const BubblesColor(
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
  );
}


class AddButton extends StatelessWidget {
  final Function() tap;
  final double? size;
  const AddButton({super.key, required this.tap, this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: tap,
        behavior: HitTestBehavior.translucent,
        child: Container(child: Image.asset(addbutton, height: size ?? 30,)));
  }
}

class TickButton extends StatelessWidget {
  final Function() tap;
  final double? size;

  const TickButton({super.key, required this.tap,  this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: tap,
        behavior: HitTestBehavior.translucent,
        child: Image.asset(tickButton,height:size ?? 30,));
  }
}



class SimmerTextHolder extends StatelessWidget {
  final double? width;
  const SimmerTextHolder({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(height: 7, width: width ??1.sw,margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: Colors.grey[300], borderRadius: BorderRadius.circular(20),
      ),);
  }
}


class CustomShimmerEffect extends StatelessWidget {
  final Widget child;
  const CustomShimmerEffect({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      direction: ShimmerDirection.ltr, child: child,
    );
  }
}


class DottedPlaceHolder extends StatelessWidget {
  final String text;
  const DottedPlaceHolder({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(2),
    dashPattern: [10, 10],
    color: Colors.grey.shade400,
    strokeWidth: 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(Icons.add,color:Colors.grey.shade400 ,),
        Text(text,style: TextStyle(color: Colors.grey.shade400),)
      ],),
    ));
  }
}
