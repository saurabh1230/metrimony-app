import 'dart:ui';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/sizedboxe.dart';
import '../../constants/textstyles.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 1.sw, height: 1.sh,
          color: Colors.grey.withOpacity(0.1),
          child: Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: const Color(0xFF0063DC),
              rightDotColor: primaryColor,
              size: 50,
            ),),),),);
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




