import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../apis/members_api.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/textfield.dart';
import '../../constants/textstyles.dart';
import '../../models/matches_model.dart';
import '../../utils/widgets/buttons.dart';
import '../../utils/widgets/common_widgets.dart';
import '../../utils/widgets/loader.dart';
import '../user_profile/user_profile.dart';
import 'dashboard_widgets.dart';

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
    getMatches();
  }

  bool isSearch = false;
  List<MatchesModel> matches = [];

// MatchesData matches = MatchesModel();
  bool isLoading = false;

  getMatches() {
    isLoading = true;
    var resp = getMatchesApi(page: '1');
    resp.then((value) {
      matches.clear();
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            for (var v in value['data']['members']['data']) {
              matches.add(MatchesModel.fromJson(v));

              print(matches.length);
            }
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text("Saved Matches",
          style: styleSatoshiBold(size: 22, color: Colors.black),),
        actions: [
       /*   backButton(context: context,
              image: icSearch,
              onTap: (){
                setState(() {
                  isSearch = !isSearch;
                });
              }),
          const SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: backButton(context: context, image: icFilter, onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (builder) => const FilterMatchesScreen()));
            }),
          ),*/
        ],
      ),
      body: isLoading ? Loading() :
      CustomRefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return getMatches();
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
                    return otherUserdataHolder(
                        context: context,
                        tap: () {},
                        imgUrl:   '${matches[i].image.toString()}',
                        userName: '${matches[i].firstname} ${matches[i].lastname}',
                        atributeReligion: "5 ft 4 in  •  Khatri Hindu",
                        profession: "Software Engineer",
                        Location: "India",

                        // Location: '${matches[i].address!.country}'
                        likedColor: Colors.grey,
                        unlikeColor: primaryColor,
                         button: button(
                        fontSize: 14,
                        height: 30,
                        width: 134,
                        context: context,
                        onTap: () {},
                        title: "Connect Now"),);
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