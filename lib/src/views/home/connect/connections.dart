import 'dart:async';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/widgets/Custom_image_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:bureau_couple/src/views/home/bookmark_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../getx/features/widgets/custom_empty_match_widget.dart';
import '../../../apis/members_api.dart';
import '../../../apis/members_api/bookmart_api.dart';
import '../../../apis/members_api/request_apis.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizedboxe.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/connections_models.dart';
import '../../../models/matches_model.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/loader.dart';
import '../../user_profile/user_profile.dart';
import '../dashboard_widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ConnectionScreen extends StatefulWidget {
  final LoginResponse response;

  const ConnectionScreen({Key? key, required this.response}) : super(key: key);

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final TextEditingController searchController = TextEditingController();

  List<ConnectionModel> matches = [];
  List<ConnectionModel> bookmarkList = [];
  List<bool> isLoadingList = [];
  List<bool> like = [];

  // List<bool> isbList = [];
  bool isLoading = false;
  int page = 1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    Get.find<ProfileController>().getBasicInfoApi();
    getMatches();
  }

  LoginResponse? response;

  getMatches() {
    isLoading = true;
    getConnectedMatchesApi(
      page: page.toString(), userId: Get.find<ProfileController>().userDetails!.data!.user!.id.toString(),
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) {
            for (var v in value['data']['data']) {
              matches.add(ConnectionModel.fromJson(v));
              print(matches.length);
              // print(matches[0].firstname);
              // isLoadingList.add(false); //
              // like.add(false); // Add false for each new match
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
  //
  // loadMore() {
  //   print('ndnd');
  //   // if (!isLoading) {
  //   isLoading = true;
  //   getConnectedMatchesApi(
  //     page: page.toString(),userId: Get.find<ProfileController>().userDetails!.data!.user!.id!.toString(),
  //     // gender: "",
  //   ).then((value) {
  //     if (mounted) {
  //       setState(() {
  //         if (value['status'] == true) {
  //           for (var v in value['data']['data']) {
  //             matches.add(ConnectedModel.fromJson(v));
  //             // isLoadingList.add(false); // Add false for each new match
  //             // like.add(false);
  //           }
  //           isLoading = false;
  //           page++;
  //         } else {
  //           isLoading = false;
  //         }
  //       });
  //     }
  //   });
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "Connected Matches",
          style: styleSatoshiBold(size: 20, color: Colors.white),
        ),
        actions: const [

        ],
      ),
      body:  GetBuilder<MatchesController>(builder: (matchesControl) {
        return isLoading
            ? const ShimmerWidget()
            : matches.isEmpty || matches == null
            ? const CustomEmptyMatchScreen()
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16,top: 16,bottom: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${matches.length} members connected"),
                sizedBox10(),
                Container(
                  height: 1.sh, padding: const EdgeInsets.only(bottom: 200),
                  child: LazyLoadScrollView(
                    isLoading: isLoading,
                    onEndOfPage: () {
                      // loadMore();
                    },
                    child: ListView.separated(
                      itemCount: matches.length ,
                      itemBuilder: (context, i) {
                        DateTime? birthDate;
                        int age = 0;

                        if (matchesControl.matchesList != null &&
                            matchesControl.matchesList![i].basicInfo != null &&
                            matchesControl.matchesList![i].basicInfo!.birthDate != null) {
                          birthDate = DateFormat('yyyy-MM-dd').parse(matchesControl.matchesList![i].basicInfo!.birthDate!);

                          // Calculate age
                          age = DateTime.now().difference(birthDate).inDays ~/ 365;
                        }
                        return  Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 0.5,color: Theme.of(context).primaryColor)
                          ),
                          child: Row(
                            children: [
                              CustomNetworkImageWidget(
                                image: '$baseProfilePhotoUrl${matches[i].user!.image.toString()}',
                                height: 60,
                                width: 60,
                                radius: 12,
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: Column(crossAxisAlignment : CrossAxisAlignment.start,
                                  children: [
                                    Text('${StringUtils.capitalize(
                                        matches[i].user!.firstname.toString())} ${StringUtils.capitalize(
                                        matches[i].user!.lastname.toString())}',
                                      style: styleSatoshiMedium(size: 15, color: Colors.black),),
                                    Text(
                                      matches[i].user!.email ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: styleSatoshiMedium(size: 12, color: Colors.black),
                                    ),

                                  ],
                                ),
                              ),
                              IconButton(onPressed: () {}, icon: Icon(Icons.message,color: Theme.of(context).primaryColor,))
                              // CachedNetworkImage(
                              //   imageUrl:
                              //   '$baseProfilePhotoUrl${matches[i].profile!.image.toString()}',
                              //   fit: BoxFit.fill,
                              //   errorWidget: (context, url, error) =>
                              //       Padding(padding: const EdgeInsets.all(8.0),
                              //         child: Image.asset(icLogo,
                              //           height: 40, width: 40,),),
                              //   progressIndicatorBuilder: (a, b, c) => customShimmer(height: 170, /*width: 0,*/),),




                            ],
                          ),

                        );
                        // DateTime? birthDate =
                        // matchesControl.matchesList![i].basicInfo !=
                        //     null
                        //     ? DateFormat('yyyy-MM-dd').parse(
                        //     matchesControl.matchesList![i]
                        //         .basicInfo!.birthDate!)
                        //     : null;
                        // int age = birthDate != null
                        //     ? DateTime.now()
                        //     .difference(birthDate)
                        //     .inDays ~/
                        //     365
                        //     : 0;
                        // if (i < matches.length) {
                        //   // DateTime? birthDate = matches[i].basicInfo != null
                        //   //     ? DateFormat('yyyy-MM-dd')
                        //   //     .parse(matches[i].basicInfo!.birthDate!)
                        //   //     : null;
                        //   // int age = birthDate != null
                        //   //     ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                        //
                        //   // return Container(
                        //   //   decoration: BoxDecoration(
                        //   //     color: Theme.of(context).cardColor,
                        //   //   borderRadius: BorderRadius.circular(12),
                        //   //     border: Border.all(width: 0.5,color: Theme.of(context).primaryColor)
                        //   //   ),
                        //   //   child: Column(
                        //   //     children: [
                        //   //       GestureDetector(onTap : () {
                        //   //         Navigator.push(
                        //   //           context,
                        //   //           MaterialPageRoute(
                        //   //             builder: (builder) =>
                        //   //                 UserProfileScreen(
                        //   //                   userId: matches[i].profile!.id.toString(),
                        //   //                 ),
                        //   //           ),
                        //   //         );
                        //   //       },
                        //   //         child: Row(
                        //   //           mainAxisAlignment: MainAxisAlignment.start,
                        //   //           crossAxisAlignment: CrossAxisAlignment.center,
                        //   //           children: [
                        //   //             Expanded(
                        //   //               child: Container(
                        //   //                 height: 160,
                        //   //                 clipBehavior: Clip.hardEdge,
                        //   //                 decoration: BoxDecoration(
                        //   //                     color: colorDarkCyan.withOpacity(0.03),
                        //   //                     // color:Colors.red,
                        //   //                     borderRadius: BorderRadius.circular(10)
                        //   //                 ),
                        //   //                 child: CachedNetworkImage(
                        //   //                   imageUrl:
                        //   //                   '$baseProfilePhotoUrl${matches[i].profile!.image.toString()}',
                        //   //                   fit: BoxFit.fill,
                        //   //                   errorWidget: (context, url, error) =>
                        //   //                       Padding(
                        //   //                         padding: const EdgeInsets.all(8.0),
                        //   //                         child: Image.asset(icLogo,
                        //   //                           height: 40,
                        //   //                           width: 40,),
                        //   //                       ),
                        //   //                   progressIndicatorBuilder: (a, b, c) =>
                        //   //                       customShimmer(height: 170, /*width: 0,*/),
                        //   //                 ),
                        //   //
                        //   //                 // child: Image.asset(images[i],
                        //   //                 // height: 170,),
                        //   //               ),
                        //   //             ),
                        //   //             const SizedBox(width: 20,),
                        //   //             Expanded(
                        //   //               flex: 2,
                        //   //               child: Column(
                        //   //                 mainAxisAlignment: MainAxisAlignment.start,
                        //   //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //   //                 children: [
                        //   //                   Row(
                        //   //                     children: [
                        //   //                       Expanded(
                        //   //                         flex: 4,
                        //   //                         child: Text(
                        //   //                           '${StringUtils.capitalize(
                        //   //                         matches[i].profile!.firstname.toString())} ${StringUtils.capitalize(
                        //   //                               matches[i].profile!.lastname.toString())}',
                        //   //                           // child: Text(filteredNames[i],
                        //   //                           overflow: TextOverflow.ellipsis,
                        //   //                           maxLines: 1,
                        //   //                           style: styleSatoshiBold(
                        //   //                               size: 19, color: Colors.black),
                        //   //                         ),
                        //   //                       ),
                        //   //
                        //   //
                        //   //
                        //   //                     ],
                        //   //                   ),
                        //   //                   // const SizedBox(height: 4,),
                        //   //                   // Row(
                        //   //                   //   children: [
                        //   //                   //     Text(
                        //   //                   //       matches[i].profile!.email.toString(),
                        //   //                   //       overflow: TextOverflow.ellipsis,
                        //   //                   //       maxLines: 2,
                        //   //                   //
                        //   //                   //       style: styleSatoshiMedium(
                        //   //                   //           size: 13,
                        //   //                   //           color: Colors.black.withOpacity(
                        //   //                   //               0.70)),
                        //   //                   //     ),
                        //   //                   //     const SizedBox(width: 6,),
                        //   //                   //   ],
                        //   //                   // ),
                        //   //                   // const SizedBox(height: 4,),
                        //   //                   // Text(
                        //   //                   //   matches[i].profile!.mobile.toString().substring(2),
                        //   //                   //   maxLines: 2,
                        //   //                   //   style: styleSatoshiMedium(
                        //   //                   //       size: 13,
                        //   //                   //       color: Colors.black.withOpacity(0.80)),
                        //   //                   // ),
                        //   //                   const SizedBox(height: 9,),
                        //   //                   Row(
                        //   //                     children: [
                        //   //                       Container( padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                        //   //                         decoration : BoxDecoration(
                        //   //                             color: primaryColor.withOpacity(0.10),borderRadius: BorderRadius.circular(12)
                        //   //                         ),
                        //   //                         child: Text(
                        //   //                           'Age ${age} yrs ',
                        //   //                           overflow: TextOverflow.ellipsis, maxLines: 1,
                        //   //                           style: styleSatoshiLarge(size: 16, color: Colors.black),),
                        //   //                       ),
                        //   //                       Container(
                        //   //                         height: 4,
                        //   //                         width: 4,
                        //   //                         decoration: const BoxDecoration(
                        //   //                           shape: BoxShape.circle,
                        //   //                           color: Colors.white,
                        //   //                         ),
                        //   //                       ),
                        //   //                       const SizedBox(width: 6,),
                        //   //                       Container(
                        //   //                         height: 4,
                        //   //                         width: 4,
                        //   //                         decoration: const BoxDecoration(
                        //   //                           shape: BoxShape.circle,
                        //   //                           color: Colors.black,
                        //   //                         ),
                        //   //                       ),
                        //   //                       const SizedBox(width: 6,),
                        //   //                       Container( padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                        //   //                         decoration : BoxDecoration(
                        //   //                             color: Colors.greenAccent.withOpacity(0.30),borderRadius: BorderRadius.circular(12)
                        //   //                         ),
                        //   //                         child: Text(
                        //   //                           matchesControl.matchesList?[i].basicInfo?.religion?.name ?? '',
                        //   //                           overflow: TextOverflow.ellipsis,
                        //   //                           maxLines: 1,
                        //   //                           style: styleSatoshiLarge(size: 16, color: Colors.black),
                        //   //                         ),
                        //   //
                        //   //                       ),
                        //   //
                        //   //                       // const SizedBox(width: 6,),
                        //   //
                        //   //                       // Text(
                        //   //                       //   height,
                        //   //                       //   overflow: TextOverflow.ellipsis,
                        //   //                       //   maxLines: 1, style: styleSatoshiMedium(size: 16, color: Colors.white),),
                        //   //                       // const SizedBox(width: 6,),
                        //   //                       // Container(
                        //   //                       //   height: 4,
                        //   //                       //   width: 4,
                        //   //                       //   decoration: const BoxDecoration(
                        //   //                       //     shape: BoxShape.circle,
                        //   //                       //     color: Colors.white,
                        //   //                       //   ),
                        //   //                       // ),
                        //   //                       // Text(
                        //   //                       //   atributeReligion,
                        //   //                       //   maxLines: 1,
                        //   //                       //   overflow: TextOverflow.ellipsis,
                        //   //                       //   style: styleSatoshiMedium(
                        //   //                       //       size: 16,
                        //   //                       //       color: Colors.white),
                        //   //                       // ),
                        //   //                     ],
                        //   //                   ),
                        //   //                   const SizedBox(height: 8,),
                        //   //                   Text(
                        //   //                     '${matchesControl.matchesList?[i].address?.state ?? ''} • ${matchesControl.matchesList?[i].address?.country ?? ''} ',
                        //   //                     overflow: TextOverflow.ellipsis,
                        //   //                     maxLines: 2,
                        //   //                     style: styleSatoshiLarge(
                        //   //                         size: 16,
                        //   //                         color: Colors.black),
                        //   //                   ),
                        //   //
                        //   //
                        //   //                   const SizedBox(height: 14,),
                        //   //                   connectButton(
                        //   //                       fontSize: 14,
                        //   //                       height: 30,
                        //   //                       width: 100,
                        //   //                       context: context,
                        //   //                       onTap: () {},
                        //   //                   title: "Chat "),
                        //   //                 ],
                        //   //               ),
                        //   //             )
                        //   //           ],
                        //   //         ),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // );
                        // } else {
                        //   if (isLoading) {
                        //     return customLoader(size: 40);
                        //   } else {
                        //     return const SizedBox();
                        //   }
                        // }
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


