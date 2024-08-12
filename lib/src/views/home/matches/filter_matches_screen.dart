import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/features/widgets/matches_shimmer_widget.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
import 'package:bureau_couple/src/views/home/bookmark_screen.dart';
import 'package:bureau_couple/src/views/home/matches/widgets/filter_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../getx/controllers/profile_controller.dart';
import '../../../apis/members_api.dart';
import '../../../apis/members_api/bookmart_api.dart';
import '../../../apis/members_api/request_apis.dart';
import '../../../constants/string.dart';
import '../../../constants/textfield.dart';
import '../../../models/LoginResponse.dart';
import '../../../models/matches_model.dart';
import '../../../utils/urls.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/dropdown_buttons.dart';
import '../../../utils/widgets/loader.dart';
import '../../user_profile/user_profile.dart';
import '../dashboard_widgets.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterMatchesScreen extends StatefulWidget {
  final LoginResponse response;
  final String filter;
  final String motherTongue;
  final String minHeight;
  final String maxHeight;
  final String maxWeight;
  final String based;

  const FilterMatchesScreen({super.key, required this.response, required this.filter, required this.motherTongue, required this.minHeight, required this.maxHeight, required this.maxWeight, required this.based});

  @override
  State<FilterMatchesScreen> createState() => _FilterMatchesScreenState();
}

class _FilterMatchesScreenState extends State<FilterMatchesScreen> {
  String religionFilter = '';
  String marriedFilter = '';
  double _value = 5.0;

