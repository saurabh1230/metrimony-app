import 'package:bureau_couple/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw ,
      height: 1.sh,
      color:  colorDarkCyan.withOpacity(0.10),
      child:  Center(
        child: LoadingAnimationWidget.flickr(
        leftDotColor: const Color(0xFF0063DC),
        rightDotColor: primaryColor,
        size: 50,
      ),)  ,
    );
  }
}
 Widget customLoader({
  required double size,
}) {
  return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: primaryColor,
        size: size,
      ));
 }