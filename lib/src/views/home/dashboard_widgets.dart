import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/buttons.dart';
import '../../utils/widgets/common_widgets.dart';
import '../user_profile/user_profile.dart';

otherUserdataHolder({
  required BuildContext context,
  required Function() tap,
  required String imgUrl,
  required String userName,
  required String atributeReligion,
  required String profession,
  required String Location,
  required Function() bookMarkTap,
  required Color likedColor,
  required Color unlikeColor,
  required Widget button,
   Widget? bookmark,

}) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: tap,
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
                  color: colorDarkCyan.withOpacity(0.03),
                  // color:Colors.red,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: CachedNetworkImage(
                imageUrl:
                imgUrl,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) =>
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(icLogo,
                        height: 40,
                        width: 40,),
                    ),
                progressIndicatorBuilder: (a, b, c) =>
                    customShimmer(height: 170, /*width: 0,*/),
              ),

              // child: Image.asset(images[i],
              // height: 170,),
            ),
          ),
          const SizedBox(width: 20,),
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
                      child: Text(
                        userName,
                        // child: Text(filteredNames[i],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: styleSatoshiBold(
                            size: 19, color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: bookmark ??likeButton(
                          click: bookMarkTap,
                          likedColor: likedColor,
                          unlikeColor: unlikeColor
                      ),
                    ),

                    /*Expanded(
                      child: Image.asset(icBookMark,
                        height: 24,
                        width: 24,),
                    )*/
                  ],
                ),
                sizedBox10(),
                Text(
                  // '${matches[i].physicalAttributes!.height} cm • ${matches[i].religion}',
                  atributeReligion,
                  maxLines: 2,
                  style: styleSatoshiMedium(
                      size: 13,
                      color: Colors.black.withOpacity(0.80)),
                ),
                // sizedBox16(),
               /* Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(icBag,
                        height: 17,
                        width: 17,),
                    ),
                    SizedBox(width: 10,),

                    Expanded(
                      flex: 10,
                      child: Text(profession,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,

                        style: styleSatoshiMedium(
                            size: 13,
                            color: Colors.black.withOpacity(
                                0.70)),
                      ),
                    ),
                  ],
                ),*/
                sizedBox8(),
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(icLocation,
                        height: 17,
                        width: 17,),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 10,
                      child: Text(
                        Location,
                        // '${matches[i].address!.country}',
                        // "New York, USA",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,

                        style: styleSatoshiMedium(
                            size: 13,
                            color: Colors.black.withOpacity(
                                0.70)),
                      ),
                    ),
                  ],
                ),
                sizedBox16(),
                button,
              ],
            ),
          )
        ],
      ),

    ),
  );
}