  @override
  void initState() {
    super.initState();
    // getMatches();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get.find<MatchesController>().getMatchesList(
      //     "1",
      //     widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
      //     widget.filter,
      //     stateController.text,
      //     '',
      //     '',
      //     '',
      //     widget.motherTongue,
      // '');
      Get.find<AuthController>().getReligionsList();
      Get.find<AuthController>().getCommunityList();
      Get.find<AuthController>().getMotherTongueList();
      Get.find<ProfileController>().getBasicInfoApi();

    });
  }

  List<MatchesModel> matches = [];
  List<bool> isLoadingList = [];
  bool isLoading = false;
  int page = 1;
  bool loading = false;
  List<bool> like = [];


  String? religionValue;
  String? motherTongueValue;
  String motherTongueFilter = '';
  String? marriedValue;

  String selectedCountryName = '';
  String? selectedValue;
  final countyController = TextEditingController();
  final stateController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // Get.find<MatchesController>().setOffset(1);
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent &&
    //       Get.find<MatchesController>().matchesList != null &&
    //       !Get.find<MatchesController>().isLoading) {
    //     // int pageSize = (Get.find<NewController>().pageSize! / 10).ceil();
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
    //           religionFilter,
    //           stateController.text,
    //           '',
    //           '',
    //           '',
    //           motherTongueFilter,
    //            '');
    //       Get.find<MatchesController>().offset.toString();
    //     }
    //   }
    // });




    // Get.find<MatchesController>().setOffset(1);
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent &&
    //       Get.find<MatchesController>().matchesList != null &&
    //       !Get.find<MatchesController>().isLoading) {
    //     // int pageSize = (Get.find<NewController>().pageSize! / 10).ceil();
    //     if (Get.find<MatchesController>().offset < 8) {
    //       Get.find<MatchesController>().setOffset(Get.find<MatchesController>().offset + 1);
    //       Get.find<MatchesController>().showBottomLoader();
    //       Get.find<MatchesController>().getMatchesList(
    //           Get.find<MatchesController>().offset.toString(),
    //           widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
    //           religionFilter,
    //           stateController.text,
    //           minHeight.text,
    //           maxHeight.text,
    //           maxWeightController.text,
    //           motherTongueFilter);
    //     }
    //   }
    // });
    return Scaffold(
      appBar:  AppBar(backgroundColor: primaryColor,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "Matches",
          style: styleSatoshiBold(size: 20, color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => const SavedMatchesScreen()));},
            child:  Padding(
              padding: const EdgeInsets.only(right: 16.0,),
              child: SvgPicture.asset(sortList,color: Colors.white,),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Get.bottomSheet(
                FilterBottomSheet(),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                  right: 16.0, top: 6, bottom: 6, left: 10),
              child:  SvgPicture.asset(filter,
                color: Colors.white,),
            ),
          )
        ],
      ),
      body:  GetBuilder<MatchesController>(builder: (matchesControl) {
        return
          // matchesControl.matchesList == null ?
          //    const ShimmerWidget()
          //   : matchesControl.matchesList!.isEmpty
          //   ? Center(child: const Text("No Matches Yet"))
          //   :
          matchesControl.matchesList != null ? matchesControl.matchesList!.isNotEmpty ?
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16,top: 16,bottom: 0),
            child: Stack(
              children: [
                Text("${matchesControl.matchesList!.length} Matches Found",style: styleSatoshiLight(size: 14, color: Colors.black.withOpacity(0.60)),),
                sizedBox10(),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child:  ListView.separated(controller: scrollController,
                    itemCount: matchesControl.matchesList!.length ,
                    itemBuilder: (context, i) {
                      DateTime? birthDate = matchesControl.matchesList![i].basicInfo != null
                          ? DateFormat('yyyy-MM-dd')
                          .parse(matchesControl.matchesList![i].basicInfo!.birthDate!)
                          : null;
                      int age = birthDate != null
                          ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                      return Column(
                        children: [
                          otherUserdataHolder(
                            context: context,
                            tap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) =>
                                      UserProfileScreen(
                                        userId: matchesControl.matchesList![i].id.toString(),
                                      ),
                                ),
                              );
                            },
                            // height:matchesControl.matchesList![i].physicalAttributes!.height == null ?
                            // "" :
                            // "${matchesControl.matchesList![i].physicalAttributes!.height ??
                            //     ''}ft",
                            imgUrl:
                            '$baseProfilePhotoUrl${matchesControl.matchesList![i].image ?? ''}',
                            state: matchesControl.matchesList![i]
                                .basicInfo
                                ?.presentAddress
                                ?.state ??
                                '',
                            userName: matchesControl.matchesList![i].firstname == null &&
                                matchesControl.matchesList![i].lastname == null
                                ? "user"
                                : '${StringUtils.capitalize(
                                matchesControl.matchesList![i].firstname ?? 'User')} ${StringUtils.capitalize(
                                matchesControl.matchesList![i].lastname ?? 'User')}',
                            atributeReligion:
                            ' ${matchesControl.matchesList![i].basicInfo?.religion ??
                                ''}',
                            profession: "Software Engineer",
                            Location:
                            '${matchesControl.matchesList![i].address!.state ?? ''} • ${matchesControl.matchesList![i]
                                .address!.country ?? ''} • ${matchesControl.matchesList![i]
                                .address!.district ?? ''}',
                            likedColor: Colors.grey,
                            unlikeColor: primaryColor,
                            button:
                            connectButton(
                                fontSize: 14,
                                height: 30,
                                width: 134,
                                context: context,
                                onTap: () {
                                  setState(() {
                                    like[i] = !like[i];
                                  });
                                  sendRequestApi(
                                      memberId: matchesControl.matchesList![i]
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
                                },
                                showIcon: matchesControl.matchesList![i].interestStatus == 2 ? false : true,
                                title:  matchesControl.matchesList![i].interestStatus == 2 ?  "Request Sent" : "Connect Now"),
                            bookmark:

                            GestureDetector(
                                onTap: () {
                                  print(matchesControl.matchesList![i].bookmark);
                                  matchesControl.matchesList![i].bookmark == 1 ?
                                  matchesControl.unSaveBookmarkApi(matchesControl.matchesList![i].profileId.toString()) :
                                  matchesControl.bookMarkSaveApi(matchesControl.matchesList![i].profileId.toString());
                                  // getMatches();
                                },
                                child: /*like[i] ?*/
                                const Icon(
                                  CupertinoIcons.heart_fill, color:/*like[i] ?  primaryColor :*/ Colors.grey ,
                                  size: 22,)
                              //    :
                              //
                              // Icon(
                              //  CupertinoIcons.heart_fill, color:  matchesControl.matchesList![i].bookmark == 1 ? primaryColor : Colors.grey,
                              //  size: 22,),
                            ),
                            dob: '$age yrs',
                            text:
                                '',
                          )
                        ],
                      );

                    },
                    separatorBuilder: (BuildContext context, int index) =>
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
                if (matchesControl.isLoading)
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20),
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<
                                Color>(
                                Theme.of(context).primaryColor)),
                      ))
                else
                  const SizedBox(),




              ],
            ),
          ) :
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16,top: 100),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image.asset(noMatchesHolder,height: 100,)),
                sizedBox16(),
                const Center(child: Text("No Match Found Yet!")),
                sizedBox16(),
                connectWithoutIconButton(context: context, onTap: () {
                  Navigator.pop(context);
                }, title: " Go back",iconWidget: Icon(Icons.arrow_back,color: primaryColor,))
              ],
            ),
          )  : const ShimmerWidget();


      }),);
  }
}
