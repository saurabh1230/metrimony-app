import 'package:bureau_couple/getx/controllers/favourite_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/features/widgets/matches_shimmer_widget.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../apis/members_api/bookmart_api.dart';
import '../../apis/members_api/request_apis.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/string.dart';
import '../../constants/textfield.dart';
import '../../constants/textstyles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/saved_matches_model.dart';
import '../../utils/widgets/buttons.dart';
import '../../utils/widgets/common_widgets.dart';
import '../../utils/widgets/loader.dart';
import '../user_profile/user_profile.dart';
import 'dashboard_widgets.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class SavedMatchesScreen extends StatefulWidget {
  const SavedMatchesScreen({super.key});

  @override
  State<SavedMatchesScreen> createState() => _SavedMatchesScreenState();
}

class _SavedMatchesScreenState extends State<SavedMatchesScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<MatchesController>().getSavedMatchesList(
        "1",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<MatchesController>().setOffset(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          Get.find<MatchesController>().savedMatchesList != null &&
          !Get.find<MatchesController>().isLoading) {
        // int pageSize = (Get.find<NewController>().pageSize! / 10).ceil();
        if (Get.find<MatchesController>().offset < 8) {
          print(
              "print ===========> offset before ${Get.find<MatchesController>().offset}");
          // Get.find<RestaurantController>().setOffset(Get.find<RestaurantController>().offset+1);
          // customPrint('end of the page');
          Get.find<MatchesController>()
              .setOffset(Get.find<MatchesController>().offset + 1);
          Get.find<MatchesController>().showBottomLoader();
          Get.find<MatchesController>().getSavedMatchesList(
            Get.find<MatchesController>().offset.toString(),
          );
          Get.find<MatchesController>().offset.toString();
        }
      }
    });

    return GetBuilder<MatchesController>(builder: (matchesControl) {
      return Scaffold(
        appBar: const CustomAppBar(
          title: "Shortlisted",
          isBackButtonExist: true,
        ),
        body: matchesControl.isLoading
            ? const ShimmerWidget()
            : CustomRefreshIndicator(
                onRefresh: () {
                  return Get.find<MatchesController>().getSavedMatchesList(
                    "1",
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, top: 10, bottom: 20),
                  child: matchesControl.savedMatchesList == null ||
                          matchesControl.savedMatchesList!.isEmpty
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, top: 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: Image.asset(
                                noMatchesHolder,
                                height: 100,
                              )),
                              sizedBox16(),
                              const Center(
                                  child: Text("No Saved Matches Yet!")),
                              sizedBox16(),
                              connectWithoutIconButton(
                                  context: context,
                                  onTap: () {
                                    Get.back();
                                  },
                                  title: " Go back",
                                  iconWidget: const Icon(
                                    Icons.arrow_back,
                                    color: primaryColor,
                                  ))
                            ],
                          ),
                        ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox13(),
                            Text(
                              "${matchesControl.savedMatchesList!.length} matches shortlisted",
                              style: styleSatoshiLight(
                                  size: 16, color: Colors.black),
                            ),
                            sizedBox13(),
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount:
                                    matchesControl.savedMatchesList!.length,
                                itemBuilder: (context, i) {
                                  DateTime? birthDate = matchesControl
                                              .savedMatchesList![i]
                                              .profile
                                              ?.basicInfo !=
                                          null
                                      ? DateFormat('yyyy-MM-dd').parse(
                                          matchesControl.savedMatchesList![i]
                                              .profile!.basicInfo!.birthDate!)
                                      : null;
                                  int age = birthDate != null
                                      ? DateTime.now()
                                              .difference(birthDate)
                                              .inDays ~/
                                          365
                                      : 0;
                                  return GetBuilder<FavouriteController>(
                                      builder: (favControl) {
                                    int? currentId = matchesControl
                                        .matchesList[i].profileId;
                                    bool isWished = favControl.isBookmarkList
                                        .contains(currentId);

                                    return otherUserdataHolder(
                                      context: context,
                                      tap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    UserProfileScreen(userId: matchesControl.savedMatchesList![i].id.toString(),
                                                    ),
                                            ),
                                        );
                                      },
                                      imgUrl:
                                          '$baseProfilePhotoUrl${matchesControl.savedMatchesList![i].profile?.image ?? ''}',
                                      userName: matchesControl
                                                      .savedMatchesList![i]
                                                      .profile
                                                      ?.firstname ==
                                                  null &&
                                              matchesControl
                                                      .savedMatchesList![i]
                                                      .profile
                                                      ?.lastname ==
                                                  null
                                          ? "user"
                                          : '${StringUtils.capitalize(matchesControl.savedMatchesList![i].profile?.firstname ?? 'User')} ${StringUtils.capitalize(matchesControl.savedMatchesList![i].profile?.lastname ?? 'User')}',
                                      atributeReligion:
                                          " Religion: ${StringUtils.capitalize(matchesControl.savedMatchesList![i].profile?.basicInfo?.religion ?? "")}",
                                      profession: "Software Engineer",
                                      Location: matchesControl
                                              .savedMatchesList![i]
                                              .profile
                                              ?.basicInfo
                                              ?.presentAddress
                                              ?.country ??
                                          "",
                                      likedColor: Colors.grey,
                                      unlikeColor: primaryColor,
                                      button: button(
                                          fontSize: 14,
                                          height: 30,
                                          width: 134,
                                          context: context,
                                          onTap: () {
                                            sendRequestApi(
                                                    memberId: matchesControl.savedMatchesList![i].id.toString())
                                                .then((value) {
                                              if (value['status'] == true) {
                                                setState(() {});
                                                ToastUtil.showToast("Connection Request Sent");
                                              } else {
                                                setState(() {
                                                  // isLoadingList[i] = false;
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
                                          title: "Connect Now"),
                                      bookmark: matchesControl
                                                  .matchesList[i].bookmark ==
                                              1
                                          ? GestureDetector(
                                              onTap: () {
                                                favControl.unSaveBookmarkApi(
                                                    matchesControl
                                                        .matchesList[i].id
                                                        .toString());
                                              },
                                              child: Icon(
                                                  isWished
                                                      ? CupertinoIcons.heart_fill : Icons.favorite_border,
                                                  color: isWished ? Theme.of(context).primaryColor : Colors.grey,
                                                  size: 32),
                                            ) : const SizedBox(),
                                      dob: '$age yrs',
                                      state: matchesControl.savedMatchesList![i].profile?.basicInfo?.presentAddress?.state ?? '',
                                      text: matchesControl.savedMatchesList![i].profile?.basicInfo?.aboutUs ?? '',
                                    );
                                  });
                                },
                                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
      );
    });
  }
}
