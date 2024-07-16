import 'package:bureau_couple/getx/controllers/favourite_controller.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../apis/members_api/bookmart_api.dart';
import '../../apis/members_api/request_apis.dart';
import '../../apis/other_user_api/other_user_profile_details.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/string.dart';
import '../../constants/textstyles.dart';
import '../../models/other_person_details_models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/widgets/buttons.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';

import '../../utils/widgets/custom_image_widget.dart';
import '../home/profile/profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;

  const UserProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final List<String>? interest = [
    "Football",
    "Nature",
    "Language",
    "Fashion",
    "Photography",
    "Music",
    "Writing"
  ];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getProfileDetails();
  }

  OtherProfileModel model = OtherProfileModel();

  getProfileDetails() {
    isLoading = true;
    var resp = getOtherUserProfileApi(otherUserId: widget.userId);
    resp.then((value) {
      // matches.clear();
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            model = OtherProfileModel.fromJson(value);
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  DateTime? birthDate;
  int age = 0;
  bool loading = false;
  bool connected = false;
  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    String? birthDateString = model.data?.matches?.basicInfo?.birthDate;
    if (birthDateString != null) {
      birthDate = DateFormat('yyyy-MM-dd').parse(birthDateString);
      age = birthDate != null
          ? DateTime.now().difference(birthDate!).inDays ~/ 365
          : 0;
    }
    return Scaffold(
      body: isLoading
          ? const UserProfileShimmer()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(32),
                                  bottomLeft: Radius.circular(32)),
                              child: CarouselSlider.builder(
                                itemCount:
                                    model.data?.matches?.galleries?.length ?? 0,
                                itemBuilder: (ctx, index, realIndex) {
                                  return CachedNetworkImage(
                                    imageUrl: '$baseGalleryImage${model.data?.matches?.galleries?[index].image}',
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(icLogo),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            customShimmer(height: 0),
                                  );
                                },
                                options: CarouselOptions(
                                  height: 500,
                                  viewportFraction: 2,
                                  enlargeFactor: 0.3,
                                  aspectRatio: 0.8,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: ClipRect(
                                child: Container(
                                  height: 170,
                                  width: 1.sw,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.8),
                                          Colors.transparent
                                        ],
                                        stops: const [0, 10],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(32)),
                                  // child: Image.asset(images[i],
                                  // height: 170,),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  model.data?.matches?.galleries?.length ?? 0,
                                  (index) => Container(
                                    width: 40,
                                    height: 6,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: _currentIndex == index
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            /*   Positioned(
                top: 40,
                right:16,
                child: GestureDetector(
                  onTap: () {
                    model.data!.matches!.bookmark == 1 ?
                    matchesControl.unSaveBookmarkApi(matches[i].profileId.toString()) :

                    matchesControl.bookMarkSaveApi(matches[i].profileId.toString());
                    // setState(() {
                    //   like[i] = false;
                    // });
                  },
                  child: const Icon(
                    Icons.bookmark,
                    color: primaryColor,

                    size: 22,
                  ),
                ),
              ),*/
                            Positioned(
                              bottom: 30,
                              left: 40,
                              right: 0,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                "${StringUtils.capitalize(model.data!.matches!.firstname ?? '')} ${StringUtils.capitalize(model.data!.matches!.lastname ?? 'User')}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: styleSatoshiBold(
                                                    size: 16,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            /* Expanded(
                              child: bookmark,
                            ),*/
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              StringUtils.capitalize(
                                                  '$age yrs'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: styleSatoshiLarge(
                                                  size: 16,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Container(
                                              height: 4,
                                              width: 4,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              StringUtils.capitalize(
                                                  '${model.data?.matches?.physicalAttributes?.height} ft'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: styleSatoshiMedium(
                                                  size: 16,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Container(
                                              height: 4,
                                              width: 4,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              StringUtils.capitalize(model
                                                      .data
                                                      ?.matches
                                                      ?.religion!
                                                      .name ??
                                                  ''),
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
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // const Expanded(child: Icon(Icons.location_on_sharp,color: Colors.white,),
                                            //   // child: Image.asset(icLocation,
                                            //   //   color: Colors.white,
                                            //   //   height: 17,
                                            //   //   width: 17,),
                                            // ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Expanded(
                                              flex: 10,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    model.data!.matches!
                                                            .address!.country ??
                                                        '',
                                                    // '${matches[i].address!.country}',
                                                    // "New York, USA",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,

                                                    style: styleSatoshiLarge(
                                                        size: 16,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Container(
                                                    height: 4,
                                                    width: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    model
                                                            .data!
                                                            .matches!
                                                            .basicInfo!
                                                            .presentAddress!
                                                            .state ??
                                                        '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                        // Align(alignment: Alignment.centerRight,
                                        //     child: Padding(
                                        //       padding: const EdgeInsets.only(right: 16.0),
                                        //       child: button,
                                        //     )),
                                      ],
                                    ),
                                  ),
                                  /*   Expanded(child:    */ /* like[i] || matches[i].interestStatus == 2  ?*/ /*
                      TickButton(size: 50,
                        tap: () {  },)
                     */ /*       :
                      AddButton(size: 50,
                        tap: () {
                          setState(() {
                            // like[i] = !like[i];
                          });
                          sendRequestApi(
                              memberId: matches[i]
                                  .id
                                  .toString())
                              .then((value) {
                            if (value['status'] == true) {
                              setState(() {
                                isLoadingList[i] = false;
                              });
                              ToastUtil.showToast(
                                  "Connection Request Sent");
                            } else {
                              setState(() {
                                isLoadingList[i] = false;
                              });

                              List<dynamic> errors =
                              value['message']['error'];
                              String errorMessage = errors
                                  .isNotEmpty
                                  ? errors[0]
                                  : "An unknown error occurred.";
                              Fluttertoast.showToast(
                                  msg: errorMessage);
                            }
                          });
                        },),*/ /*
                ),*/
                                ],
                              ),
                            ),
                            // Positioned(
                            //   bottom: 26,
                            //   left: 26,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           Text(
                            //             "${StringUtils.capitalize(model.data!.matches!.firstname ?? '')} ${StringUtils.capitalize(model.data!.matches!.lastname ?? 'User')}",
                            //             overflow: TextOverflow.ellipsis,
                            //             maxLines: 1,
                            //             style: styleSatoshiLarge(size: 22, color: Colors.white),),
                            //
                            //         ],
                            //       ),
                            //       Text(
                            //         StringUtils.capitalize(model.data?.matches?.religion ?? ''),
                            //         style: styleSatoshiBold(size: 16, color: Colors.white),),
                            //       Row(
                            //         children: [
                            //           Text(
                            //             StringUtils.capitalize('$age yrs'),
                            //             style: styleSatoshiBold(size: 16, color: Colors.white),),
                            //           const SizedBox(width: 10,),
                            //           Text(
                            //             StringUtils.capitalize('${model.data?.matches?.physicalAttributes?.height} ft'),
                            //             style: styleSatoshiBold(size: 16, color: Colors.white),),
                            //         ],
                            //       ),
                            //       sizedBox16(),
                            //       loading ? loadingButton(
                            //           height: 30,
                            //           width: 134,
                            //           context: context) :button(
                            //           fontSize: 14,
                            //           height: 30,
                            //           width: 134,
                            //           context: context,
                            //           onTap: () {
                            //             setState(() {
                            //               loading = true;
                            //             });
                            //             sendRequestApi(memberId: model.data!.matches!.id!.toString())
                            //                 .then((value) {
                            //               if (value['status'] == true) {
                            //                 setState(() {
                            //                   loading = false;
                            //                 });
                            //                 ToastUtil.showToast("Connection Request Sent");
                            //
                            //               } else {
                            //                 setState(() {
                            //                   loading = false;
                            //                 });
                            //
                            //                 List<dynamic> errors =
                            //                 value['message']['error'];
                            //                 String errorMessage = errors.isNotEmpty
                            //                     ? errors[0]
                            //                     : "An unknown error occurred.";
                            //                 Fluttertoast.showToast(msg: errorMessage);
                            //               }
                            //             });
                            //           },
                            //           title: "Connect Now")
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 30),
                              child: backButton(
                                  context: context,
                                  image: icArrowLeft,
                                  onTap: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    sizedBox20(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          model.data!.matches!.basicInfo!.aboutUs!.isEmpty
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "About",
                                      style: styleSatoshiBold(
                                          size: 16, color: color1C1C1c),
                                    ),
                                    sizedBox10(),
                                    ReadMoreText(
                                      model.data?.matches?.basicInfo?.aboutUs ??
                                          "",
                                      trimLines: 4,
                                      colorClickableText: Colors.pink,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: ' Show less',
                                      moreStyle: styleSatoshiLight(
                                          size: 14, color: primaryColor),
                                      lessStyle: styleSatoshiLight(
                                          size: 14, color: primaryColor),
                                    ),
                                  ],
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedBox10(),
                              Text(
                                "Basic Info",
                                style: styleSatoshiBold(
                                    size: 16, color: color1C1C1c),
                              ),
                              // Text("Basic Info",style:styleSatoshiLarge(size: 16, color: Colors.black)),
                              sizedBox16(),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      buildProfileRow(
                                          image: birthHolder,
                                          title: 'Age',
                                          text: age.toString()),
                                      const Divider(),
                                      buildProfileRow(
                                          image: icHeightIcon,
                                          title: 'Height',
                                          text:
                                              "${model.data?.matches?.physicalAttributes?.height} ft" ??
                                                  ''),
                                      const Divider(),
                                      buildProfileRow(
                                          image: icReligionIcon,
                                          title: 'Religion',
                                          text: model
                                              .data!.matches!.religion!.name
                                              .toString()),
                                      const Divider(),
                                      buildProfileRow(
                                          image: icMotherToungeIcon,
                                          title: 'Mother Tongue',
                                          text: model
                                              .data!.matches!.motherTongue!.name
                                              .toString()),
                                      const Divider(),
                                      buildProfileRow(
                                          image: icMarriedStatusPro,
                                          title: 'Married Status',
                                          text: StringUtils.capitalize(model
                                                  .data!
                                                  .matches
                                                  ?.basicInfo
                                                  ?.maritalStatus ??
                                              "")),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizedBox16(),
                          Text(
                            "Professional Info",
                            style:
                                styleSatoshiBold(size: 16, color: color1C1C1c),
                          ),
                          // Text("Professional Info",style:styleSatoshiMedium(size: 16, color: primaryColor)),
                          sizedBox16(),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      icUserHeightIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                    sizedBox6(),
                                    Text(
                                      "${model.data?.matches?.physicalAttributes?.height} ft" ??
                                          "not added yet",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: styleSatoshiMedium(
                                        size: 14,
                                        color: Colors.black.withOpacity(0.70),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      icUserLocationIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                    sizedBox6(),
                                    Text(
                                      ' ${model.data!.matches!.address!.country ?? ""}',
                                      textAlign: TextAlign.center,
                                      style: styleSatoshiMedium(
                                        size: 14,
                                        color: Colors.black.withOpacity(0.70),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          sizedBox16(),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        icEducation,
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                    sizedBox6(),
                                    Text(
                                      model.data?.matches?.educationInfo?[0]
                                              .degree ??
                                          "",
                                      textAlign: TextAlign.center,
                                      style: styleSatoshiMedium(
                                        size: 14,
                                        color: Colors.black.withOpacity(0.70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      icUserBagIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                    sizedBox6(),
                                    Text(
                                      model.data!.matches!.profession!.name
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: styleSatoshiMedium(
                                        size: 14,
                                        color: Colors.black.withOpacity(0.70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          sizedBox16(),

                          Card(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 70,
                                        ),
                                        Image.asset(
                                          preferenceHolder,
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 35,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey
                                                      .withOpacity(0.40)),
                                              padding: const EdgeInsets.all(4),
                                              child: ClipOval(
                                                  child: CustomImageWidget(
                                                image: model.data?.user
                                                            ?.image !=
                                                        null
                                                    ? '$baseProfilePhotoUrl${model.data?.user?.image}'
                                                    : 'fallback_image_url_here',
                                                height: 70,
                                                width: 70,
                                              )),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey
                                                      .withOpacity(0.40)),
                                              padding: const EdgeInsets.all(4),
                                              child: ClipOval(
                                                  child: CustomImageWidget(
                                                image: model.data?.matches
                                                            ?.image !=
                                                        null
                                                    ? '$baseProfilePhotoUrl${model.data?.matches?.image}'
                                                    : 'fallback_image_url_here',
                                                height: 70,
                                                width: 70,
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 12,
                                      right: 12,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Your Match Preferences",
                                            style: styleSatoshiLight(
                                                size: 16, color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "",
                                            style: styleSatoshiLight(
                                                size: 20, color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      buildPrefProfileRow(
                                        image: icReligionIcon,
                                        title: 'Religion',
                                        text: StringUtils.capitalize(model.data
                                                ?.matches?.religion!.name ??
                                            ""),
                                        icon: model.data?.matches?.religion
                                                    ?.name ==
                                                model
                                                    .data
                                                    ?.user
                                                    ?.partnerExpectation
                                                    ?.religion!
                                                    .name
                                            ? tickHolder
                                            : crossholder,
                                      ),
                                      const Divider(),
                                      buildPrefProfileRow(
                                        image: icGotraIcon,
                                        title: 'Caste',
                                        text: StringUtils.capitalize(model.data
                                                ?.matches?.community!.name ??
                                            ""),
                                        icon: model.data?.matches?.community?.name == model
                                                    .data
                                                    ?.user
                                                    ?.partnerExpectation
                                                    ?.community!
                                                    .name
                                            ? tickHolder
                                            : crossholder,
                                      ),
                                      const Divider(),
                                      buildPrefProfileRow(
                                        image: icMotherToungeIcon,
                                        title: 'Mother Tongue',
                                        text: StringUtils.capitalize(model.data
                                                ?.matches?.motherTongue!.name ??
                                            ""),
                                        icon: model.data?.matches?.motherTongue
                                                    ?.name ==
                                                model.data?.user?.motherTongue
                                                    ?.name
                                            // ?.motherTongue!.name
                                            ? tickHolder
                                            : crossholder,
                                      ),
                                      const Divider(),
                                      buildPrefProfileRow(
                                        image: icState,
                                        title: 'State',
                                        text: StringUtils.capitalize(model.data
                                            ?.matches?.address?.state ??
                                            ""),
                                        icon: model.data?.matches?.address?.state ==
                                            model.data?.user?.address?.state
                                        // ?.motherTongue!.name
                                            ? tickHolder
                                            : crossholder,
                                      ),
                                      const Divider(),
                                      buildPrefProfileRow(
                                        image: icProfession,
                                        title: 'Profession',
                                        text: StringUtils.capitalize(model.data?.matches?.profession?.name ??
                                            ""),
                                        icon: model.data?.matches?.profession?.name ==
                                            model.data?.user?.profession?.name
                                        // ?.motherTongue!.name
                                            ? tickHolder
                                            : crossholder,),
                                      // const Divider(),
                                      // buildPrefProfileRow(
                                      //   image: icState,
                                      //   title: 'Age',
                                      //   text: StringUtils.capitalize(model.data
                                      //       ?.matches?.address?.state ??
                                      //       ""),
                                      //   icon: model.data?.matches?.address?.state ==
                                      //       model.data?.user?.address?.state
                                      //   // ?.motherTongue!.name
                                      //       ? tickHolder
                                      //       : crossholder,
                                      // ),
                                      //   buildPrefProfileRow(
                                      //     image: birthHolder,
                                      //     title: 'Age',
                                      //     text: model.data?.matches
                                      //             ?.partnerExpectation?.maxAge
                                      //             ?.toString() ??
                                      //         "",
                                      //     icon: crossholder,
                                      //   ),
                                      //   const Divider(),
                                      //   buildPrefProfileRow(
                                      //     image: icHeightIcon,
                                      //     title: 'Height',
                                      //     text:
                                      //         "Min: ${model.data?.matches?.partnerExpectation?.minHeight?.toString() ?? ''} "
                                      //         "Max: ${model.data?.matches?.partnerExpectation?.maxHeight?.toString() ?? ''} ft",
                                      //     icon: crossholder,
                                      //   ),
                                      //   const Divider(),
                                      // /*  model.data?.matches?.partnerExpectation
                                      //               ?.religion?.isEmpty ??
                                      //           true
                                      //       ? SizedBox()
                                      //       : buildPrefProfileRow(
                                      //           image: icReligionIcon,
                                      //           title: 'Religion',
                                      //           text: StringUtils.capitalize(model
                                      //                   .data
                                      //                   ?.matches
                                      //                   ?.partnerExpectation
                                      //                   ?.religion ??
                                      //               ""),
                                      //           icon: model
                                      //                       .data
                                      //                       ?.matches
                                      //                       ?.basicInfo
                                      //                       ?.religion ==
                                      //                   model
                                      //                       .data
                                      //                       ?.user
                                      //                       ?.partnerExpectation
                                      //                       ?.religion
                                      //               ? tickHolder
                                      //               : crossholder,
                                      //         ),*/
                                      //   const Divider(),
                                      // buildPrefProfileRow(
                                      //   image: icMotherToungeIcon,
                                      //   title: 'Mother Tongue',
                                      //   text: StringUtils.capitalize(
                                      //       model.data?.matches?.motherTongue!.name ??
                                      //           ""),
                                      //   icon: model.data?.matches?.basicInfo
                                      //               ?.motherTongue ==
                                      //           model
                                      //               .data
                                      //               ?.user
                                      //               ?.partnerExpectation
                                      //               ?.motherTongue
                                      //       ? tickHolder
                                      //       : crossholder,
                                      // ),
                                      // const Divider(),
                                      // buildPrefProfileRow(
                                      //   image: weightHolder,
                                      //   title: 'Weight',
                                      //   text: StringUtils.capitalize(
                                      //       'max ${model.data?.matches?.partnerExpectation?.maxWeight ?? ""}'),
                                      //   icon: model
                                      //               .data
                                      //               ?.matches
                                      //               ?.physicalAttributes
                                      //               ?.weight ==
                                      //           model
                                      //               .data
                                      //               ?.user
                                      //               ?.partnerExpectation
                                      //               ?.maxWeight
                                      //       ? crossholder
                                      //       : tickHolder,
                                      // ),
                                      // const Divider(),
                                      // buildPrefProfileRow(
                                      //   image: communityHolder,
                                      //   title: 'Community',
                                      //   text: StringUtils.capitalize(model
                                      //           .data
                                      //           ?.matches
                                      //           ?.partnerExpectation
                                      //           ?.community. ??
                                      //       ""),
                                      //   icon: crossholder,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          sizedBox16(),

                          sizedBox14(),
                         /* GetBuilder<FavouriteController>(
                              builder: (favControl) {
                                favControl.setConnected(true);*/
                            /*return*/ button(
                                fontSize: 14,
                                height: 45,
                                width: double.infinity,
                                context: context,
                                onTap: () {
                                  setState(() {
                                    connected = !connected;
                                  });
                                  sendRequestApi(
                                    memberId:
                                        model.data!.matches!.id!.toString(),
                                  ).then((value) {
                                    if (value['status'] == true) {
                                      setState(() {});
                                      ToastUtil.showToast(
                                          "Connection Request Sent");
                                    } else {
                                      setState(() {});

                                      List<dynamic> errors =
                                          value['message']['error'];
                                      String errorMessage = errors.isNotEmpty
                                          ? errors[0]
                                          : "An unknown error occurred.";
                                      Fluttertoast.showToast(msg: errorMessage);
                                    }
                                  });
                                },
                                title:  connected ? 'Request Sent' : "Connect Now"),
                          // }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Container chipBox({required String name}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(width: 0.5, color: color4B164C.withOpacity(0.20)),
          color: Colors.transparent),
      padding: const EdgeInsets.all(10),
      child: Text(
        name,
        style: styleSatoshiMedium(size: 16, color: color4B164C),
      ),
    );
  }

  Padding buildProfileRow({
    required String image,
    required String title,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 18.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SvgPicture.asset(
              image,
              height: 48,
              width: 48,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: styleSatoshiMedium(size: 14, color: color6C7378),
                ),
                SizedBox(
                  width: 280,
                  child: Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleSatoshiLarge(size: 14, color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding buildPrefProfileRow({
    required String image,
    required String title,
    required String text,
    required String icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 18.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SvgPicture.asset(
              image,
              height: 48,
              width: 48,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: styleSatoshiMedium(size: 14, color: color6C7378),
                ),
                SizedBox(
                  width: 280,
                  child: Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleSatoshiLarge(size: 14, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Image.asset(
            icon,
            height: 18,
          ))
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: SvgPicture.asset(
            icArrowBack,
            height: 24,
            width: 24,
          ),
        ),
      ),
      title: Row(
        children: [
          Center(
            child: Text(
              '${StringUtils.capitalize(model.data?.matches?.firstname ?? '')} ${StringUtils.capitalize(model.data?.matches?.lastname ?? '')}',
              style: styleSatoshiBold(size: 16, color: Colors.black),
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }
}

class UserProfileShimmer extends StatelessWidget {
  const UserProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmerEffect(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(32),
                              bottomLeft: Radius.circular(32)),
                          child: Container(
                            color: Colors.grey.withOpacity(0.40),
                            height: 400,
                            width: double.infinity,
                          )),
                      Positioned(
                        bottom: 26,
                        left: 26,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "User",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: styleSatoshiBold(
                                      size: 30, color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              StringUtils.capitalize("Religion"),
                              style: styleSatoshiBold(
                                  size: 16, color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  StringUtils.capitalize('Yrs'),
                                  style: styleSatoshiBold(
                                      size: 16, color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  StringUtils.capitalize('Height'),
                                  style: styleSatoshiBold(
                                      size: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            sizedBox16(),
                            const SimmerTextHolder(
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 30),
                        child: backButton(
                            context: context,
                            image: icArrowLeft,
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
              sizedBox20(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About",
                          style: styleSatoshiBold(size: 16, color: color1C1C1c),
                        ),
                        sizedBox10(),
                        ReadMoreText(
                          '' ?? "",
                          trimLines: 4,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: ' Show less',
                          moreStyle:
                              styleSatoshiLight(size: 14, color: primaryColor),
                          lessStyle:
                              styleSatoshiLight(size: 14, color: primaryColor),
                        ),
                      ],
                    ),
                    sizedBox16(),
                    Text(
                      "Professional Info",
                      style: styleSatoshiBold(size: 16, color: color1C1C1c),
                    ),
                    // Text("Professional Info",style:styleSatoshiMedium(size: 16, color: primaryColor)),
                    sizedBox16(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  icEducation,
                                  height: 18,
                                  width: 18,
                                ),
                              ),
                              sizedBox6(),
                              Text(
                                // '' ,
                                'Degree',
                                textAlign: TextAlign.center,
                                style: styleSatoshiMedium(
                                  size: 14,
                                  color: Colors.black.withOpacity(0.70),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                icUserBagIcon,
                                height: 20,
                                width: 20,
                              ),
                              sizedBox6(),
                              Text(
                                StringUtils.capitalize("Profession"),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: styleSatoshiMedium(
                                  size: 14,
                                  color: Colors.black.withOpacity(0.70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBox12(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                icUserHeightIcon,
                                height: 20,
                                width: 20,
                              ),
                              sizedBox6(),
                              Text(
                                "Height",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: styleSatoshiMedium(
                                  size: 14,
                                  color: Colors.black.withOpacity(0.70),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                icUserLocationIcon,
                                height: 20,
                                width: 20,
                              ),
                              sizedBox6(),
                              Text(
                                'Country',
                                textAlign: TextAlign.center,
                                style: styleSatoshiMedium(
                                  size: 14,
                                  color: Colors.black.withOpacity(0.70),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBox20(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBox10(),
                        Text(
                          "Basic Info",
                          style: styleSatoshiBold(size: 16, color: color1C1C1c),
                        ),
                        sizedBox16(),
                        const SimmerTextHolder(),
                        sizedBox16(),
                        const SimmerTextHolder(
                          width: 200,
                        ),
                        sizedBox16(),
                        const SimmerTextHolder(
                          width: 160,
                        ),
                        // Card(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: Column(children: [
                        //       buildProfileRow(image: birthHolder, title: 'Age',
                        //           text:  "Age", onTap: () {  }),
                        //       const Divider(),
                        //       buildProfileRow(image: icHeightIcon, title: 'Height',
                        //           text:
                        //            'Height', onTap: () {  }
                        //       ),
                        //       const Divider(),
                        //
                        //       buildProfileRow(image: icReligionIcon,
                        //           title: 'Religion',
                        //           text: "Religion", onTap: () {  } ),
                        //       const Divider(),
                        //       buildProfileRow(image: icMotherToungeIcon,
                        //           title: 'Mother Tongue',
                        //           text: "Mother Tongue", onTap: () {  }
                        //       ),
                        //       const Divider(),
                        //       buildProfileRow(image: icMarriedStatusPro,
                        //           title: 'Married Status',
                        //           text: "Married Status", onTap: () {  }
                        //       ),
                        //
                        //     ],),
                        //   ),
                        // ),
                        // sizedBox16(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
