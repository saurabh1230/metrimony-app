import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:bureau_couple/src/utils/widgets/custom_image_widget.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:bureau_couple/src/views/home/matches/filter_matches_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../apis/members_api.dart';
import '../../apis/members_api/request_apis.dart';
import '../../apis/profile_apis/get_profile_api.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/string.dart';
import '../../models/matches_model.dart';
import '../../models/profie_model.dart';
import '../../utils/urls.dart';
import '../premium_matches/all_new_matches.dart';
import '../user_profile/user_profile.dart';
import 'connect/connect_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'profile/edit_basic_info.dart';


class HomeScreen extends StatefulWidget {
  final LoginResponse response;

  const HomeScreen({super.key, required this.response,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   bool loading =false;
   @override
   void initState() {
     super.initState();
     getMatches();
     getPreferredMatch();
     profileDetail();
     Get.find<ProfileController>().getUserDetailsApi();

   }


   List<bool> isLoadingList = [];
   bool isLoading = false;
   int page = 1;
   List<MatchesModel> matches = [];
   List<MatchesModel> preferredMatches = [];
   List<bool> like = [];

   getMatches() {
     matches.clear();
     isLoading = true;
     getNewMatchesApi(page: page.toString(),
       gender: widget.response.data!.user!.gender!.contains("M") ? "F" :"M", religion: '',).then((value) {
       if (mounted) {
         setState(() {
           if (value['status'] == true) {
             for (var v in value['data']['members']['data']) {
               matches.add(MatchesModel.fromJson(v));
               isLoadingList.add(false);
               like.add(false); // // Add false for each new match
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

   getPreferredMatch() {
     preferredMatches.clear();
     isLoading = true;
     getNewMatchesApi(page: page.toString(),
       gender: widget.response.data!.user!.gender!.contains("M") ? "F" :"M", religion: widget.response.data!.user!.religion!.toString(),).then((value) {
       if (mounted) {
         setState(() {
           if (value['status'] == true) {
             for (var v in value['data']['members']['data']) {
               preferredMatches.add(MatchesModel.fromJson(v));
               isLoadingList.add(false);
               like.add(false); // // Add false for each new match
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


   ProfileModel  profile =  ProfileModel();
   // bool isLoading = false;
   profileDetail() {
     isLoading = true;
     var resp = getProfileApi();
     resp.then((value) {
       if(value['status'] == true) {
         // setState(() {
           profile = ProfileModel.fromJson(value);
           isLoading = false;
           like.add(false); //
           SharedPrefs().setProfilePhoto(profile.data!.user!.image.toString());
         // });
       } else {
         setState(() {
           isLoading = false;
         });
       }

     });
   }

   List<String> categoryImage = ["assets/icons/ic_pray.png","assets/icons/ic_married.png"];
   List<String> categoryTitle = ["Filter by Religion","Filter By Language"];
   List<Color> color = [colorE2b93b,colorEb5757];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: CustomRefreshIndicator(
        onRefresh: () {
          setState(() {isLoading = true;});
          return getMatches();
          },
        child: !isLoading ?  SingleChildScrollView(
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // buildStack(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${matches.length} Members for you",
                      style: styleSatoshiBold(size: 18, color: color1C1C1c),),
                      // sizedBox10(),
                      isLoading ?
                          customLoader(size: 30):
                      SizedBox(
                        height: 140,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                            itemCount: matches.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_,i) {
                          return GestureDetector(
                            onTap: () {

                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (builder) =>  UserProfileScreen(userId:matches[i].id.toString(),)));

                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex:2,
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: '$baseProfilePhotoUrl${matches[i].image ?? ''}',
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) =>
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(icLogo,
                                              height: 40,
                                              width: 40,),
                                          ),
                                          progressIndicatorBuilder: (a, b, c) =>
                                          customShimmer(height: 170,),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                   '${StringUtils.capitalize(matches[i].firstname ?? '')}\n${StringUtils.capitalize(matches[i].lastname ?? 'User')}',
                                  maxLines: 2,
                                  textAlign:TextAlign.center,
                                  style: styleSatoshiBlack(size: 14, color: Colors.black.withOpacity(0.60)),),
                                ),
                              ],
                            ),
                          );
                        }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16,),),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Category By Filter',
                    style: styleSatoshiBold(size: 16, color: Colors.black),),
                    sizedBox16(),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(onTap :() {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (builder) =>  FilterMatchesScreen(response: widget.response, filter: Get.find<ProfileController>().userDetails!.data!.user!.religion!.name.toString(), motherTongue: '', minHeight: '', maxHeight: '', maxWeight: '', based: '',))
                            );

                          },
                            child: Column(
                              children: [
                                Image.asset(fReligion,height: 55,),
                                sizedBox6(),
                                Text("Religion",style: styleSatoshiLight(size: 12, color: colorDA4F7A),)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(onTap :() {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (builder) =>  FilterMatchesScreen(response: widget.response, filter: Get.find<ProfileController>().userDetails!.data!.user!.address!.state!, motherTongue:'', minHeight: '', maxHeight: '', maxWeight: '', based: '',))
                            );

                          },
                            child: Column(
                              children: [
                                Image.asset(fCommunity,height: 55,),
                                sizedBox6(),
                                Text("State",style: styleSatoshiLight(size: 12, color: colorF27047),)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(onTap :() {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (builder) =>  FilterMatchesScreen(response: widget.response, filter: '', motherTongue:'', minHeight: '', maxHeight: '', maxWeight:  '', based: '',))
                            );},
                            child: Column(
                              children: [
                                Image.asset(fAge,height: 55,),
                                sizedBox6(),
                                Text("Weight",style: styleSatoshiLight(size: 12, color: color7859BC),)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (builder) =>  FilterMatchesScreen(response: widget.response, filter: '', motherTongue:widget.response.data!.user!.motherTongue!.toString(), minHeight: '', maxHeight: '', maxWeight: '', based: 'Language',))
                            );
                          },
                            child: Column(
                              children: [
                                Image.asset(flanguage,height: 55,),
                                sizedBox6(),
                                Text("Mother Tongue",style: styleSatoshiLight(size: 12, color: colorF2AB47),)
                              ],
                            ),
                          ),
                        ),

                      ],),],),
                ),
                sizedBox16(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                        AllMatchesScreen(response: widget.response, religionFilter: '', )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('New Matches',
                          style: styleSatoshiBold(size: 18, color: Colors.black),),
                        Text('See All',
                          style: styleSatoshiBold(size: 12, color: Colors.black),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("All New Members ",
                    style: styleSatoshiMedium(size: 14,
                      color: color1C1C1c.withOpacity(0.60),
                    ),
                  ),
                ),
                sizedBox14(),
                if (isLoading) Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: primaryColor,
                      size: 60,
                    )) else SizedBox(height: 200,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: matches.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, i) {
                      DateTime? birthDate = matches[i].basicInfo != null ? DateFormat('yyyy-MM-dd').parse(matches[i].basicInfo!.birthDate!) : null;
                      int age = birthDate != null ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (builder) =>  UserProfileScreen(userId:matches[i].id.toString(),))
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 200,width: 160,
                              clipBehavior: Clip.hardEdge,
                              decoration: const  BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0),),
                              ),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.srcOver,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: matches[i].image != null ? '$baseProfilePhotoUrl${matches[i].image}' : '',
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(icLogo,
                                          height: 40,
                                          width: 40,),
                                      ),
                                  progressIndicatorBuilder: (a, b, c) =>
                                      customShimmer(height: 0, /*width: 0,*/),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom:0,
                              left:20,
                              right:20,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${StringUtils.capitalize(matches[i].firstname ?? '')} ${StringUtils.capitalize(matches[i].lastname ?? 'User')}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: styleSatoshiBold(size: 14, color: Colors.white),),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text('$age yrs',
                                                  style: styleSatoshiRegular(size: 10, color: Colors.white),),
                                                const SizedBox(width: 6,),
                                                Container(
                                                  height: 4,
                                                  width: 4,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),),
                                                const SizedBox(width: 6,),
                                                Text(
                                                  "${matches[i].physicalAttributes!.height ?? ''} ft",
                                                  style: styleSatoshiRegular(size: 10, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(matches[i].basicInfo?.religion?.name ?? '',
                                                    style: styleSatoshiRegular(size: 13, color: Colors.white),),
                                                  Text(overflow: TextOverflow.ellipsis,maxLines: 2,
                                                    matches[i].basicInfo?.presentAddress?.state ?? '',
                                                    style: styleSatoshiRegular(size: 13, color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            like[i] || matches[i].interestStatus == 2  ?
                                            TickButton(tap: () {  },):
                                            AddButton(tap: () {
                                              setState(() {
                                                // like[i] = !like[i];
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
                                            },)
                                          ],
                                        ),

                                        sizedBox18(),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => SizedBox(width: 16,),
                  ),
                ),
                sizedBox16(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                        AllMatchesScreen(response: widget.response, religionFilter: widget.response.data!.user!.religion!.toString(),)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Preferred Matches',
                          style: styleSatoshiBold(size: 18, color: Colors.black),),
                        Text('See All',
                          style: styleSatoshiBold(size: 12, color: Colors.black),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Members Based On your Preference",
                    style: styleSatoshiMedium(size: 14,
                      color: color1C1C1c.withOpacity(0.60),
                    ),
                  ),
                ),
                sizedBox14(),
                if (isLoading) Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: primaryColor,
                      size: 60,
                    )) else SizedBox(height: 200,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(left: 16),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: preferredMatches.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, i) {
                        DateTime? birthDate = preferredMatches[i].basicInfo != null ? DateFormat('yyyy-MM-dd').parse(preferredMatches[i].basicInfo!.birthDate!) : null;
                        int age = birthDate != null ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (builder) =>  UserProfileScreen(userId:preferredMatches[i].id.toString(),))
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 200,width: 160,
                              clipBehavior: Clip.hardEdge,
                              decoration: const  BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0),),
                              ),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.srcOver,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: preferredMatches[i].image != null ? '$baseProfilePhotoUrl${preferredMatches[i].image}' : '',
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(icLogo,
                                          height: 40,
                                          width: 40,),
                                      ),
                                  progressIndicatorBuilder: (a, b, c) =>
                                      customShimmer(height: 0, /*width: 0,*/),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom:0,
                              left:20,
                              right:20,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${StringUtils.capitalize(preferredMatches[i].firstname ?? '')} ${StringUtils.capitalize(preferredMatches[i].lastname ?? 'User')}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                          style: styleSatoshiBold(size: 14, color: Colors.white),),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '$age yrs',
                                                  style: styleSatoshiRegular(size: 10, color: Colors.white),
                                                ),
                                                const SizedBox(width: 6,),
                                                Container(
                                                  height: 4,
                                                  width: 4,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),),
                                                const SizedBox(width: 6,),
                                                Text(
                                                  "${preferredMatches[i].physicalAttributes!.height ?? ''} ft",
                                                  style: styleSatoshiRegular(size: 10, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  preferredMatches[i].basicInfo?.religion?.name ?? '',
                                                  style: styleSatoshiRegular(size: 13, color: Colors.white),
                                                ),
                                                Text(overflow: TextOverflow.ellipsis,maxLines: 1,
                                                  preferredMatches[i].basicInfo?.presentAddress?.state ?? '',

                                                  style: styleSatoshiRegular(size: 13, color: Colors.white),
                                                ),
                                              ],
                                            ),

                                            like[i] || preferredMatches[i].interestStatus == 2  ?
                                            TickButton(tap: () {  },):
                                            AddButton(tap: () {
                                              setState(() {
                                                like[i] = !like[i];
                                              });
                                              sendRequestApi(
                                                  memberId: preferredMatches[i]
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
                                            },)
                                          ],
                                        ),

                                        sizedBox18(),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                                        }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16,),
                                      ),
                    ),
                sizedBox16(),
                const SizedBox(height: 50,),


              ],
            ),
          ),
        )
            : const HomeShimmer(),
      ),

    );
  }



  AppBar buildAppBar() {
    return AppBar(backgroundColor: primaryColor,
      shape: const  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(0),
        ),
      ),
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const EditBasicInfoScreen()));
              },
              child: ClipOval(child: CustomImageWidget(image: '$baseProfilePhotoUrl${SharedPrefs().getProfilePhoto()}',height: 40,width: 40,)),

            ),
            const SizedBox(width: 10,),
            Text(StringUtils.capitalize(widget.response.data!.user!.firstname!.toString()),
              style: styleSatoshiBold(size: 18, color: Colors.white),
            ),
          ],
        ),
      ),
      actions: [
        GestureDetector(behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) => const ConnectScreen()));
          },
            child: 
             Padding(
              padding:  const EdgeInsets.all(14.0),
              child: Image.asset(icBell,height: 24,color: Colors.white,)
            )),

      ],
      automaticallyImplyLeading: false,

    );
  }
}



