import 'dart:async';

import 'package:bureau_couple/src/views/home/bookmark_screen.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis/members_api.dart';
import '../../../apis/members_api/bookmart_api.dart';
import '../../../apis/members_api/request_apis.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizedboxe.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/matches_model.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/loader.dart';
import '../../user_profile/user_profile.dart';
import '../dashboard_widgets.dart';
import 'package:intl/intl.dart';


class MatchesScreen extends StatefulWidget {
  final LoginResponse response;

  const MatchesScreen({Key? key, required this.response}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final TextEditingController searchController = TextEditingController();

  List<MatchesModel> matches = [];
  List<bool> isLoadingList = [];
  List<bool> like = [];

  // List<bool> isbList = [];
  bool isLoading = false;
  int page = 1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getMatches();
  }

  LoginResponse? response;

  // bool like = false;

  getMatches() {
    isLoading = true;
    getMatchesByGenderApi(
      page: page.toString(),
      // gender: "",
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) {
            for (var v in value['data']['members']['data']) {
              matches.add(MatchesModel.fromJson(v));
              isLoadingList.add(false); //
              like.add(false); // Add false for each new match
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

  loadMore() {
    print('ndnd');
    // if (!isLoading) {
    isLoading = true;
    getMatchesByGenderApi(
      page: page.toString(),
      // gender: "",
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) {
            for (var v in value['data']['members']['data']) {
              matches.add(MatchesModel.fromJson(v));
              isLoadingList.add(false); // Add false for each new match
              like.add(false);
            }
            isLoading = false;
            page++;
          } else {
            isLoading = false;
          }
        });
      }
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "Matches",
          style: styleSatoshiBold(size: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const SavedMatchesScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text("Sortlisted"),
            ),
          )
        ],
      ),
      body: isLoading
          ?const  ShimmerWidget()
          : matches.isEmpty && matches == null
              ? const Text("No Matches Yet")
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: LazyLoadScrollView(
                    isLoading: isLoading,
                    onEndOfPage: () {
                      loadMore();
                    },
                    child: ListView.separated(
                      itemCount: matches.length + 1,
                      itemBuilder: (context, i) {
                        if (i < matches.length) {
                          DateTime? birthDate = matches[i].basicInfo != null
                              ? DateFormat('yyyy-MM-dd')
                                  .parse(matches[i].basicInfo!.birthDate!)
                              : null;
                          int age = birthDate != null
                              ? DateTime.now().difference(birthDate).inDays ~/
                                  365
                              : 0;
                          return Column(
                            children: [
                              otherUserdataHolder(
                                context: context,
                                tap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => UserProfileScreen(
                                        userId: matches[i].id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                height:
                                    "${matches[i].physicalAttributes!.height ?? ''} ft",
                                imgUrl:
                                    '$baseProfilePhotoUrl${matches[i].image ?? ''}',
                                state: matches[i]
                                        .basicInfo
                                        ?.presentAddress
                                        ?.state ??
                                    '',
                                userName: matches[i].firstname == null &&
                                        matches[i].lastname == null
                                    ? "user"
                                    : '${StringUtils.capitalize(matches[i].firstname ?? 'User')} ${StringUtils.capitalize(matches[i].lastname ?? 'User')}',
                                atributeReligion:
                                    'Religion: ${matches[i].basicInfo?.religion ?? ''}',
                                profession: "Software Engineer",
                                Location:
                                    '${matches[i].address!.state ?? 'Not added Yet'}${matches[i].address!.country ?? 'Not added Yet'}',
                                likedColor: Colors.grey,
                                unlikeColor: primaryColor,
                                button:
                                // matches[i].bookmark == 1
                                //     ? button(
                                //         fontSize: 14,
                                //         height: 30,
                                //         width: 134,
                                //         context: context,
                                //         onTap: () {},
                                //         title: "Request Sent")
                                //     :
                                isLoadingList[i]
                                        ? loadingButton(
                                            height: 30,
                                            width: 134,
                                            context: context)
                                        : button(
                                            fontSize: 14,
                                            height: 30,
                                            width: 134,
                                            context: context,
                                            onTap: () {
                                              setState(() {
                                                isLoadingList[i] = true;
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
                                            },
                                            title: "Connect Now"),
                                bookmark: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      setState(() {
                                        like[i] = !like[i];
                                      });
                                    });
                                    if (matches[i].bookmark == 1) {
                                      var result = await unSaveBookMarkApi(
                                          memberId: matches[i].profileId.toString()
                                      );
                                      if (result['status'] == true) {
                                        Fluttertoast.showToast(msg: "Bookmark Saved");
                                      } else {
                                        // Handle failure case if needed
                                      }
                                    } else {
                                      var result = await saveBookMartApi(
                                          memberId: matches[i].profileId.toString()
                                      );
                                      if (result['status'] == true) {
                                        Fluttertoast.showToast(msg: "Bookmark Saved");
                                      } else {
                                        // Handle failure case if needed
                                      }
                                    }

                                  },
                                  child: like[i] ?
                                  GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   like[i] = false;
                                      // });
                                    },
                                    child: Icon(
                                      Icons.bookmark,
                                      color: primaryColor,

                                      size: 22,
                                    ),
                                  ):
                                  Icon(
                                    Icons.bookmark,
                                    color: matches[i].bookmark == 1
                                        ? primaryColor
                                        : Colors.grey,
                                    size: 22,
                                  ),
                                ),
                                // LikeButton(
                                //   onTap: (isLiked) async {
                                //     var result = await saveBookMartApi(memberId: matches[i].profileId.toString());
                                //     if (result['status'] == true) {
                                //       Fluttertoast.showToast(msg: "Bookmark Saved");
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
                                //     return Icon(
                                //       Icons.bookmark,
                                //       color: matches[i].bookmark == 0 ? Colors.grey : primaryColor,
                                //       size: 22,
                                //     );
                                //   },
                                //
                                // ),
                                // bookmark: LikeButton(
                                //   onTap: (isLiked) async {
                                //     var result = await saveBookMartApi(memberId: matches[i].profileId.toString());
                                //     if (result['status'] == true) {
                                //       Fluttertoast.showToast(msg: "Bookmark Saved");
                                //     } else {}
                                //   },
                                //   size: 22,
                                //   circleColor: const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                //   bubblesColor: const BubblesColor(
                                //     dotPrimaryColor: Color(0xff33b5e5),
                                //     dotSecondaryColor: Color(0xff0099cc),
                                //   ),
                                //   likeBuilder: (bool isLiked) {
                                //     return Icon(
                                //       Icons.bookmark,
                                //       color: matches[i].bookmark == 0 ? Colors.grey : primaryColor,
                                //       size: 22,
                                //     );
                                //   },
                                // ),
                                bookMarkTap: () {},
                                dob: '$age yrs',
                              )
                            ],
                          );
                        } else {
                          if (isLoading) {
                            return customLoader(size: 40);
                          } else {
                            return const Center(
                                child: Text("All matches loaded"));
                          }
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 16,
                      ),
                    ),
                  ),
                ),
    );
  }
}

