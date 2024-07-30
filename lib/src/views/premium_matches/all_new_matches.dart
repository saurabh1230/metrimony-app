// import 'dart:async';
// import 'package:bureau_couple/getx/controllers/matches_controller.dart';
// import 'package:bureau_couple/src/constants/colors.dart';
// import 'package:bureau_couple/src/constants/sizedboxe.dart';
//
// import 'package:bureau_couple/src/models/matches_model.dart';
// import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
// import 'package:bureau_couple/src/utils/widgets/loader.dart';
// import 'package:get/get.dart';
// import 'package:bureau_couple/src/views/home/bookmark_screen.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:bureau_couple/src/models/LoginResponse.dart';
// import 'package:bureau_couple/src/utils/urls.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:intl/intl.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../apis/members_api.dart';
// import '../../apis/members_api/request_apis.dart';
// import '../../constants/assets.dart';
// import '../../constants/string.dart';
// import '../../constants/textfield.dart';
// import '../../constants/textstyles.dart';
// import '../../utils/widgets/buttons.dart';
// import '../../utils/widgets/common_widgets.dart';
// import '../../utils/widgets/dropdown_buttons.dart';
// import '../home/dashboard_widgets.dart';
// import '../user_profile/user_profile.dart';
//
// class AllMatchesScreen extends StatefulWidget {
//   final String religionFilter;
//   final LoginResponse response;
//
//   const AllMatchesScreen({Key? key, required this.response, required this.religionFilter,}) : super(key: key);
//   @override
//   State<AllMatchesScreen> createState() => _AllMatchesScreenState();
// }
//
// class _AllMatchesScreenState extends State<AllMatchesScreen> {
//   final TextEditingController searchController = TextEditingController();
//   final TextEditingController minHeight = TextEditingController();
//   final TextEditingController maxHeight = TextEditingController();
//   final TextEditingController maxWeightController = TextEditingController();
//
//   // List<MatchesModel> matches = [];
//   List<MatchesModel> bookmarkList = [];
//   List<bool> isLoadingList = [];
//   List<bool> like = [];
//
//   int _feet = 5;
//   int _inches = 0;
//
//   int _feet2 = 5;
//   int _inches2 = 0;
//
//   // List<bool> isbList = [];
//   bool isLoading = false;
//   int page = 1;
//   bool loading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.find<MatchesController>().getMatchesList(
//           "1",
//           widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
//           widget.religionFilter,
//           stateController.text,
//           minHeight.text,
//           maxHeight.text,
//           maxWeightController.text,
//           motherTongueFilter,'');
//     });
//   }
//
//   LoginResponse? response;
//   String religionFilter = '';
//   String marriedFilter = '';
//   double _value = 5.0;
//   double height = 0;
//   String? religionValue;
//   String? marriedValue;
//   String? motherTongueValue;
//   String motherTongueFilter = '';
//   final stateController = TextEditingController();
//
//   // bool like = false;
//   int val = 0;
//   //
//   // getMatches() {
//   //
//   //   isLoading = true;
//   //   getMatchesByGenderApi(
//   //     page: page.toString(),
//   //     gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
//   //     religion: widget.religionFilter,
//   //     // height: height == 5.0 ? "5-6" : height == 6.0  ? "6-7" : "7-8",
//   //     state: stateController.text,
//   //     minHeight: minHeight.text,
//   //     maxHeight: maxHeight.text, maxWeight: maxWeightController.text, motherTongue: motherTongueFilter,
//   //   ).then((value) {
//   //     // matches.clear();
//   //     if (mounted) {
//   //       setState(() {
//   //         if (value['status'] == true) {
//   //           matches.clear();
//   //           for (var v in value['data']['members']['data']) {
//   //             matches.add(MatchesModel.fromJson(v));
//   //             isLoadingList.add(false); //
//   //             like.add(false); // Add false for each new match
//   //           }
//   //           isLoading = false;
//   //           // val = value.length;
//   //           page++;
//   //         } else {
//   //           isLoading = false;
//   //         }
//   //       });
//   //     }
//   //   });
//   // }
//   //
//   // loadMore() {
//   //   print('ndnd');
//   //
//   //   // if (!isLoading) {
//   //   isLoading = true;
//   //   getMatchesByGenderApi(
//   //     religion: religionFilter,
//   //     page: page.toString(),
//   //     gender: widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
//   //     state: stateController.text,
//   //     minHeight: minHeight.text,
//   //     maxHeight: maxHeight.text,
//   //     maxWeight: maxWeightController.text,
//   //     motherTongue: motherTongueFilter,
//   //   ).then((value) {
//   //     // matches.clear();
//   //     if (mounted) {
//   //       setState(() {
//   //         if (value['status'] == true) {
//   //         for (var v in value['data']['members']['data']) {
//   //           matches.add(MatchesModel.fromJson(v));
//   //           isLoadingList.add(false); // Add false for each new match
//   //           like.add(false);
//   //         }
//   //         isLoading = false;
//   //         // val = value.length;
//   //         page++;
//   //         } else {
//   //           isLoading = false;
//   //         }
//   //       });
//   //     }
//   //   });
//   //   // }
//   // }
//
//
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     Get.find<MatchesController>().setOffset(1);
//     scrollController.addListener(() {
//       if (scrollController.position.pixels ==
//           scrollController.position.maxScrollExtent &&
//           Get.find<MatchesController>().matchesList != null &&
//           !Get.find<MatchesController>().isLoading) {
//         // int pageSize = (Get.find<NewController>().pageSize! / 10).ceil();
//         if (Get.find<MatchesController>().offset < 8) {
//           print(
//               "print ===========> offset before ${Get.find<MatchesController>().offset}");
//           // Get.find<RestaurantController>().setOffset(Get.find<RestaurantController>().offset+1);
//           // customPrint('end of the page');
//           Get.find<MatchesController>()
//               .setOffset(Get.find<MatchesController>().offset + 1);
//           Get.find<MatchesController>().showBottomLoader();
//           Get.find<MatchesController>().getMatchesList(
//               Get.find<MatchesController>().offset.toString(),
//               widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
//               religionFilter,
//               stateController.text,
//               minHeight.text,
//               maxHeight.text,
//               maxWeightController.text,
//               motherTongueFilter,'');
//           Get.find<MatchesController>().offset.toString();
//         }
//       }
//     });
//     return Scaffold(
//       appBar:  AppBar(backgroundColor: primaryColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           color: Theme.of(context).cardColor,
//           onPressed: () => Navigator.pop(context),
//         ) ,
//         centerTitle: false,
//         automaticallyImplyLeading: false,
//         title: Text(
//           "Matches",
//           style: styleSatoshiBold(size: 20, color: Colors.white),
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (builder) => const SavedMatchesScreen()));
//             },
//             child:  Padding(
//               padding: const EdgeInsets.only(right: 16.0,),
//               child: SvgPicture.asset(sortList,color: Colors.white,),
//             ),
//           ),
//           GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onTap: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return StatefulBuilder(
//                       builder: (BuildContext context, StateSetter setState) {
//                         return Container(
//                           width: 1.sw,
//                           height: 1.sh,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   sizedBox16(),
//                                   Text(
//                                     "Select Preferred Matches",
//                                     style: styleSatoshiLight(
//                                         size: 12, color: Colors.black),
//                                   ),
//                                   sizedBox16(),
//                                   Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(horizontal: 0.0),
//                                     child: SizedBox(
//                                       width: 1.sw,
//                                       child: CustomStyledDropdownButton(
//                                         items: const  [
//                                           "Hindu",
//                                           'Muslim',
//                                           "Jain",
//                                           'Buddhist',
//                                           'Sikh',
//                                           'Marathi'
//                                         ],
//                                         selectedValue: religionValue,
//                                         onChanged: (String? value) {
//                                           setState(() {
//                                             religionValue = value;
//                                             religionFilter = religionValue ?? '';
//
//                                           });
//                                         },
//                                         title: 'Religion',
//                                       ),
//                                     ),
//                                   ),
//                                   sizedBox16(),
//                                   Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(horizontal: 0.0),
//                                     child: SizedBox(
//                                       width: 1.sw,
//                                       child: CustomStyledDropdownButton(
//                                         items: const  [
//                                           "Hindi",
//                                           "Bhojpuri",
//                                           'Marathi',
//                                           "Bengali",
//                                           'Odia',
//                                           'Gujarati',
//                                         ],
//                                         selectedValue: motherTongueValue,
//                                         onChanged: (String? value) {
//                                           setState(() {
//                                             motherTongueValue = value;
//                                             motherTongueFilter = motherTongueValue ?? '';
//
//                                           });
//                                         },
//                                         title: 'Mother Tongue',
//                                       ),
//                                     ),
//                                   ),
//                                   sizedBox16(),
//                                   textBox(
//                                     context: context,
//                                     label: 'State',
//                                     controller: stateController,
//                                     hint: 'State',
//                                     length: null,
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your State';
//                                       }
//                                       return null;
//                                     },
//                                     onChanged: (value) {
//
//                                     },),
//                                   sizedBox16(),
//                                   Row(children: [
//                                     Expanded(child:  textBox(
//                                       read: true,
//                                       tap: () {
//                                         showModalBottomSheet(
//                                           context: context,
//                                           builder: (BuildContext builder) {
//
//                                             // Create the modal bottom sheet widget containing the time picker and close button
//                                             return SizedBox(
//                                               height: MediaQuery.of(context).copyWith().size.height / 3,
//                                               child: Column(
//                                                 children: [
//
//                                                   WillPopScope(
//                                                     onWillPop: () async {
//
//                                                       return false;
//                                                     },
//                                                     child: SizedBox(
//                                                       height:200,
//                                                       child: Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: CupertinoPicker(
//                                                               scrollController: FixedExtentScrollController(
//                                                                 initialItem: _feet - 5,
//                                                               ),
//                                                               itemExtent: 32,
//                                                               onSelectedItemChanged: (index) {
//                                                                 setState(() {
//                                                                   _feet = index + 5;
//                                                                 });
//                                                               },
//                                                               children: List.generate(
//                                                                 7, // 7 feet in the range from 5 to 11
//                                                                     (index) => Center(child: Text('${index + 5}\'')),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Expanded(
//                                                             child: CupertinoPicker(
//                                                               scrollController: FixedExtentScrollController(
//                                                                 initialItem: _inches,
//                                                               ),
//                                                               itemExtent: 32,
//                                                               onSelectedItemChanged: (index) {
//                                                                 setState(() {
//                                                                   _inches = index;
//                                                                 });
//                                                                 print(' $_feet-${_inches.toString().padLeft(2, '0')}');
//                                                               },
//                                                               children: List.generate(
//                                                                 12, // 12 inches in a foot
//                                                                     (index) => Center(child: Text('$index\"')),
//                                                               ),
//                                                             ),
//                                                           ),
//
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//
//                                                     children: [
//                                                       Flexible(
//                                                         child: ElevatedButton(
//                                                           style: ElevatedButton.styleFrom(
//                                                             backgroundColor: Colors.redAccent, // Change the background color to red
//                                                           ),
//                                                           onPressed: () {
//                                                             Navigator.pop(context);
//                                                           },
//                                                           child:  Text('Close',
//                                                             style: styleSatoshiMedium(
//                                                                 size: 13,
//                                                                 color: Colors.white),),
//                                                         ),
//                                                       ),
//                                                       SizedBox(width: 8,),
//                                                       Flexible(
//                                                         child: ElevatedButton(
//                                                           onPressed: () {
//                                                             setState(() {
//                                                               minHeight.text = '$_feet.${_inches.toString().padLeft(1, '0')}';
//                                                               // maxHeightController.text = '$_feet2-${_inches2.toString()}';
//                                                               print('$_feet.${_inches.toString().padLeft(1, '0')}');
//                                                             });
//                                                             Navigator.pop(context);
//                                                           },
//                                                           child:  Text('Save',
//                                                             style: styleSatoshiMedium(
//                                                                 size: 13,
//                                                                 color: Colors.black),),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       },
//                                       context: context,
//                                       label: 'Min Height',
//                                       controller: minHeight,
//                                       hint: 'Min Height',
//                                       length: null,
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'Please enter Min Height';
//                                         }
//                                         return null;
//                                       },
//                                       onChanged: (value) {
//
//                                       },),),
//                                     sizedBoxWidth15(),
//                                     Expanded(child:  textBox(
//                                       read: true,
//                                       tap: () {
//                                         showModalBottomSheet(
//                                           context: context,
//                                           builder: (BuildContext builder) {
//                                             // Create the modal bottom sheet widget containing the time picker and close button
//                                             return SizedBox(
//                                               height: MediaQuery.of(context).copyWith().size.height / 3,
//                                               child: Column(
//                                                 children: [
//                                                   WillPopScope(
//                                                     onWillPop: () async {
//                                                       return false;
//                                                     },
//                                                     child: SizedBox(
//                                                       height:200,
//                                                       child: Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: CupertinoPicker(
//                                                               scrollController: FixedExtentScrollController(
//                                                                 initialItem: _feet2 - 5,
//                                                               ),
//                                                               itemExtent: 32,
//                                                               onSelectedItemChanged: (index) {
//                                                                 setState(() {
//                                                                   _feet2 = index + 5;
//                                                                 });
//                                                               },
//                                                               children: List.generate(
//                                                                 7, // 7 feet in the range from 5 to 11
//                                                                     (index) => Center(child: Text('${index + 5}\'')),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Expanded(
//                                                             child: CupertinoPicker(
//                                                               scrollController: FixedExtentScrollController(
//                                                                 initialItem: _inches2,
//                                                               ),
//                                                               itemExtent: 32,
//                                                               onSelectedItemChanged: (index) {
//                                                                 setState(() {
//                                                                   _inches2 = index;
//                                                                 });
//                                                                 print(' $_feet2-${_inches2.toString().padLeft(2, '0')}');
//                                                               },
//                                                               children: List.generate(
//                                                                 12, // 12 inches in a foot
//                                                                     (index) => Center(child: Text('$index\"')),
//                                                               ),
//                                                             ),
//                                                           ),
//
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Row(mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: [
//                                                       Flexible(
//                                                         child: ElevatedButton(
//                                                           style: ElevatedButton.styleFrom(
//                                                             backgroundColor: Colors.redAccent, // Change the background color to red
//                                                           ),
//                                                           onPressed: () {
//                                                             Navigator.pop(context);
//                                                           },
//                                                           child:  Text('Close',
//                                                             style: styleSatoshiMedium(
//                                                                 size: 13,
//                                                                 color: Colors.white),),
//                                                         ),
//                                                       ),
//                                                       SizedBox(width: 8,),
//                                                       Flexible(
//                                                         child: ElevatedButton(
//                                                           onPressed: () {
//                                                             setState(() {
//                                                               maxHeight.text = '$_feet2.${_inches2.toString().padLeft(1, '0')}';
//                                                               // maxHeightController.text = '$_feet2-${_inches2.toString()}';
//                                                               print('$_feet2.${_inches2.toString().padLeft(1, '0')}');
//                                                             });
//                                                             Navigator.pop(context);
//                                                           },
//                                                           child:  Text('Save',
//                                                             style: styleSatoshiMedium(
//                                                                 size: 13,
//                                                                 color: Colors.black),),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       },
//                                       context: context,
//                                       label: 'Min Height',
//                                       controller: maxHeight,
//                                       hint: 'Min Height',
//                                       length: null,
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'Please enter Min Height';
//                                         }
//                                         return null;
//                                       },
//                                       onChanged: (value) {
//
//                                       },),),
//
//                                   ],),
//                                   sizedBox16(),
//                                   textBox(
//                                     context: context,
//                                     label: 'Max Weight',
//                                     controller:maxWeightController,
//                                     hint: 'Max Weight',
//                                     length: null,
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter Max Weight';
//                                       }
//                                       return null;
//                                     },
//                                     onChanged: (value) {
//                                     },),
//                                   sizedBox16(),
//                                   elevatedButton(
//                                       color: primaryColor,
//                                       context: context,
//                                       onTap: () {
//                                         setState(() {
//
//                                           // page = 1;
//                                           // isLoading = true;
//                                           Get.find<MatchesController>().getMatchesList(
//                                               "1",
//                                               widget.response.data!.user!.gender!.contains("M") ? "F" : "M",
//                                               religionFilter,
//                                               stateController.text,
//                                               minHeight.text,
//                                               maxHeight.text,
//                                               maxWeightController.text,
//                                               motherTongueFilter,
//                                           '');
//                                           // getMatches();
//                                           Navigator.pop(context);
//                                         });
//                                       },
//                                       title: "Apply")
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       });
//                 },
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.only(
//                   right: 16.0, top: 6, bottom: 6, left: 10),
//               child:  SvgPicture.asset(filter,
//                 color: Colors.white,),
//             ),
//           )
//         ],
//       ),
//       body:  GetBuilder<MatchesController>(builder: (matchesControl) {
//         return
//
//           matchesControl.matchesList != null ? matchesControl.matchesList!.isNotEmpty ? Padding(
//               padding: const EdgeInsets.only(left: 16.0, right: 16,top: 16,bottom: 0),
//               child: Stack(
//                 children: [
//                   Text("${matchesControl.matchesList!.length} Match Found Based on Preference",style: styleSatoshiLight(size: 14, color: Colors.black.withOpacity(0.60)),),
//                   // Text("${matches.length} members found"),
//                   sizedBox10(),
//                   Padding(
//                     padding:  const EdgeInsets.only(top: 35.0),
//                     child: ListView.separated(
//                       itemCount: matchesControl.matchesList!.length,
//                       itemBuilder: (context, i) {
//                         DateTime? birthDate = matchesControl.matchesList![i].basicInfo != null
//                             ? DateFormat('yyyy-MM-dd')
//                             .parse(matchesControl.matchesList![i].basicInfo!.birthDate!)
//                             : null;
//                         int age = birthDate != null
//                             ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
//                         return Column(
//                           children: [
//                             otherUserdataHolder(
//                               context: context,
//                               tap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (builder) =>
//                                         UserProfileScreen(
//                                           userId: matchesControl.matchesList![i].id.toString(),
//                                         ),
//                                   ),
//                                 );
//                               },
//                               // height:matchesControl.matchesList![i].physicalAttributes!.height == null ?
//                               // "" :
//                               // "${matchesControl.matchesList![i].physicalAttributes!.height ??
//                               //     ''}ft",
//                               imgUrl:
//                               '$baseProfilePhotoUrl${matchesControl.matchesList![i].image ?? ''}',
//                               state: matchesControl.matchesList![i]
//                                   .basicInfo
//                                   ?.presentAddress
//                                   ?.state ??
//                                   '',
//                               userName: matchesControl.matchesList![i].firstname == null &&
//                                   matchesControl.matchesList![i].lastname == null
//                                   ? "user"
//                                   : '${StringUtils.capitalize(
//                                   matchesControl.matchesList![i].firstname ??
//                                       'User')} ${StringUtils.capitalize(
//                                   matchesControl.matchesList![i].lastname ?? 'User')}',
//                               atributeReligion:
//                               ' ${matchesControl.matchesList![i].basicInfo?.religion ??
//                                   ''}',
//                               profession: "Software Engineer",
//                               Location:
//                               '${matchesControl.matchesList![i].address!.state ?? ''}${matchesControl.matchesList![i]
//                                   .address!.country ?? ''}',
//                               likedColor: Colors.grey,
//                               unlikeColor: primaryColor,
//                               button:
//                               // matches[i].bookmark == 1
//                               //     ? button(
//                               //         fontSize: 14,
//                               //         height: 30,
//                               //         width: 134,
//                               //         context: context,
//                               //         onTap: () {},
//                               //         title: "Request Sent")
//                               //     :
//                               // like[i] ? connectLoadingButton(context: context) :
//                               connectButton(
//                                   fontSize: 14,
//                                   height: 30,
//                                   width: 134,
//                                   context: context,
//                                   onTap: () {
//                                     // setState(() {
//                                     //   like[i] = !like[i];
//                                     // });
//                                     sendRequestApi(
//                                         memberId: matchesControl.matchesList![i]
//                                             .id
//                                             .toString())
//                                         .then((value) {
//                                       if (value['status'] == true) {
//                                         setState(() {
//                                           isLoadingList[i] = false;
//                                         });
//                                         ToastUtil.showToast(
//                                             "Connection Request Sent");
//                                       } else {
//                                         setState(() {
//                                           isLoadingList[i] = false;
//                                         });
//
//                                         List<dynamic> errors =
//                                         value['message']['error'];
//                                         String errorMessage = errors
//                                             .isNotEmpty
//                                             ? errors[0]
//                                             : "An unknown error occurred.";
//                                         Fluttertoast.showToast(
//                                             msg: errorMessage);
//                                       }
//                                     });
//                                   },
//                                   showIcon: matchesControl.matchesList![i].interestStatus == 2 ? false : true,
//                                   title:  matchesControl.matchesList![i].interestStatus == 2 ?  "Request Sent" : "Connect Now"),
//                               /* like[i] || matches[i].interestStatus == 2  ?
//                                   TickButton(size: 50,
//                                     tap: () {  },):
//                                   AddButton(size: 50,
//                                     tap: () {
//                                       setState(() {
//                                         // like[i] = !like[i];
//                                       });
//                                       sendRequestApi(
//                                           memberId: matches[i]
//                                               .id
//                                               .toString())
//                                           .then((value) {
//                                         if (value['status'] == true) {
//                                           setState(() {
//                                             isLoadingList[i] = false;
//                                           });
//                                           ToastUtil.showToast(
//                                               "Connection Request Sent");
//                                         } else {
//                                           setState(() {
//                                             isLoadingList[i] = false;
//                                           });
//
//                                           List<dynamic> errors =
//                                           value['message']['error'];
//                                           String errorMessage = errors
//                                               .isNotEmpty
//                                               ? errors[0]
//                                               : "An unknown error occurred.";
//                                           Fluttertoast.showToast(
//                                               msg: errorMessage);
//                                         }
//                                       });
//                                     },),*/
//                               /*  connectButton(
//
//                                       fontSize: 14,
//                                       height: 30,
//                                       width: 134,
//                                       context: context,
//                                       onTap: () {
//                                         setState(() {
//                                           like[i] = !like[i];
//                                         });
//                                         sendRequestApi(
//                                             memberId: matches[i]
//                                                 .id
//                                                 .toString())
//                                             .then((value) {
//                                           if (value['status'] == true) {
//                                             setState(() {
//                                               isLoadingList[i] = false;
//                                             });
//                                             ToastUtil.showToast(
//                                                 "Connection Request Sent");
//                                           } else {
//                                             setState(() {
//                                               isLoadingList[i] = false;
//                                             });
//
//                                             List<dynamic> errors =
//                                             value['message']['error'];
//                                             String errorMessage = errors
//                                                 .isNotEmpty
//                                                 ? errors[0]
//                                                 : "An unknown error occurred.";
//                                             Fluttertoast.showToast(
//                                                 msg: errorMessage);
//                                           }
//                                         });
//                                       },
//                                       showIcon: matches[i].interestStatus == 2 ? false : true,
//                                       title:  matches[i].interestStatus == 2 ?  "Request Sent" : "Connect Now"),*/
//                               bookmark: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     like[i] = !like[i];
//                                   });
//                                   print(matchesControl.matchesList![i].bookmark);
//                                   matchesControl.matchesList![i].bookmark == 1 ?
//                                   matchesControl.unSaveBookmarkApi(matchesControl.matchesList![i].profileId.toString()) :
//                                   matchesControl.bookMarkSaveApi(matchesControl.matchesList![i].profileId.toString());
//                                   // getMatches();
//                                 },
//                                 child: /*like[i] ?
//                                   Icon(
//                                     CupertinoIcons.heart_fill, color:like[i] ?  primaryColor : Colors.grey ,
//                                     size: 22,):*/
//
//                                 Icon(
//                                   CupertinoIcons.heart_fill, color:  /*matchesControl.matchesList![i].bookmark == 1 ? primaryColor :*/ Colors.grey,
//                                   size: 22,),
//                               ),
//                               dob: '$age yrs',
//                               text: matchesControl.matchesList![i].basicInfo?.aboutUs ??
//                                   '',
//                             )
//                           ],
//                         );
//                         // else {
//                         //   if (val >= 8 && isLoading) {
//                         //     return Center(
//                         //       child: SizedBox(),
//                         //     );
//                         //   } else if (val < 8) {
//                         //     return SizedBox.shrink();
//                         //   } else {
//                         //     return SizedBox();
//                         //   }
//                         // }
//                         // else {
//                         //   if (isLoading) {
//                         //     return customLoader(size: 40);
//                         //   } else {
//                         //     return const SizedBox();
//                         //   }
//                         // }
//                       },
//                       separatorBuilder: (BuildContext context, int index) =>
//                       const SizedBox(
//                         height: 16,
//                       ),
//                     ),
//                   ),
//                   if (matchesControl.isLoading)
//                     Center(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               top: 20),
//                           child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<
//                                   Color>(
//                                   Theme.of(context).primaryColor)),
//                         ))
//                   else
//                     const SizedBox(),
//
//                 ],
//               ),
//             ) :
//           Text('No Matches Yet',) : const ShimmerWidget();
//
//       }),);
//   }
//
// }
//
//