class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmerEffect(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // buildStack(),
            Text("Members looking for you",
              style: styleSatoshiBold(size: 18, color: color1C1C1c),),
            sizedBox10(),
            SizedBox(
              height: 140,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_,i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(fReligion,height: 65,),
                      Text(
                        'User',
                        maxLines: 2,
                        textAlign:TextAlign.center,
                        style: styleSatoshiBlack(size: 14, color: Colors.black.withOpacity(0.60)),),
                    ],
                  );
                }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16,),),
            ),
            // const SizedBox(height: 20,),

            Text('Category By Filter',
              style: styleSatoshiBold(size: 16, color: Colors.black),),
            sizedBox16(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(fReligion,height: 55,),
                      sizedBox6(),
                      Text("Religion",style: styleSatoshiLight(size: 12, color: colorDA4F7A),)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(fCommunity,height: 55,),
                      sizedBox6(),
                      Text("State",style: styleSatoshiLight(size: 12, color: color7BB972),)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(fAge,height: 55,),
                      sizedBox6(),
                      Text("Weight",style: styleSatoshiLight(size: 12, color: color7859BC),)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(flanguage,height: 55,),
                      sizedBox6(),
                      Text("Language",style: styleSatoshiLight(size: 12, color: colorF2AB47),)
                    ],
                  ),
                ),

              ],),
            sizedBox16(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Preferred Matches',
                  style: styleSatoshiBold(size: 18, color: Colors.black),),
                Text('See All',
                  style: styleSatoshiBold(size: 12, color: Colors.black),),
              ],
            ),
            Text("Members Based On your Preference",
              style: styleSatoshiMedium(size: 14,
                color: color1C1C1c.withOpacity(0.60),
              ),
            ),
            sizedBox14(),
            GridView.builder(
              shrinkWrap: true,
              itemCount :2,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (_, i) {
                return Stack(
                  children: [
                    Container(
                      height: 400,
                      clipBehavior: Clip.hardEdge,
                      decoration: const  BoxDecoration(color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10.0),),
                      ),

                    ),

                  ],
                );
              },
            ),
            sizedBox16(),
          ],
        ),
      ),
    );
  }
}
