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


class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmerEffect(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 2,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, i ) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 500,
                    width: 1.sw,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color:  Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    // child: Image.asset(images[i],
                  ),
                  Container(
                    child: Positioned(
                      bottom: 0,
                      left: 16,
                      right: 16,
                      child:
                      Row(
                        children: [
                          Expanded(flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SimmerTextHolder(),
                                Row(
                                  children: [
                                    Text(
                                      'Age',
                                      overflow: TextOverflow.ellipsis, maxLines: 1,
                                      style: styleSatoshiLarge(size: 16, color: Colors.white),),
                                    const SizedBox(width: 6,),
                                    Container(
                                      height: 4,
                                      width: 4,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 6,),

                                    Text(
                                      'height',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1, style: styleSatoshiMedium(size: 16, color: Colors.white),),
                                    const SizedBox(width: 6,),
                                    Container(
                                      height: 4,
                                      width: 4,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Religion',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: styleSatoshiMedium(
                                          size: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 10,),
                                // Text(
                                //   atributeReligion,
                                //   maxLines: 2,
                                //   style: styleSatoshiMedium(
                                //       size: 16,
                                //       color: Colors.white),
                                // ),
                                const SizedBox(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // const Expanded(child: Icon(Icons.location_on_sharp,color: Colors.white,),
                                    //   // child: Image.asset(icLocation,
                                    //   //   color: Colors.white,
                                    //   //   height: 17,
                                    //   //   width: 17,),
                                    // ),
                                    const SizedBox(width: 2,),
                                    Expanded(
                                      flex: 10,
                                      child: Row(
                                        children: [
                                          Text(
                                            "India",
                                            // '${matches[i].address!.country}',
                                            // "New York, USA",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,

                                            style: styleSatoshiLarge(
                                                size: 16,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(width: 3,),
                                          Container(
                                            height: 4,
                                            width: 5,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 3,),

                                          Text(
                                            "Uttar Pradesh",

                                            // '${matches[i].address!.country}',
                                            // "New York, USA",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,

                                            style: styleSatoshiMedium(
                                                size: 16,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox16(),
                                // button,


                                sizedBox16(),
                                // Align(alignment: Alignment.centerRight,
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(right: 16.0),
                                //       child: button,
                                //     )),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              sizedBox16(),


            ],
          );
        })
      ),
    );
    // return ListView.separated(
    //   padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
    //   itemCount: 7,
    //   itemBuilder: (context, i) {
    //     return  Container(
    //       height: 500,
    //       width: 1.sw,
    //       clipBehavior: Clip.hardEdge,
    //       decoration: BoxDecoration(
    //           color: Colors.grey,
    //           borderRadius: BorderRadius.circular(10)
    //       ),
    //       // child: Image.asset(images[i],
    //     );
    //     // return Shimmer.fromColors(
    //     //   baseColor: Colors.grey.shade300,
    //     //   highlightColor: Colors.grey.shade100,
    //     //   enabled: true,
    //     //   child: Container(
    //     //     child: Row(
    //     //       mainAxisAlignment: MainAxisAlignment.start,
    //     //       crossAxisAlignment: CrossAxisAlignment.center,
    //     //       children: [
    //     //         Expanded(
    //     //           child: Container(
    //     //             height: 160,
    //     //             clipBehavior: Clip.hardEdge,
    //     //             decoration: BoxDecoration(
    //     //                 color: Colors.white,
    //     //                 // color:Colors.red,
    //     //                 borderRadius: BorderRadius.circular(10)),
    //     //
    //     //             // child: Image.asset(images[i],
    //     //             // height: 170,),
    //     //           ),
    //     //         ),
    //     //         const SizedBox(
    //     //           width: 20,
    //     //         ),
    //     //         Expanded(
    //     //           flex: 2,
    //     //           child: Column(
    //     //             mainAxisAlignment: MainAxisAlignment.start,
    //     //             crossAxisAlignment: CrossAxisAlignment.start,
    //     //             children: [
    //     //               Row(
    //     //                 children: [
    //     //                   Expanded(
    //     //                     flex: 4,
    //     //                     child: Container(
    //     //                       height: 10,
    //     //                       decoration: BoxDecoration(
    //     //                           color: Colors.white,
    //     //                           borderRadius: BorderRadius.circular(16)
    //     //                       ),
    //     //                     ),
    //     //                   ),
    //     //                 ],
    //     //               ),
    //     //               sizedBox16(),
    //     //               Row(
    //     //                 children: [
    //     //
    //     //                   Expanded(
    //     //                     child: Container(
    //     //                       height: 10,
    //     //                       decoration: BoxDecoration(
    //     //                           color: Colors.white,
    //     //                           borderRadius: BorderRadius.circular(16)
    //     //                       ),
    //     //                     ),
    //     //                   ),
    //     //
    //     //                 ],
    //     //               ),
    //     //               sizedBox16(),
    //     //               Row(
    //     //                 mainAxisAlignment: MainAxisAlignment.start,
    //     //                 crossAxisAlignment: CrossAxisAlignment.start,
    //     //                 children: [
    //     //                   Expanded(
    //     //                     flex: 10,
    //     //                     child: Row(
    //     //                       children: [
    //     //                         Expanded(
    //     //                           child: Container(
    //     //                             height: 10,
    //     //                             decoration: BoxDecoration(
    //     //                                 color: Colors.white,
    //     //                                 borderRadius: BorderRadius.circular(16)
    //     //                             ),
    //     //                           ),
    //     //                         ),
    //     //                         const Expanded(
    //     //                           flex: 1,
    //     //                           child: SizedBox(),
    //     //                         ),
    //     //                       ],
    //     //                     ),
    //     //                   ),
    //     //                 ],
    //     //               ),
    //     //               sizedBox16(),
    //     //               Row(
    //     //                 mainAxisAlignment: MainAxisAlignment.start,
    //     //                 crossAxisAlignment: CrossAxisAlignment.start,
    //     //                 children: [
    //     //                   Expanded(
    //     //                     flex: 10,
    //     //                     child: Row(
    //     //                       children: [
    //     //                         Expanded(
    //     //                           child: Container(
    //     //                             height: 10,
    //     //                             decoration: BoxDecoration(
    //     //                                 color: Colors.white,
    //     //                                 borderRadius: BorderRadius.circular(16)
    //     //                             ),
    //     //                           ),
    //     //                         ),
    //     //                         const Expanded(
    //     //                           flex: 2,
    //     //                           child: SizedBox(),
    //     //                         ),
    //     //                       ],
    //     //                     ),
    //     //                   ),
    //     //                 ],
    //     //               ),
    //     //             ],
    //     //           ),
    //     //         )
    //     //       ],
    //     //     ),
    //     //   ),
    //
    //     // );
    //   },
    //   separatorBuilder: (BuildContext context, int index) => const SizedBox(
    //     height: 16,
    //   ),
    // );
  }
}

