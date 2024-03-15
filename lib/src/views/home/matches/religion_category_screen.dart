import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../../../apis/members_api.dart';
import '../../../apis/members_api/bookmart_api.dart';
import '../../../apis/members_api/request_apis.dart';
import '../../../constants/assets.dart';
import '../../../constants/string.dart';
import '../../../models/LoginResponse.dart';
import '../../../models/matches_model.dart';
import '../../../utils/urls.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/loader.dart';
import '../../user_profile/user_profile.dart';
import '../dashboard_widgets.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ReligionCategory extends StatefulWidget {
  final LoginResponse response;

  const ReligionCategory({super.key, required this.response});

  @override
  State<ReligionCategory> createState() => _ReligionCategoryState();
}

class _ReligionCategoryState extends State<ReligionCategory> {
  String religionFilter = '';
  String marriedFilter = '';

  @override
  void initState() {
    super.initState();
    getMatches();

  }

  List<MatchesModel> matches = [];
  List<bool> isLoadingList = [];
  bool isLoading = false;
  int page = 1;
  bool loading = false;

  getMatches() {
    isLoading = true;
    // matches.clear();
    // matches.clear();
    getMatchesFilterApi(
      page: page.toString(),
      maritalStatus: marriedFilter,
      religion: widget.response.data!.user!.religion.toString(),
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M", country: '', height: '',
    ).then((value) {
      matches.clear();
      setState(() {
        if (value['status'] == true) {
          for (var v in value['data']['members']['data']) {
            matches.add(MatchesModel.fromJson(v));
            isLoadingList.add(false); // Add false for each new match
          }
          isLoading = false;
          page++;
        } else {
          isLoading = false;
        }
      });
    });
  }

  loadMore() {
    print('ndnd');
    // if (!isLoading) {
    isLoading = true;
    // matches.clear();

    getMatchesFilterApi(
      page: page.toString(),
      maritalStatus: marriedFilter,
      religion: widget.response.data!.user!.religion.toString(),
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M", country: '', height: '',
    ).then((value) {
      setState(() {
        if (value['status'] == true) {
          for (var v in value['data']['members']['data']) {
            matches.add(MatchesModel.fromJson(v));
            isLoadingList.add(false); // Add false for each new match
          }
          isLoading = false;
          page++;
        } else {
          isLoading = false;
        }
      });
    });
    // }
  }

  String? religionValue;
  String? marriedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: backButton(
              context: context,
              image: icArrowLeft,
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        title: Text("Preferred Matches",
          style: styleSatoshiBold(size: 18, color: Colors.black),
        ),

      ),
      body: isLoading
          ? const Loading()
          : RefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return getMatches();
        },
        child: isLoading
             ? const Loading()
            : Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: LazyLoadScrollView(
            isLoading: isLoading,
            onEndOfPage: () {
              loadMore();
            },
            child: ListView.separated(
              itemCount: matches.length + 1,
              itemBuilder: (context, i) {
                if (i < matches.length) {
                  DateTime? birthDate = matches[i].basicInfo != null ? DateFormat('yyyy-MM-dd').parse(matches[i].basicInfo!.birthDate!) : null;
                  int age = birthDate != null ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                  return otherUserdataHolder(
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
                    state:matches[i].basicInfo?.presentAddress?.state ?? '',
                    height:"${matches[i].physicalAttributes!.height ?? ''} ft",
                    imgUrl: '$baseProfilePhotoUrl${matches[i].image ?? ''}',
                    userName: matches[i].firstname == null && matches[i].lastname == null
                        ? "user"
                        : '${StringUtils.capitalize(matches[i].firstname ?? "")} ${StringUtils.capitalize(matches[i].lastname ?? "user")}',
                    atributeReligion: 'Religion: ${matches[i].religion ?? ""}',
                    profession: "Software Engineer",
                    Location: '${matches[i].address!.state ?? 'Not added Yet'}${matches[i].address!.country ?? 'Not added Yet'}',
                    likedColor: Colors.grey,
                    unlikeColor: primaryColor,
                    button: isLoadingList[i]
                        ? loadingButton(height: 30, width: 134, context: context)
                        : button(
                        fontSize: 14,
                        height: 30,
                        width: 134,
                        context: context,
                        onTap: () {
                          setState(() {
                            isLoadingList[i] = true;
                          });
                          sendRequestApi(memberId: matches[i].id.toString()).then((value) {
                            if (value['status'] == true) {
                              setState(() {
                                isLoadingList[i] = false;
                              });
                              ToastUtil.showToast("Connection Request Sent");
                              print('done');
                            } else {
                              setState(() {
                                isLoadingList[i] = false;
                              });

                              List<dynamic> errors = value['message']['error'];
                              String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                              Fluttertoast.showToast(msg: errorMessage);
                            }
                          });
                        },
                        title: "Connect Now"),
                    bookmark: LikeButton(
                      onTap: (isLiked) async {
                        var result = await saveBookMartApi(memberId: matches[i].profileId.toString());
                        if (result['status'] == true) {
                          Fluttertoast.showToast(msg: "Bookmark Saved");
                        } else {}
                      },
                      size: 22,
                      circleColor: const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.bookmark,
                          color: matches[i].bookmark == 0 ? Colors.grey : primaryColor,
                          size: 22,
                        );
                      },
                    ),
                    bookMarkTap: () {},
                    dob: '$age years old',
                  );
                } else {
                  if (isLoading) {
                    return customLoader(size: 40);
                  } else {
                    return Center(child: Text("All matches loaded"));
                  }
                }
              },
              separatorBuilder: (BuildContext context, int index) => const SizedBox(
                height: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
