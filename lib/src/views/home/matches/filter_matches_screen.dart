import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import '../../../apis/members_api.dart';
import '../../../apis/members_api/bookmart_api.dart';
import '../../../apis/members_api/request_apis.dart';
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

class FilterMatchesScreen extends StatefulWidget {
  final LoginResponse response;

  const FilterMatchesScreen({super.key, required this.response});

  @override
  State<FilterMatchesScreen> createState() => _FilterMatchesScreenState();
}

class _FilterMatchesScreenState extends State<FilterMatchesScreen> {
  String religionFilter = '';
  String marriedFilter = '';

  @override
  void initState() {
    super.initState();
    getMatches();
/*    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return  Container(
            width: 1.sw,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  sizedBox16(),
                  Text("Select Preferred Matches",
                    style: styleSatoshiLight(size: 12, color: Colors.black),),
                  sizedBox16(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: SizedBox(
                      width: 1.sw,
                      child: CustomStyledDropdownButton(
                        items: ["Hindu","Muslim","Jain",'Buddhist','Sikh','Marathi'],
                        selectedValue: religionValue,
                        onChanged: (String? value) {
                          setState(() {
                            religionValue = value;
                            religionFilter = religionValue!;
                            print(religionFilter);
                          });
                        }, title: 'Religion',
                      ),
                    ),
                  ),
                  sizedBox16(),
                  SizedBox(
                    width: 1.sw,
                    child: CustomStyledDropdownButton(
                      items:  ["Unmarried","Married","Widowed","Divorced"],
                      selectedValue: marriedValue,
                      onChanged: (String? value) {
                        setState(() {
                          marriedValue = value;
                          marriedFilter = marriedValue!;
                          print(marriedFilter);
                        });
                      }, title: 'Married Status',
                    ),
                  ),
                  sizedBox16(),
                  // SizedBox(
                  //   width: 1.sw,
                  //   child: CustomStyledDropdownButton(
                  //     items:  ["Unmarried","Married","Widowed","Divorced"],
                  //     selectedValue: marriedValue,
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         marriedValue = value;
                  //       });
                  //     }, title: 'Married Status',
                  //   ),
                  // ),


                ],
              ),
            ),
          );
        },
      );
    });*/
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
      religion: religionFilter,
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
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
      religion: religionFilter,
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
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
        centerTitle: false,
        title: Text(
          "Filter Matches",
          style: styleSatoshiBold(size: 22, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      width: 1.sw,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            sizedBox16(),
                            Text(
                              "Select Preferred Matches",
                              style: styleSatoshiLight(
                                  size: 12, color: Colors.black),
                            ),
                            sizedBox16(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: SizedBox(
                                width: 1.sw,
                                child: CustomStyledDropdownButton(
                                  items: [
                                    "Hindu",
                                    'Muslim',
                                    "Jain",
                                    'Buddhist',
                                    'Sikh',
                                    'Marathi'
                                  ],
                                  selectedValue: religionValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      religionValue = value;
                                      religionFilter = religionValue ?? '';
                                      print(religionFilter);
                                      print(religionValue);
                                    });
                                  },
                                  title: 'Religion',
                                ),
                              ),
                            ),
                            sizedBox16(),
                            SizedBox(
                              width: 1.sw,
                              child: CustomStyledDropdownButton(
                                items: const  [
                                  "Unmarried",
                                  "Married",
                                  "Widowed",
                                  "Divorced"
                                ],
                                selectedValue: marriedValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    marriedValue = value;
                                    marriedFilter = marriedValue!;
                                    print("cegcj");
                                    print(marriedFilter);
                                  });
                                },
                                title: 'Married Status',
                              ),
                            ),
                            sizedBox16(),
                            elevatedButton(
                                color: primaryColor,
                                context: context,
                                onTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                    isLoading = true;
                                    page = 0;

                                    print("fkg");
                                    getMatches();
                                  });
                                },
                                title: "Apply")
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                  right: 16.0, top: 6, bottom: 6, left: 10),
              child: Icon(Icons.filter_alt_outlined),
            ),
          )
        ],
      ),
      body: isLoading
          ? Loading()
          : RefreshIndicator(
              onRefresh: () {
                setState(() {
                  isLoading = true;
                });
                return getMatches();
              },
              child: isLoading
                  ? Loading()
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
                                    '$baseProfilePhotoUrl${matches[i].image ?? ''}',
                                // matches[i].image == null ?
                                // "" :
                                // '${matches[i].image.toString()}',
                                userName: matches[i].firstname == null &&
                                        matches[i].lastname == null
                                    ? "user"
                                    : '${matches[i].firstname} ${matches[i].lastname}',
                                atributeReligion:
                                    "5 ft 4 in  • ${matches[i].religion ?? "Not Added Yet"}",
                                profession: "Software Engineer",
                                Location:
                                    "${matches[i].address!.state ?? ""} ${matches[i].address!.country ?? ""}",
                                likedColor: Colors.grey,
                                unlikeColor: primaryColor,
                                button: isLoadingList[i]
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
                                          print(matches[i].id.toString());
                                          sendRequestApi(
                                                  memberId:
                                                      matches[i].id.toString()
                                                  // id: career[0].id.toString(),
                                                  )
                                              .then((value) {
                                            if (value['status'] == true) {
                                              setState(() {
                                                isLoadingList[i] = false;
                                              });
                                              ToastUtil.showToast(
                                                  "Connection Request Sent");
                                              print('done');
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
                                bookmark: LikeButton(
                                  onTap: (isLiked) async {
                                    print(matches[i].profileId.toString());
                                    var result = await saveBookMartApi(memberId: matches[i].profileId.toString());
                                    if (result['status'] == true) {
                                      Fluttertoast.showToast(msg: "Bookmark Saved");
                                      // Fluttertoast.showToast("Bookmark Saved");
                                    } else {

                                    }

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
                              );
                            }
                            if (isLoading) {
                              return customLoader(size: 40);
                            } else {
                              return Center(child: Text("All matches loaded"));
                            }
                            // else if (is) {
                            //         print("1");
                            //        return const Center(
                            //          child: CircularProgressIndicator()
                            //        );
                            //      } else if (page < 8) {
                            //         print("2");
                            //        return const SizedBox.shrink();
                            //      } else {
                            //         print("3");
                            //        return const Center(
                            //          child: CircularProgressIndicator()
                            //        );}
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 16,
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
