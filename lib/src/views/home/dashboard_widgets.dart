import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/common_widgets.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";

otherUserdataHolder({
  required BuildContext context,
  required Function() tap,
  required String imgUrl,
  required String userName,
  required String atributeReligion,
  required String profession,
  required String Location,
  required String dob,
  required Color likedColor,
  required Color unlikeColor,
  required Widget button,
  required String height,
  required String state,
  required Widget bookmark,
  required String text,

}) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: tap,
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 500,
              width: 1.sw,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: colorDarkCyan.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: CachedNetworkImage(
                imageUrl: imgUrl, fit: BoxFit.fill,
                errorWidget: (context, url, error) => Padding(
                      padding: const EdgeInsets.all(8.0),
                  child: Image.asset(icLogo, height: 40, width: 40,),),
                progressIndicatorBuilder: (a, b, c) => customShimmer(height: 170, /*width: 0,*/),),
            ),
            Container(
              height: 500,
              width: 1.sw,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(1), Colors.transparent],
                    stops: const [0, 10],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ), borderRadius: BorderRadius.circular(20)
              ),
              // child: Image.asset(images[i],
              // height: 170,),
            ),
            Positioned(
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
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  userName, overflow: TextOverflow.ellipsis, maxLines: 1,
                                  style: styleSatoshiBold(
                                      size: 16, color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10,),
                             /* Expanded(
                                child: bookmark,
                              ),*/
                            ],
                          ),
                          Row(
                            children: [
                              Container( padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                                decoration : BoxDecoration(
                                color: Colors.greenAccent,borderRadius: BorderRadius.circular(12)
                              ),
                                child: Text(
                                  '${dob}',
                                  overflow: TextOverflow.ellipsis, maxLines: 1,
                                  style: styleSatoshiLarge(size: 16, color: Colors.black),),
                              ),
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
                                height,
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
                                atributeReligion,
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
                                      Location,
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
                                      state,

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
                          button,


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
            // Positioned(
            //   bottom: 30,left: 20,right: 0,
            //   child: Row(
            //     children: [
            //       Expanded(flex: 3,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Row(
            //               children: [
            //                 Expanded(
            //                   flex: 4,
            //                   child: Text(
            //                     userName, overflow: TextOverflow.ellipsis, maxLines: 1,
            //                     style: styleSatoshiBold(
            //                         size: 16, color: Colors.white),
            //                   ),
            //                 ),
            //                 const SizedBox(width: 10,),
            //                /* Expanded(
            //                   child: bookmark,
            //                 ),*/
            //               ],
            //             ),
            //             Row(
            //               children: [
            //                 Text(
            //                   '${dob}',
            //                   overflow: TextOverflow.ellipsis,
            //                   maxLines: 1,
            //
            //                   style: styleSatoshiLarge(
            //                       size: 16,
            //                       color: Colors.white),
            //                 ),
            //                 const SizedBox(width: 6,),
            //                 Container(
            //                   height: 4,
            //                   width: 4,
            //                   decoration: const BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //                 const SizedBox(width: 6,),
            //
            //                 Text(
            //                   height,
            //                   overflow: TextOverflow.ellipsis,
            //                   maxLines: 1, style: styleSatoshiMedium(size: 16, color: Colors.white),),
            //                 const SizedBox(width: 6,),
            //                 Container(
            //                   height: 4,
            //                   width: 4,
            //                   decoration: const BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //                 Text(
            //                   atributeReligion,
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: styleSatoshiMedium(
            //                       size: 16,
            //                       color: Colors.white),
            //                 ),
            //               ],
            //             ),
            //             // const SizedBox(height: 10,),
            //             // Text(
            //             //   atributeReligion,
            //             //   maxLines: 2,
            //             //   style: styleSatoshiMedium(
            //             //       size: 16,
            //             //       color: Colors.white),
            //             // ),
            //             const SizedBox(height: 4,),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 // const Expanded(child: Icon(Icons.location_on_sharp,color: Colors.white,),
            //                 //   // child: Image.asset(icLocation,
            //                 //   //   color: Colors.white,
            //                 //   //   height: 17,
            //                 //   //   width: 17,),
            //                 // ),
            //                 const SizedBox(width: 2,),
            //                 Expanded(
            //                   flex: 10,
            //                   child: Row(
            //                     children: [
            //                       Text(
            //                         Location,
            //                         // '${matches[i].address!.country}',
            //                         // "New York, USA",
            //                         overflow: TextOverflow.ellipsis,
            //                         maxLines: 2,
            //
            //                         style: styleSatoshiLarge(
            //                             size: 16,
            //                             color: Colors.white),
            //                       ),
            //                       const SizedBox(width: 3,),
            //                       Container(
            //                         height: 4,
            //                         width: 5,
            //                         decoration: const BoxDecoration(
            //                           shape: BoxShape.circle,
            //                           color: Colors.white,
            //                         ),
            //                       ),
            //                       const SizedBox(width: 3,),
            //
            //                       Text(
            //                         state,
            //
            //                         // '${matches[i].address!.country}',
            //                         // "New York, USA",
            //                         overflow: TextOverflow.ellipsis,
            //                         maxLines: 2,
            //
            //                         style: styleSatoshiMedium(
            //                             size: 16,
            //                             color: Colors.white),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //
            //
            //             sizedBox16(),
            //             // Align(alignment: Alignment.centerRight,
            //             //     child: Padding(
            //             //       padding: const EdgeInsets.only(right: 16.0),
            //             //       child: button,
            //             //     )),
            //           ],
            //         ),
            //       ),
            //       Expanded(child: button),
            //     ],
            //   ),
            // )

          ],
        ),
        // sizedBox16(),
    /*    Align(alignment: Alignment.centerLeft,
          child: Text(
            "About",
            style: styleSatoshiBold(size: 16, color: color1C1C1c),),
        ),
        sizedBox10(),
        ReadMoreText(
          text,
          trimLines: 4,
          colorClickableText: Colors.pink,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: ' Show less',
          moreStyle: styleSatoshiLight(size: 14, color: primaryColor),
          lessStyle: styleSatoshiLight(size: 14, color: primaryColor),
        ),*/


      ],
    ),
  );
}