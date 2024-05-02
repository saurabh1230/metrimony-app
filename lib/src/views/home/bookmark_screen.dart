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

class SavedMatchesScreen extends StatefulWidget {
  const SavedMatchesScreen({super.key});

  @override
  State<SavedMatchesScreen> createState() => _SavedMatchesScreenState();
}

class _SavedMatchesScreenState extends State<SavedMatchesScreen> {


  List<String> images = [
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
  ];
  final searchController = TextEditingController();

  List<String> name = [
    "Leslie Alexander",
    "Emily Sullivan",
    "Lily Turner",
    "Grace Harrison",
    "Sophia Bennett",
    "Aria Mitchell",
    "Ava Thompson",
    "Ella Hayes",
    "Mia Turner",
    "Ruby Morgan",
  ];
  List<String> filteredNames = [];

  @override
  void initState() {
    super.initState();
    getSavedMatches();
  }

  bool isSearch = false;
  int page = 1;
  // List<SavedBookMarkModel> matches = [];

// MatchesData matches = MatchesModel();
  bool isLoading = false;
  List<SavedMatchesModel> matches = [];
    List<bool> isLoadingList = [];
  getSavedMatches() {
    isLoading = true;
    savedMatchesApi(page: page.toString()
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) {
            for (var v in value['data']['shortlists']['data']) {
              // matches.add(SavedMatchesModel.fromJson(v));
              // isLoadingList.add(false); //
              // like.add(false); // Add false for each new match
              SavedMatchesModel savedMatch = SavedMatchesModel.fromJson(v);
              // Check if profile is not empty
              if (savedMatch.profile != null) {
                matches.add(savedMatch);
              }

            }
            isLoading = false;
            page++;
            // page++;
          } else {
            isLoading = false;
          }
        });
      }
    });
  }

  loadMore() {
    isLoading = true;
    savedMatchesApi(page: page.toString()
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) {
            for (var v in value['data']['shortlists']['data']) {
              // matches.add(SavedMatchesModel.fromJson(v));
              // isLoadingList.add(false); //
              // like.add(false); // Add false for each new match
              SavedMatchesModel savedMatch = SavedMatchesModel.fromJson(v);
              // Check if profile is not empty
              if (savedMatch.profile != null) {
                matches.add(savedMatch);
              }
            }

            isLoading = false;
             page++;
          } else {
            isLoading = false;
          }
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Sortlisted",isBackButtonExist: true,),
      // appBar: AppBar(
      //  leading: Padding(
      // padding: const EdgeInsets.only(left: 16),
      // child: backButton(
      //     context: context,
      //     image: icArrowLeft,
      //     onTap: () {
      //       Navigator.pop(context);
      //     }),),
      //   centerTitle: false,
      //   automaticallyImplyLeading: false,
      //   title: Text("Sortlisted",
      //     style: styleSatoshiBold(size: 22, color: Colors.black),),
      // ),
      body: isLoading ? const ShimmerWidget() :
      CustomRefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return getSavedMatches();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10,
              bottom: 20),
          child:
              matches.isEmpty
            ?
          Center(
            child: Column(
              children: [
                // sizedBox16(),
                // // Image.asset(icWaitPlaceHolder,
                // //   height: 80,),
                // sizedBox16(),
                Text("No Sortlisted members",

                  style: styleSatoshiLight(size: 18, color: Colors.black),)
              ],
            ),
          ) :
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox13(),
              Text("${matches.length} matches sortlisted",
              style: styleSatoshiLight(size: 16, color: Colors.black),),
              sizedBox13(),
              Expanded(

                child: LazyLoadScrollView(
                  isLoading: isLoading,
                  onEndOfPage: () {
                    loadMore();
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: matches.length + 1,
                            itemBuilder: (context, i) {
                              if (i < matches.length) {
                                DateTime? birthDate = matches[i].profile?.basicInfo != null ? DateFormat('yyyy-MM-dd').parse(matches[i].profile!.basicInfo!.birthDate!) : null;
                                int age = birthDate != null ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;

                                return otherUserdataHolder(
                                  context: context,
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                UserProfileScreen(
                                                  userId:
                                                      matches[i].id.toString(),
                                                )));
                                  },
                                  imgUrl:
                                      '$baseProfilePhotoUrl${matches[i].profile?.image ?? ''}',

                                  userName: matches[i].profile?.firstname == null &&
                                          matches[i].profile?.lastname == null
                                      ? "user"
                                      : '${StringUtils.capitalize(matches[i].profile?.firstname ?? 'User')} ${StringUtils.capitalize(matches[i].profile?.lastname ?? 'User')}',
                                  atributeReligion:
                                      " Religion: ${StringUtils.capitalize(matches[i].profile?.basicInfo?.religion ?? "")}",
                                  profession: "Software Engineer",
                                  Location:
                                      "${matches[i].profile?.basicInfo?.presentAddress?.country ?? ""}",
                                  likedColor: Colors.grey,
                                  unlikeColor: primaryColor,
                                  button:button(
                                          fontSize: 14,
                                          height: 30,
                                          width: 134,
                                          context: context,
                                          onTap: () {
                                            setState(() {
                                              // isLoadingList[i] = true;
                                            });

                                            sendRequestApi(
                                                    memberId:
                                                        matches[i].id.toString()
                                                    // id: career[0].id.toString(),
                                                    )
                                                .then((value) {
                                              if (value['status'] == true) {
                                                setState(() {
                                                  // isLoadingList[i] = false;
                                                });
                                                ToastUtil.showToast(
                                                    "Connection Request Sent");
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
                                  bookmark: SizedBox(),
                                  /*Icon(
                                    Icons.bookmark,
                                    color: matches[i].bookmark == 0 ? Colors.grey : primaryColor,
                                    size: 22,
                                  ),*/
                                  // bookmark: LikeButton(
                                  //   onTap: (isLiked) async {
                                  //     var result = await saveBookMartApi(memberId: matches[i].profileId.toString());
                                  //     if (result['status'] == true) {
                                  //       Fluttertoast.showToast(msg: "Bookmark Saved");
                                  //       // Fluttertoast.showToast("Bookmark Saved");
                                  //     } else {
                                  //
                                  //     }
                                  //
                                  //   },
                                  //   size: 22,
                                  //   circleColor: const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                  //   bubblesColor: const BubblesColor(
                                  //     dotPrimaryColor: Color(0xff33b5e5),
                                  //     dotSecondaryColor: Color(0xff0099cc),
                                  //   ),
                                  //
                                  //   likeBuilder: (bool isLiked) {
                                  //     // return Icon(
                                  //     //   Icons.bookmark,
                                  //     //   color: matches[i].bookmark == 0 ? Colors.grey : primaryColor,
                                  //     //   size: 22,
                                  //     // );
                                  //   },
                                  //
                                  // ),
                                  dob:'$age yrs',
                                  height:"",
                                  state:matches[i].profile?.basicInfo?.presentAddress?.state ?? '',
                                );
                              }
                              if (isLoading) {
                                return customLoader(size: 40);
                              } else {
                                return Center(child: Text("All matches loaded"));
                              }

                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                const SizedBox(
                              height: 16,
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}