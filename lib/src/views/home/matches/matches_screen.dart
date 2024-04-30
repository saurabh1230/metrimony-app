import 'dart:async';
import 'package:bureau_couple/src/controller/matches_controller.dart';
import 'package:get/get.dart';
import 'package:bureau_couple/src/views/home/bookmark_screen.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis/members_api.dart';
import '../../../apis/members_api/bookmart_api.dart';
import '../../../apis/members_api/request_apis.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizedboxe.dart';
import '../../../constants/string.dart';
import '../../../constants/textfield.dart';
import '../../../constants/textstyles.dart';
import '../../../models/matches_model.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/dropdown_buttons.dart';
import '../../../utils/widgets/loader.dart';
import '../../user_profile/user_profile.dart';
import '../dashboard_widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

class MatchesScreen extends StatefulWidget {
  final LoginResponse response;

  const MatchesScreen({Key? key, required this.response}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final TextEditingController searchController = TextEditingController();

  List<MatchesModel> matches = [];
  List<MatchesModel> bookmarkList = [];
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
  String religionFilter = '';
  String marriedFilter = '';
  double _value = 5.0;
  double height = 0;

  String? religionValue;
  String? marriedValue;

  final stateController = TextEditingController();

  // bool like = false;

  getMatches() {matches.clear();
    isLoading = true;
    getMatchesByGenderApi(
      page: page.toString(),
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
      religion: religionFilter,
      height: height == 5.0 ? "5-6" : height == 6.0  ? "6-7" : "7-8",
      state: stateController.text ,
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

  loadMore() {matches.clear();
    print('ndnd');
    // if (!isLoading) {
    isLoading = true;
    getMatchesByGenderApi(
      religion: religionFilter,
      page: page.toString(),
      height: height == 5.0 ? "5-6" : height == 6.0  ? "6-7" : "7-8" ,
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
      state: stateController.text,
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
          ),
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
                                      items: const  [
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

                                        });
                                      },
                                      title: 'Religion',
                                    ),
                                  ),
                                ),
                                // sizedBox16(),
                                /*    textBoxPickerField(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    flagSize: 25,
                                    backgroundColor: Colors.white,
                                    textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                                    bottomSheetHeight: 500,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    inputDecoration: InputDecoration(
                                      // labelText: 'Search',
                                      hintText: 'Start typing to search',
                                      hintStyle: styleSatoshiBlack(size: 12, color: Colors.black),
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onSelect: (Country country) {
                                    setState(() {
                                      selectedCountryName = country.displayName.split(' ')[0] ?? '';
                                      countyController.text = selectedCountryName;
                                    });
                                    setState(() {

                                    });
                                  },
                                );
                                setState(() {});
                              },
                              context: context,
                              label: '',
                              controller: countyController,
                              hint: '',
                              length: null,
                              suffixIcon: const  Icon(Icons.visibility_off),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Country';
                                }
                                return null;
                              },
                              onChanged: (value) {
                              }, icon: Icons.flag,),*/
                                sizedBox16(),
                                textBox(
                                  context: context,
                                  label: 'State',
                                  controller: stateController,
                                  hint: 'State',
                                  length: null,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your State';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {

                                  },),
                                  sizedBox16(),
                            SfSlider(
                              activeColor: primaryColor,
                              min: 5.0,
                              max: 7.0,
                              value: _value,
                              interval: 1, // Interval is 1 foot
                              showTicks: true,
                              showLabels: true,
                              enableTooltip: true,
                              minorTicksPerInterval: 0,
                                stepSize: 1 ,// Disable minor ticks
                              onChanged: (dynamic value) {
                                setState(() {
                                  _value = value;
                                  height = value;
                                  print(height);

                                });
                              },
                              labelFormatterCallback: (dynamic value, String formattedValue) {
                                int feet = value.floor();
                                int inches = ((value - feet) * 12).round();
                                if (inches == 12) {
                                  feet++;
                                  inches = 0;
                                }
                                return '$feet\' $inches"';
                              },
                            ),

                                // SizedBox(
                                //   width: 1.sw,
                                //   child: CustomStyledDropdownButton(
                                //     items: const  [
                                //       "Unmarried",
                                //       "Married",
                                //       "Widowed",
                                //       "Divorced"
                                //     ],
                                //     selectedValue: marriedValue,
                                //     onChanged: (String? value) {
                                //       setState(() {
                                //         marriedValue = value;
                                //         marriedFilter = marriedValue!;
                                //
                                //       });
                                //     },
                                //     title: 'Married Status',
                                //   ),
                                // ),
                                sizedBox16(),
                                elevatedButton(
                                    color: primaryColor,
                                    context: context,
                                    onTap: () {
                                      setState(() {
                                        Navigator.pop(context);
                                        isLoading = true;
                                        page = 1;
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
              child:  Image.asset(icFilter,
                height: 24,
                width: 24,
                color: Colors.black,),
            ),
          )
        ],
      ),
      body:  GetBuilder<MatchesController>(builder: (matchesControl) {
        return isLoading
            ? const ShimmerWidget()
            : matches.isEmpty && matches == null
            ? const Text("No Matches Yet")
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${matches.length} members found"),
                sizedBox10(),
                Container(
                  height: 1.sh, padding: const EdgeInsets.only(bottom: 200),
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
                                            userId: matches[i].id.toString(),
                                          ),
                                    ),
                                  );
                                },
                                height:
                                "${matches[i].physicalAttributes!.height ??
                                    ''} ft",
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
                                    : '${StringUtils.capitalize(
                                    matches[i].firstname ??
                                        'User')} ${StringUtils.capitalize(
                                    matches[i].lastname ?? 'User')}',
                                atributeReligion:
                                'Religion: ${matches[i].basicInfo?.religion ??
                                    ''}',
                                profession: "Software Engineer",
                                Location:
                                '${matches[i].address!.state ?? ''}${matches[i]
                                    .address!.country ?? ''}',
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
                                bookmark:

                                 GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      like[i] = !like[i];
                                    });
                                    print(matches[i].bookmark);
                                    matches[i].bookmark == 1 ?
                                    matchesControl.unSaveBookmarkApi(matches[i].profileId.toString()) :
                                    matchesControl.bookMarkSaveApi(matches[i].profileId.toString());
                                    // getMatches();
                                  },
                                  child: like[i] ?
                                  Icon(
                                    CupertinoIcons.heart_fill, color:like[i] ?  primaryColor : Colors.grey ,
                                    size: 22,):

                                   Icon(
                                    CupertinoIcons.heart_fill, color:  matches[i].bookmark == 1 ? primaryColor : Colors.grey,
                                    size: 22,),
                                ),
                                /*GestureDetector(
                                          onTap: () async {
                                              setState(() {like[i] = !like[i];});
                                            if (matches[i].bookmark == 1) {
                                              var result = await unSaveBookMarkApi(memberId: matches[i].profileId.toString());
                                              if (result['status'] == true) {Fluttertoast.showToast(msg: "Bookmark Saved");}
                                              else {}
                                            } else {
                                              var result = await saveBookMartApi(
                                                  memberId: matches[i].profileId.toString()
                                              );
                                              if (result['status'] == true) {
                                                Fluttertoast.showToast(msg: "Bookmark Saved");
                                              } else {
                                                // Handle failure case if needed
                                              }}},
                                          child: like[i] ?
                                          GestureDetector(
                                            onTap: () {
                                              // setState(() {
                                              //   like[i] = false;
                                              // });
                                            },
                                            child: const Icon(Icons.bookmark, color: primaryColor, size: 22,),):
                                          Icon(Icons.bookmark, color: matches[i].bookmark == 1 ? primaryColor : Colors.grey, size: 22,),
                                        ),*/
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

              ],
            ),
          ),
        );
      }),);
    }

  }


