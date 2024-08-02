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
            GestureDetector(
              onTap: tap,
              child: Container(
                height: 500,
                width: 1.sw,
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent],
                      stops: const [0.1, 20],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ), borderRadius: BorderRadius.circular(20)
                ),
              ),
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
                                      size: 22, color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10,),
                            ],
                          ),
                          const SizedBox(height: 6,),
                          Row(
                            children: [
                              Container( padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                                decoration : BoxDecoration(
                                color: Colors.greenAccent,borderRadius: BorderRadius.circular(12)
                              ),
                                child: Text(
                                  '${dob} ',
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
                              Container( padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                                decoration : BoxDecoration(
                                    color: Colors.yellowAccent.withOpacity(0.70),borderRadius: BorderRadius.circular(12)
                                ),
                                child: Text(
                                  '${atributeReligion} ',
                                  overflow: TextOverflow.ellipsis, maxLines: 1,
                                  style: styleSatoshiLarge(size: 16, color: Colors.black),),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 2,),
                              Expanded(
                                flex: 10,
                                child: Row(
                                  children: [
                                    Text(
                                      Location,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: styleSatoshiLarge(size: 16, color: Colors.white),),
                                    const SizedBox(width: 3,),
                                    Text(
                                      '',
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
                        ],
                      ),
                    ),

                  ],
                ),
            ),
            Positioned(top: 10, right: 16,
              child: bookmark
            ),
          ],
        ),

      ],
    ),
  );
}