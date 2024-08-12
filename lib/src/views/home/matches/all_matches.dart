import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/features/widgets/matches_shimmer_widget.dart';
import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
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
import 'package:flutter_svg/flutter_svg.dart';

class MatchesScreen extends StatefulWidget {
  final bool appbar;
  final LoginResponse response;

  const MatchesScreen({Key? key, required this.response, required this.appbar}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController minHeight = TextEditingController();
  final TextEditingController maxHeight = TextEditingController();
  final TextEditingController maxWeightController = TextEditingController();

  List<MatchesModel> matches = [];
  List<MatchesModel> bookmarkList = [];
  List<bool> isLoadingList = [];
  List<bool> like = [];

  int _feet = 5;
  int _inches = 0;

  int _feet2 = 5;
  int _inches2 = 0;

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
  String? motherTongueValue;
  String motherTongueFilter = '';
  final stateController = TextEditingController();

  // bool like = false;

  getMatches() {
    // matches.clear();
    isLoading = true;
    getMatchesByGenderApi(
      page: page.toString(),
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
      religion: religionFilter,
      // height: height == 5.0 ? "5-6" : height == 6.0  ? "6-7" : "7-8",
      state: stateController.text,
      minHeight: minHeight.text,
      maxHeight: maxHeight.text, maxWeight: maxWeightController.text, motherTongue: motherTongueFilter,
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) {
            matches.clear();
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
    // matches.clear();
    // if (!isLoading) {
    isLoading = true;
    getMatchesByGenderApi(
      religion: religionFilter,
      page: page.toString(),
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
      state: stateController.text,
      minHeight: minHeight.text,
      maxHeight: maxHeight.text,
      maxWeight: maxWeightController.text,
      motherTongue: motherTongueFilter,
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) { matches.clear();
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
                  MaterialPageRoute(
                      builder: (builder) => const SavedMatchesScreen()));
            },
            child:  Padding(
              padding: const EdgeInsets.only(right: 16.0,),
              child: SvgPicture.asset(sortList,color: Colors.white,),
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
                          height: 1.sh,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  sizedBox16(),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                    child: SizedBox(
                                      width: 1.sw,
                                      child: CustomStyledDropdownButton(
                                        items: const  [
                                          "Hindi",
                                          "Bhojpuri",
                                          'Marathi',
                                          "Bengali",
                                          'Odia',
                                          'Gujarati',
                                        ],
                                        selectedValue: motherTongueValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            motherTongueValue = value;
                                            motherTongueFilter = motherTongueValue ?? '';

                                          });
                                        },
                                        title: 'Mother Tongue',
                                      ),
                                    ),
                                  ),
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
                                  Row(children: [
                                    Expanded(child:  textBox(
                                      read: true,
                                      tap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext builder) {

                                            // Create the modal bottom sheet widget containing the time picker and close button
                                            return SizedBox(
                                              height: MediaQuery.of(context).copyWith().size.height / 3,
                                              child: Column(
                                                children: [

                                                  WillPopScope(
                                                    onWillPop: () async {

                                                      return false;
                                                    },
                                                    child: SizedBox(
                                                      height:200,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: CupertinoPicker(
                                                              scrollController: FixedExtentScrollController(
                                                                initialItem: _feet - 5,
                                                              ),
                                                              itemExtent: 32,
                                                              onSelectedItemChanged: (index) {
                                                                setState(() {
                                                                  _feet = index + 5;
                                                                });
                                                              },
                                                              children: List.generate(
                                                                7, // 7 feet in the range from 5 to 11
                                                                    (index) => Center(child: Text('${index + 5}\'')),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: CupertinoPicker(
                                                              scrollController: FixedExtentScrollController(
                                                                initialItem: _inches,
                                                              ),
                                                              itemExtent: 32,
                                                              onSelectedItemChanged: (index) {
                                                                setState(() {
                                                                  _inches = index;
                                                                });
                                                                print(' $_feet-${_inches.toString().padLeft(2, '0')}');
                                                              },
                                                              children: List.generate(
                                                                12, // 12 inches in a foot
                                                                    (index) => Center(child: Text('$index\"')),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,

                                                    children: [
                                                      Flexible(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.redAccent, // Change the background color to red
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child:  Text('Close',
                                                            style: styleSatoshiMedium(
                                                                size: 13,
                                                                color: Colors.white),),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8,),
                                                      Flexible(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              minHeight.text = '$_feet.${_inches.toString().padLeft(1, '0')}';
                                                              // maxHeightController.text = '$_feet2-${_inches2.toString()}';
                                                              print('$_feet.${_inches.toString().padLeft(1, '0')}');
                                                            });
                                                            Navigator.pop(context);
                                                          },
                                                          child:  Text('Save',
                                                            style: styleSatoshiMedium(
                                                                size: 13,
                                                                color: Colors.black),),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      context: context,
                                      label: 'Min Height',
                                      controller: minHeight,
                                      hint: 'Min Height',
                                      length: null,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Min Height';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {

                                      },),),
                                    sizedBoxWidth15(),
                                    Expanded(child:  textBox(
                                      read: true,
                                      tap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext builder) {
                                            // Create the modal bottom sheet widget containing the time picker and close button
                                            return SizedBox(
                                              height: MediaQuery.of(context).copyWith().size.height / 3,
                                              child: Column(
                                                children: [
                                                  WillPopScope(
                                                    onWillPop: () async {
                                                      return false;
                                                    },
                                                    child: SizedBox(
                                                      height:200,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: CupertinoPicker(
                                                              scrollController: FixedExtentScrollController(
                                                                initialItem: _feet2 - 5,
                                                              ),
                                                              itemExtent: 32,
                                                              onSelectedItemChanged: (index) {
                                                                setState(() {
                                                                  _feet2 = index + 5;
                                                                });
                                                              },
                                                              children: List.generate(
                                                                7, // 7 feet in the range from 5 to 11
                                                                    (index) => Center(child: Text('${index + 5}\'')),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: CupertinoPicker(
                                                              scrollController: FixedExtentScrollController(
                                                                initialItem: _inches2,
                                                              ),
                                                              itemExtent: 32,
                                                              onSelectedItemChanged: (index) {
                                                                setState(() {
                                                                  _inches2 = index;
                                                                });
                                                                print(' $_feet2-${_inches2.toString().padLeft(2, '0')}');
                                                              },
                                                              children: List.generate(
                                                                12, // 12 inches in a foot
                                                                    (index) => Center(child: Text('$index\"')),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Flexible(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.redAccent, // Change the background color to red
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child:  Text('Close',
                                                            style: styleSatoshiMedium(
                                                                size: 13,
                                                                color: Colors.white),),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8,),
                                                      Flexible(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              maxHeight.text = '$_feet2.${_inches2.toString().padLeft(1, '0')}';
                                                              // maxHeightController.text = '$_feet2-${_inches2.toString()}';
                                                              print('$_feet2.${_inches2.toString().padLeft(1, '0')}');
                                                            });
                                                            Navigator.pop(context);
                                                          },
                                                          child:  Text('Save',
                                                            style: styleSatoshiMedium(
                                                                size: 13,
                                                                color: Colors.black),),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      context: context,
                                      label: 'Min Height',
                                      controller: maxHeight,
                                      hint: 'Min Height',
                                      length: null,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Min Height';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {

                                      },),),

                                  ],),
                                  sizedBox16(),
                                  textBox(
                                    context: context,
                                    label: 'Max Weight',
                                    controller:maxWeightController,
                                    hint: 'Max Weight',
                                    length: null,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Max Weight';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                    },),
                                  sizedBox16(),
                                  elevatedButton(
                                      color: primaryColor,
                                      context: context,
                                      onTap: () {
                                        setState(() {

                                          page = 1;
                                          isLoading = true;
                                          getMatches();
                                          Navigator.pop(context);
                                        });
                                      },
                                      title: "Apply")
                                ],
                              ),
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
              child:  SvgPicture.asset(filter,
                color: Colors.white,),
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
            padding: const EdgeInsets.only(left: 16.0, right: 16,top: 16,bottom: 16),
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
                                // height:matches[i].physicalAttributes!.height == null ?
                                // "" :
                                // "${matches[i].physicalAttributes!.height ??
                                //     ''} ft",
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
                                // isLoadingList[i]
                                //     ? connectLoadingButton(color: Colors.white,
                                //     height: 30,
                                //     width: 134,
                                //     context: context)
                                //     :
                                GetBuilder<MatchesController>(builder: (matchesControl) {
                                  bool isWished = matchesControl.isBookmarkList.contains(matches[i].id.toString());
                                  return connectButton(
                                      fontSize: 14,
                                      height: 30,
                                      width: 134,
                                      context: context,
                                      onTap: () {
                                        sendRequestApi(
                                            memberId: matches[i].id.toString())
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
                                      showIcon: isWished ? false : true,
                                      title: isWished ?  "Request Sent" :"Connect Now"
                                    // matches[i].interestStatus == 2 ?  "Request Sent" : "Connect Now"
                                  );
                                }),


                                bookmark:

                                GestureDetector(
                                  onTap: () {
                                    matches[i].bookmark == 1 ?
                                    matchesControl.unSaveBookmarkApi(matches[i].profileId.toString()) :
                                    matchesControl.bookMarkSaveApi(matches[i].profileId.toString());
                                  },
                                  child: like[i] ?
                                  Icon(
                                    CupertinoIcons.heart_fill, color:like[i] ?  primaryColor : Colors.grey ,
                                    size: 22,):

                                  Icon(
                                    CupertinoIcons.heart_fill, color:  matches[i].bookmark == 1 ? primaryColor : Colors.grey,
                                    size: 22,),
                                ),

                                dob: '$age yrs', text: '',
                              )
                            ],
                          );
                        } else {
                          if (isLoading) {
                            return customLoader(size: 40);
                          } else {
                            return const SizedBox();
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


