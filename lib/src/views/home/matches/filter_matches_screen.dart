import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../apis/members_api.dart';
import '../../../apis/members_api/bookmart_api.dart';
import '../../../apis/members_api/request_apis.dart';
import '../../../constants/string.dart';
import '../../../constants/textfield.dart';
import '../../../controller/matches_controller.dart';
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
import 'package:syncfusion_flutter_sliders/sliders.dart';
class FilterMatchesScreen extends StatefulWidget {
  final LoginResponse response;
  final String filter;
  final String motherTongue;
  final String minHeight;
  final String maxHeight;
  final String maxWeight;

  const FilterMatchesScreen({super.key, required this.response, required this.filter, required this.motherTongue, required this.minHeight, required this.maxHeight, required this.maxWeight});

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
    getMatchesFilterApi(
      page: page.toString(),
      maritalStatus: '',
      religion: widget.filter,
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
      country: '', height: '', motherTongue: widget.motherTongue, minHeight: '', maxHeight: '', maxWeight: widget.maxWeight,
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
    getMatchesFilterApi(
      page: page.toString(),
      maritalStatus: marriedFilter,
      religion: religionFilter,
      country: countyController.text,
      gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
      height: '', motherTongue: '',
      minHeight: '', maxHeight: '', maxWeight: '',
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
  String? motherTongueValue;
  String motherTongueFilter = '';
  String? marriedValue;

  String selectedCountryName = '';
  String? selectedValue;
  final countyController = TextEditingController();
  final stateController = TextEditingController();

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
                          /*  sizedBox16(),
                            SfSlider(
                              activeColor: primaryColor,
                              min: 5.0,
                              max: 7.0,
                              value: _value,
                              interval: 1, // Interval is 1 foot
                              showTicks: true,
                              showLabels: true,
                              enableTooltip: true,
                              minorTicksPerInterval: 0, // Disable minor ticks
                              onChanged: (dynamic value) {
                                setState(() {
                                  _value = value;
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
                            ),*/

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
            : RefreshIndicator(
          onRefresh: () {
            setState(() {
              isLoading = true;
            });
            return getMatches();
          },
          child: isLoading
              ? Loading()
              : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${matches.length} members found"),
                  sizedBox10(),
                  Container(height:1.sh,padding: EdgeInsets.only(bottom: 200),
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
                                        builder: (builder) =>
                                            UserProfileScreen(
                                              userId:
                                              matches[i].id.toString(),
                                            )));
                              },
                              imgUrl:
                              '$baseProfilePhotoUrl${matches[i].image ?? ''}',

                              userName: matches[i].firstname == null &&
                                  matches[i].lastname == null
                                  ? "user"
                                  : '${StringUtils.capitalize(matches[i].firstname ?? 'User')} ${StringUtils.capitalize(matches[i].lastname ?? 'User')}',
                              atributeReligion:
                              "5 ft 4 in  • ${StringUtils.capitalize(matches[i].basicInfo?.religion ?? "")}",
                              profession: "Software Engineer",
                              Location:
                              "${matches[i].address!.state ?? ""} ${matches[i].address!.country ?? ""}",
                              likedColor: Colors.grey,
                              unlikeColor: primaryColor,
                              button: matches[i].bookmark == 1 ?
                              button(
                                  fontSize: 14,
                                  height: 30,
                                  width: 134,
                                  context: context, onTap: (){}, title: "Request Sent"):
                              isLoadingList[i]
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
                              bookmark: GestureDetector(
                                onTap: () {
                                  print(matches[i].bookmark);
                                  matches[i].bookmark == 1 ?
                                  matchesControl.unSaveBookmarkApi(matches[i].profileId.toString()) :

                                  matchesControl.bookMarkSaveApi(matches[i].profileId.toString());
                                  // getMatches();
                                },
                                child:  /*!matchesControl.isLoading ?*/ Icon(
                                  CupertinoIcons.heart_fill, color:  matches[i].bookmark == 1 ? primaryColor : Colors.grey,
                                  size: 22,) /*: const CircularProgressIndicator()*/,
                              ),
                              dob:'$age yrs',
                              height:"${matches[i].physicalAttributes!.height ?? ''} ft",
                              state:matches[i].basicInfo?.presentAddress?.state ?? '',
                            );
                          }
                          if (isLoading) {
                            return customLoader(size: 40);
                          } else {
                            return SizedBox();
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
      })
    );
  }
}
