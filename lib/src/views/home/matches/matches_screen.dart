
import 'package:bureau_couple/getx/controllers/favourite_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/screens/filter/filter_screen.dart';
import 'package:bureau_couple/getx/features/widgets/custom_empty_match_widget.dart';
import 'package:bureau_couple/getx/features/widgets/matches_shimmer_widget.dart';

import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
import 'package:bureau_couple/src/views/home/matches/widgets/filter_screen.dart';

import 'package:get/get.dart';
import 'package:bureau_couple/src/views/home/bookmark_screen.dart';
import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizedboxe.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/loader.dart';
import '../../user_profile/user_profile.dart';
import '../dashboard_widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchesScreen extends StatefulWidget {
  final bool appbar;
  final LoginResponse response;
  final String? religion;
  final String? motherTongue;
  final String? state;
  final String? minHeight;
  final String? maxHeight;
  final String? maxWeight;
  final String? based;
  final String? community;

  const MatchesScreen({
    Key? key,
    required this.response,
    required this.appbar,
    this.religion = '',
    this.motherTongue = '',
    this.minHeight,
    this.maxHeight,
    this.maxWeight,
    this.based,
    this.state = '',
    this.community = '',
  }) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController minHeight = TextEditingController();
  final TextEditingController maxHeight = TextEditingController();
  final TextEditingController maxWeightController = TextEditingController();

  // List<bool> isbList = [];
  bool isLoading = false;
  int page = 1;
  bool loading = false;

  // int val = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('=============check');
      Get.find<MatchesController>().getMatches(
          '1',
          Get.find<ProfileController>()
                  .profile!
                  .basicInfo!
                  .gender!
                  .contains('Male')
              ? "Female"
              : Get.find<ProfileController>()
                      .profile!
                      .basicInfo!
                      .gender!
                      .contains('Female')
                  ? "Male"
                  : "Others",
          widget.religion.toString(),
          '',
          widget.state.toString(),
          '',
          '',
          widget.motherTongue.toString(),
          widget.community.toString());
      // Get.find<MatchesController>().getMatchesList(
      //     "1",
      //     widget.response.data!.user!.gender!.contains('Male')
      //         ? "Female"
      //         : widget.response.data!.user!.gender!.contains('Female')
      //         ? "Male"
      //         : "Others",
      //     widget.religion!,
      //      widget.state!,
      //     minHeight.text,
      //     maxHeight.text,
      //     maxWeightController.text,
      //     widget.motherTongue!,
      //     widget.community!);
      // Get.find<AuthController>().getReligionsList();
      // Get.find<AuthController>().getCommunityList();
      // Get.find<AuthController>().getMotherTongueList();
      // Get.find<ProfileController>().getBasicInfoApi();
    });
    // getMatches();
  }

  LoginResponse? response;
  String religionFilter = '';
  String marriedFilter = '';
  double _value = 5.0;
  double height = 0;
  String? religionValue;
  String? marriedValue;
  String? motherTongueValue;
  String motherTongueFilter = '';
  final stateController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Get.find<MatchesController>().setOffset(1);
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
    //       Get.find<MatchesController>().matchesList != null &&
    //       !Get.find<MatchesController>().isLoading) {
    //     if (Get.find<MatchesController>().offset < 8) {
    //       print(
    //           "print ===========> offset before ${Get.find<MatchesController>().offset}");
    //       // Get.find<RestaurantController>().setOffset(Get.find<RestaurantController>().offset+1);
    //       // customPrint('end of the page');
    //       Get.find<MatchesController>()
    //           .setOffset(Get.find<MatchesController>().offset + 1);
    //       Get.find<MatchesController>().showBottomLoader();
    //       Get.find<MatchesController>().getMatchesList(
    //           Get.find<MatchesController>().offset.toString(),
    //           widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
    //           widget.religion!,
    //           stateController.text,
    //           minHeight.text,
    //           maxHeight.text,
    //           maxWeightController.text,
    //           widget.motherTongue!,
    //           widget.community!,
    //       );
    //       Get.find<MatchesController>().offset.toString();
    //     }
    //   }
    // });

    return Scaffold(
      appBar: const CustomAppBar(title: '',isBackButtonExist : true,),
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   centerTitle: false,
      //   automaticallyImplyLeading: false,
      //   title: Text(
      //     "Matches",
      //     style: styleSatoshiBold(size: 20, color: Colors.white),
      //   ),
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (builder) => const SavedMatchesScreen()));
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.only(
      //           right: 16.0,
      //         ),
      //         child: SvgPicture.asset(
      //           sortList,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     GestureDetector(
      //       behavior: HitTestBehavior.translucent,
      //       onTap: () {
      //         Get.to(FilterScreen());
      //         // Get.bottomSheet(
      //         //   FilterBottomSheet(),
      //         //   backgroundColor: Colors.transparent,
      //         //   isScrollControlled: true,
      //         // );
      //       },
      //       child: Container(
      //         padding: const EdgeInsets.only(
      //             right: 16.0, top: 6, bottom: 6, left: 10),
      //         child: SvgPicture.asset(
      //           filter,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: GetBuilder<MatchesController>(builder: (matchesControl) {
        final list = matchesControl.matchesList;
        final isListEmpty = list.isEmpty;
        return isListEmpty && !matchesControl.isLoading
            ? const Padding(
                padding: EdgeInsets.only(top: Dimensions.paddingSize100),
                child: Center(
                    child: CustomEmptyMatchScreen(
                  title: "No Matches Yet",
                  isBackButton: true,
                )))
            : matchesControl.isLoading
                ? const ShimmerWidget()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, top: 16, bottom: 0),
                    child: Stack(
                      children: [
                        Text(
                          "${matchesControl.matchesList.length} Matches Found",
                          style: styleSatoshiLight(
                              size: 14, color: Colors.black.withOpacity(0.60)),
                        ),
                        sizedBox10(),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: ListView.separated(
                            controller: scrollController,
                            itemCount: matchesControl.matchesList.length,
                            itemBuilder: (context, i) {
                              DateTime? birthDate =
                                  matchesControl.matchesList[i].basicInfo !=
                                          null
                                      ? DateFormat('yyyy-MM-dd').parse(
                                          matchesControl.matchesList[i]
                                              .basicInfo!.birthDate!)
                                      : null;
                              int age = birthDate != null
                                  ? DateTime.now()
                                          .difference(birthDate)
                                          .inDays ~/
                                      365
                                  : 0;
                              return Column(
                                children: [
                                  GetBuilder<FavouriteController>(
                                      builder: (favControl) {
                                    int? currentId =
                                        matchesControl.matchesList[i].profileId;
                                    int? matchId =
                                        matchesControl.matchesList[i].id;
                                    bool isWished = favControl.isBookmarkList
                                        .contains(currentId);
                                    bool isConnected = favControl
                                        .isConnectedIntList
                                        .contains(matchId);
                                    return otherUserdataHolder(
                                      context: context,
                                      tap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) =>
                                                UserProfileScreen(
                                                    userId: matchesControl
                                                        .matchesList[i].id
                                                        .toString()),
                                          ),
                                        );
                                      },
                                      imgUrl:
                                          '$baseProfilePhotoUrl${matchesControl.matchesList[i].image ?? ''}',
                                      state: matchesControl
                                              .matchesList[i]
                                              .basicInfo
                                              ?.presentAddress
                                              ?.state ??
                                          '',
                                      userName: matchesControl.matchesList[i]
                                                      .firstname ==
                                                  null &&
                                              matchesControl.matchesList[i]
                                                      .lastname ==
                                                  null
                                          ? "user"
                                          : '${StringUtils.capitalize(matchesControl.matchesList[i].firstname ?? 'User')} ${StringUtils.capitalize(matchesControl.matchesList[i].lastname ?? 'User')}',
                                      atributeReligion:
                                          ' ${matchesControl.matchesList[i].basicInfo?.religionName ?? ''}',
                                      profession: "Software Engineer",
                                      Location:
                                          '${matchesControl.matchesList[i].address?.state ?? ''} • ${matchesControl.matchesList[i].professionName ?? ''} • ${matchesControl.matchesList[i].communityName ?? ''} ',
                                      likedColor: Colors.grey,
                                      unlikeColor: primaryColor,
                                      button: matchesControl.matchesList[i].interestStatus == 2
                                          ? connectButton(
                                              fontSize: 14,
                                              height: 30,
                                              width: 134,
                                              context: context,
                                              onTap: () {},
                                              showIcon: isWished ? false : true,
                                              title: 'Request Sent')
                                          : connectButton(
                                              fontSize: 14,
                                              height: 30,
                                              width: 134,
                                              context: context,
                                              onTap: () {
                                                print(matchesControl
                                                    .matchesList[i].id
                                                    .toString());
                                                print(Get.find<
                                                        ProfileController>()
                                                    .userDetails!
                                                    .id!);
                                                favControl.sendRequestApi(
                                                    Get.find<
                                                            ProfileController>()
                                                        .userDetails!
                                                        .id
                                                        .toString(),
                                                    matchesControl
                                                        .matchesList[i].id
                                                        .toString());
                                              },
                                              showIcon:
                                                  isConnected ? false : true,
                                              title: isConnected
                                                  ? "Request Sent"
                                                  : "Connect Now"),
                                      bookmark: matchesControl
                                                  .matchesList[i].bookmark ==
                                              1
                                          ? GestureDetector(
                                              onTap: () {
                                                favControl.unSaveBookmarkApi(
                                                    matchesControl
                                                        .matchesList[i]
                                                        .profileId
                                                        .toString());
                                              },
                                              child: Icon(
                                                  CupertinoIcons.heart_fill,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  size: 32),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                favControl.bookMarkSaveApi(
                                                    matchesControl
                                                        .matchesList[i]
                                                        .profileId
                                                        .toString(),
                                                    Get.find<
                                                            ProfileController>()
                                                        .userDetails!
                                                        .id
                                                        .toString());
                                              },
                                              child: Icon(
                                                isWished
                                                    ? CupertinoIcons.heart_fill
                                                    : Icons.favorite_border,
                                                color: isWished
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.grey,
                                                size: 32,
                                              )),
                                      dob: '$age yrs',
                                      text: /*matchesControl.matchesList![i].basicInfo?.aboutUs ??*/
                                          '',
                                    );
                                  }),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 16,
                            ),
                          ),
                          // child: LazyLoadScrollView(
                          //   isLoading: isLoading,
                          //   onEndOfPage: () {
                          //     // if (val >= 8) {
                          //     //   loadMore();
                          //     // }
                          //   },
                          //   child: ListView.separated(
                          //     itemCount: matchesControl.matchesList!.length + 1,
                          //     itemBuilder: (context, i) {
                          //       if (i < matchesControl.matchesList!.length) {
                          //         DateTime? birthDate = matchesControl.matchesList![i].basicInfo != null
                          //             ? DateFormat('yyyy-MM-dd')
                          //             .parse(matchesControl.matchesList![i].basicInfo!.birthDate!)
                          //             : null;
                          //         int age = birthDate != null
                          //             ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                          //         return Column(
                          //           children: [
                          //             otherUserdataHolder(
                          //               context: context,
                          //               tap: () {
                          //                 Navigator.push(
                          //                   context,
                          //                   MaterialPageRoute(
                          //                     builder: (builder) =>
                          //                         UserProfileScreen(
                          //                           userId: matchesControl.matchesList![i].id.toString(),
                          //                         ),
                          //                   ),
                          //                 );
                          //               },
                          //               height:matchesControl.matchesList![i].physicalAttributes!.height == null ?
                          //                   "" :
                          //               "${matchesControl.matchesList![i].physicalAttributes!.height ??
                          //                   ''}ft",
                          //               imgUrl:
                          //               '$baseProfilePhotoUrl${matchesControl.matchesList![i].image ?? ''}',
                          //               state: matchesControl.matchesList![i]
                          //                   .basicInfo
                          //                   ?.presentAddress
                          //                   ?.state ??
                          //                   '',
                          //               userName: matchesControl.matchesList![i].firstname == null &&
                          //                   matchesControl.matchesList![i].lastname == null
                          //                   ? "user"
                          //                   : '${StringUtils.capitalize(
                          //                   matchesControl.matchesList![i].firstname ??
                          //                       'User')} ${StringUtils.capitalize(
                          //                   matchesControl.matchesList![i].lastname ?? 'User')}',
                          //               atributeReligion:
                          //               ' ${matchesControl.matchesList![i].basicInfo?.religion ??
                          //                   ''}',
                          //               profession: "Software Engineer",
                          //               Location:
                          //               '${matchesControl.matchesList![i].address!.state ?? ''}${matchesControl.matchesList![i]
                          //                   .address!.country ?? ''}',
                          //               likedColor: Colors.grey,
                          //               unlikeColor: primaryColor,
                          //               button:
                          //               connectButton(
                          //                   fontSize: 14,
                          //                   height: 30,
                          //                   width: 134,
                          //                   context: context,
                          //                   onTap: () {
                          //                     setState(() {
                          //                       like[i] = !like[i];
                          //                     });
                          //                     sendRequestApi(
                          //                         memberId: matchesControl.matchesList![i]
                          //                             .id
                          //                             .toString())
                          //                         .then((value) {
                          //                       if (value['status'] == true) {
                          //                         setState(() {
                          //                           isLoadingList[i] = false;
                          //                         });
                          //                         ToastUtil.showToast(
                          //                             "Connection Request Sent");
                          //                       } else {
                          //                         setState(() {
                          //                           isLoadingList[i] = false;
                          //                         });
                          //
                          //                         List<dynamic> errors =
                          //                         value['message']['error'];
                          //                         String errorMessage = errors
                          //                             .isNotEmpty
                          //                             ? errors[0]
                          //                             : "An unknown error occurred.";
                          //                         Fluttertoast.showToast(
                          //                             msg: errorMessage);
                          //                       }
                          //                     });
                          //                   },
                          //                   showIcon: matchesControl.matchesList![i].interestStatus == 2 ? false : true,
                          //                   title:  matchesControl.matchesList![i].interestStatus == 2 ?  "Request Sent" : "Connect Now"),
                          //               bookmark:
                          //
                          //                GestureDetector(
                          //                 onTap: () {
                          //                   // setState(() {
                          //                   //   like[i] = !like[i];
                          //                   // });
                          //                   print(matchesControl.matchesList![i].bookmark);
                          //                   matchesControl.matchesList![i].bookmark == 1 ?
                          //                   matchesControl.unSaveBookmarkApi(matchesControl.matchesList![i].profileId.toString()) :
                          //                   matchesControl.bookMarkSaveApi(matchesControl.matchesList![i].profileId.toString());
                          //                   // getMatches();
                          //                 },
                          //                 child: /*like[i] ?*/
                          //                 Icon(
                          //                   CupertinoIcons.heart_fill, color:/*like[i] ?  primaryColor :*/ Colors.grey ,
                          //                   size: 22,)
                          //                  //    :
                          //                  //
                          //                  // Icon(
                          //                  //  CupertinoIcons.heart_fill, color:  matchesControl.matchesList![i].bookmark == 1 ? primaryColor : Colors.grey,
                          //                  //  size: 22,),
                          //               ),
                          //               dob: '$age yrs',
                          //               text: '${matchesControl.matchesList![i].basicInfo?.aboutUs ??
                          //             ''}',
                          //             )
                          //           ],
                          //         );
                          //       }
                          //       if (isLoading) {
                          //         return customLoader(size: 40);
                          //       } else if (isLoading) {
                          //         return customLoader(size: 40);
                          //       } else {
                          //         return Center(child: Text(""));
                          //       }
                          //       // else {
                          //       //   if (/*val >= 8 && */isLoading) {
                          //       //     return SizedBox();
                          //       //   } else if (val < 8) {
                          //       //     return SizedBox.shrink();
                          //       //   } else {
                          //       //     return SizedBox();
                          //       //   }
                          //       // }
                          //     },
                          //     separatorBuilder: (BuildContext context, int index) =>
                          //     const SizedBox(
                          //       height: 16,
                          //     ),
                          //   ),
                        ),
                      ],
                    ),
                  );
      }),
    );
  }
}
