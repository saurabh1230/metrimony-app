import 'dart:ui';
import 'package:shimmer/shimmer.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/sizedboxe.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: Colors.grey.withOpacity(0.1),
          child: Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: const Color(0xFF0063DC),
              rightDotColor: primaryColor,
              size: 50,
            ),
          ),
        ),
      ),
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


class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      itemCount: 7,
      itemBuilder: (context, i) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 160,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // color:Colors.red,
                        borderRadius: BorderRadius.circular(10)),

                    // child: Image.asset(images[i],
                    // height: 170,),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                            ),
                          ),
                        ],
                      ),
                      sizedBox16(),
                      Row(
                        children: [

                          Expanded(
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                            ),
                          ),

                        ],
                      ),
                      sizedBox16(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 10,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      sizedBox16(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 10,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 2,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 16,
      ),
    );
  }
}

