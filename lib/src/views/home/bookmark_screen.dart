import 'package:bureau_couple/src/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../apis/members_api/bookmart_api.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/textfield.dart';
import '../../constants/textstyles.dart';
import '../../models/saved_bookmark_model.dart';
import '../../utils/widgets/buttons.dart';
import '../../utils/widgets/common_widgets.dart';
import '../../utils/widgets/loader.dart';
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
  List<SavedBookMarkModel> matches = [];

// MatchesData matches = MatchesModel();
  bool isLoading = false;

  // getSavedMatches() {
  //   isLoading = true;
  //   var resp = savedMatchesApi();
  //   resp.then((value) {
  //     matches.clear();
  //     if (mounted) {
  //       if (value != null && value['status'] == true && value['data'] != null && value['data']['shortlists']['data'] != null) {
  //         setState(() {
  //           for (var v in value['data']['shortlists']['data']) {
  //             matches.add(SavedBookMarkModel.fromJson(v));
  //           }
  //           print("ce");
  //           print(matches.length);
  //           isLoading = false;
  //         });
  //       } else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //     }
  //   });
  //
  // }
  getSavedMatches() {
    isLoading = true;
    savedMatchesApi().then((value) {
      if (mounted) {
        setState(() {
          try {
            if (value != null && value['status'] != null) {
              if (value['status'] == true) {
                if (value['data'] != null &&
                    value['data']['shortlists'] != null &&
                    value['data']['shortlists']['data'] != null) {
                  for (var v in value['data']['shortlists']['data']) {
                    matches.add(SavedBookMarkModel.fromJson(v));
                  }
                }
              }
            }
          } catch (e) {
            print('Error in parsing API response: $e');
          } finally {
            isLoading = false;
          }
        });
      }
    }).catchError((error) {
      print('Error in API call: $error');
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: Padding(
      padding: const EdgeInsets.only(left: 16),
      child: backButton(
          context: context,
          image: icArrowLeft,
          onTap: () {
            Navigator.pop(context);
          }),),
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(" Matches",
          style: styleSatoshiBold(size: 22, color: Colors.black),),
      ),
      body: isLoading ? Loading() :
      CustomRefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return getSavedMatches();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10,
                bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isSearch ?
                textBoxPreIcon(
                    context: context,
                    label: 'Search',
                    img: icSearch,
                    controller: searchController,
                    hint: 'Search',
                    length: 40,
                    validator: null,
                    onChanged: null) :
                SizedBox.shrink(),
                // sizedBox14(),
                Text(
                  "${matches.length.toString()} members Saved by you",
                  style: styleSatoshiMedium(
                      size: 14, color: Colors.black.withOpacity(0.50)),),
                sizedBox13(),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: matches.length,
                  itemBuilder: (_, i) {
                    // DateTime? birthDate = matches[i].basicInfo != null ? DateFormat('yyyy-MM-dd').parse(matches[i].basicInfo!.birthDate!) : null;
                    // int age = birthDate != null ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                    return otherUserdataHolder(
                        context: context,
                        tap: () {},
                        height:"",
                        imgUrl:   '$baseProfilePhotoUrl${matches[i].profile?.image.toString()}',
                        userName: '${matches[i].profile?.firstname} ${matches[i].profile?.lastname}',
                        atributeReligion: "Religion: ${matches[i].profile?.religion ?? ""}",
                        profession: "Software Engineer",
                        Location: "India",
                        dob:'',
                        state:'',

                        // Location: '${matches[i].address!.country}'
                        likedColor: Colors.grey,
                        unlikeColor: primaryColor,
                         button: button(
                        fontSize: 14,
                        height: 30,
                        width: 134,
                        context: context,
                        onTap: () {},
                        title: "Connect Now"),
                        bookmark: LikeButton(
                        onTap: (isLiked) async {
                          print(matches[i].profileId.toString());
                          try {
                            // Call your API to save the bookmark
                            var result = await unSaveBookMarkApi(memberId: matches[i].profileId.toString());
                            if (result['status'] == true) {
                              // Handle successful response
                              setState(() {
                                // isLoadingList[i] = !isLiked; // Update isLoadingList to reflect the bookmark status
                              });
                              ToastUtil.showToast("Bookmark Saved");
                            } else {
                              // Handle error response
                              List<dynamic> errors = result['message']['error'];
                              String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                              Fluttertoast.showToast(msg: errorMessage);
                            }
                          } catch (error) {
                            print('Error: $error');
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
                            color : primaryColor , // Use green color if liked, else use primaryColor
                            size: 22,
                          );
                        },
                      ),
                      bookMarkTap: () {  },
                    );
                    // return GestureDetector(
                    //   behavior: HitTestBehavior.translucent,
                    //   onTap: () {
                    //     Navigator.push(
                    //         context, MaterialPageRoute(
                    //         builder: (builder) => const UserProfileScreen())
                    //     );
                    //   },
                    //   child: Container(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Expanded(
                    //           child: Container(
                    //             height: 160,
                    //             clipBehavior: Clip.hardEdge,
                    //             decoration: BoxDecoration(
                    //                 color: colorDarkCyan.withOpacity(0.03),
                    //                 // color:Colors.red,
                    //                 borderRadius: BorderRadius.circular(10)
                    //             ),
                    //             child: CachedNetworkImage(
                    //               imageUrl:
                    //               '${matches[i].image.toString()}',
                    //               fit: BoxFit.cover,
                    //               errorWidget: (context, url, error) =>
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Image.asset(icLogo,
                    //                       height: 40,
                    //                       width: 40,),
                    //                   ),
                    //               progressIndicatorBuilder: (a, b, c) =>
                    //                   customShimmer(height: 170, /*width: 0,*/),
                    //             ),
                    //
                    //             // child: Image.asset(images[i],
                    //             // height: 170,),
                    //           ),
                    //         ),
                    //         const SizedBox(width: 20,),
                    //         Expanded(
                    //           flex: 2,
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   Expanded(
                    //                     flex: 4,
                    //                     child: Text(
                    //                       '${matches[i].firstname} ${matches[i]
                    //                           .lastname}',
                    //                       // child: Text(filteredNames[i],
                    //                       overflow: TextOverflow.ellipsis,
                    //                       maxLines: 1,
                    //                       style: styleSatoshiBold(
                    //                           size: 19, color: Colors.black),
                    //                     ),
                    //                   ),
                    //                   SizedBox(width: 10,),
                    //                   Expanded(
                    //                     child: Image.asset(icBookMark,
                    //                       height: 24,
                    //                       width: 24,),
                    //                   )
                    //                 ],
                    //               ),
                    //               Text(
                    //                 // '${matches[i].physicalAttributes!.height} cm • ${matches[i].religion}',
                    //                 "5 ft 4 in  •  Khatri Hindu",
                    //                 maxLines: 2,
                    //                 style: styleSatoshiMedium(
                    //                     size: 13,
                    //                     color: Colors.black.withOpacity(0.80)),
                    //               ),
                    //               sizedBox16(),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 children: [
                    //                   Expanded(
                    //                     child: Image.asset(icBag,
                    //                       height: 17,
                    //                       width: 17,),
                    //                   ),
                    //                   SizedBox(width: 10,),
                    //
                    //                   Expanded(
                    //                     flex: 10,
                    //                     child: Text("Software Engineer",
                    //                       overflow: TextOverflow.ellipsis,
                    //                       maxLines: 2,
                    //
                    //                       style: styleSatoshiMedium(
                    //                           size: 13,
                    //                           color: Colors.black.withOpacity(
                    //                               0.70)),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               sizedBox8(),
                    //               Row(
                    //                 children: [
                    //                   Expanded(
                    //                     child: Image.asset(icLocation,
                    //                       height: 17,
                    //                       width: 17,),
                    //                   ),
                    //                   SizedBox(width: 10,),
                    //                   Expanded(
                    //                     flex: 10,
                    //                     child: Text(
                    //                       '${matches[i].address!.country}',
                    //                       // "New York, USA",
                    //                       overflow: TextOverflow.ellipsis,
                    //                       maxLines: 2,
                    //
                    //                       style: styleSatoshiMedium(
                    //                           size: 13,
                    //                           color: Colors.black.withOpacity(
                    //                               0.70)),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               sizedBox16(),
                    //               button(
                    //                   fontSize: 14,
                    //                   height: 30,
                    //                   width: 134,
                    //                   context: context,
                    //                   onTap: () {},
                    //                   title: "Connect Now"),
                    //             ],
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //
                    //   ),
                    // );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 30,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}