import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../apis/members_api.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/string.dart';
import '../../models/matches_model.dart';
import '../../utils/urls.dart';
import '../premium_matches/all_new_matches.dart';
import '../user_profile/user_profile.dart';
import 'connect/connect_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'matches/married_category_screen.dart';
import 'matches/religion_category_screen.dart';
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
   }


   List<bool> isLoadingList = [];
   bool isLoading = false;
   int page = 1;
   List<MatchesModel> matches = [];

   getMatches() {
     isLoading = true;
     getNewMatchesApi(page: page.toString(),
       gender: widget.response.data!.user!.gender!.contains("M") ? "F" :"M",).then((value) {
       if (mounted) {
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
       }
     });
   }

   List<String> categoryImage = ["assets/icons/ic_pray.png","assets/icons/ic_married.png"];
  List<String> categoryTitle = ["Filter by Religion","Filter By Mother Tongue"];
  List<Color> color = [colorE2b93b,colorEb5757];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: CustomRefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return getMatches();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // buildStack(),
                Text("${matches.length} members looking for you",
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
                                imageUrl:
                                '$baseProfilePhotoUrl${matches[i].image ?? ''}',
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

                Text('Category By Filter',
                  style: styleSatoshiBold(size: 18, color: Colors.black),),
                sizedBox16(),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: categoryImage.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio:1.9,
                  ),
                  itemBuilder: (_, i) {
                    List<Widget Function(BuildContext)> screenRoutes = [
                          (_) =>ReligionCategory(response: widget.response,),
                          (_) => MarriedCategory(response: widget.response,),
                      // Add more screen routes as needed
                    ];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: screenRoutes[i]),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: color[i],
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Image.asset(categoryImage[i],
                               height: 30,
                               color: Colors.white,),
                               sizedBox6(),
                               Text(categoryTitle[i],
                                 style: styleSatoshiBold(size: 10, color: Colors.white),),
                             ],
                           )

                          ],
                        ),
                      ),
                    );
                  },
                ),
                sizedBox16(),
                ///-----------premium match section ------------------
              ///-----------premium match section ------------------
              /*  GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const AllPremiumMatchesScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Premium Matches',
                      style: styleSatoshiBold(size: 18, color: Colors.black),),
                      Row(
                        children: [
                          Text('See All',
                            style: styleSatoshiBold(size: 14,
                                color: color1C1C1c.withOpacity(0.60)),
                          ),
                          SizedBox(width: 5,),
                          SvgPicture.asset("assets/icons/ic_small_arrow_right.svg")
                        ],
                      ),
                    ],
                  ),
                ),
                Text("Recently upgraded Premium member",
                  style: styleSatoshiMedium(size: 14,
                      color: color1C1C1c.withOpacity(0.60),
                  ),
                ),
                sizedBox18(),
                SizedBox(
                  height: 350,
                  // width: 170,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_,i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (builder) => const UserProfileScreen(userId: '',))
                          );

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.3,
                            color: Colors.black.withOpacity(0.50))
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                // flex:2,
                                child: Container(
                                  // height: 65,
                                  // width: 65,
                                  decoration:  BoxDecoration(
                                     borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Image.asset("assets/icons/Rectangle 12051.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 13,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all( 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Jassica S.",
                                        style: styleSatoshiBold(size: 18, color: Colors.black),
                                      ),
                                      sizedBox8(),
                                      Text("5’ 4”, Hindi",
                                        style: styleSatoshiLight(size: 13, color: Colors.black),
                                      ),
                                      Text("Agarwal,",
                                        style: styleSatoshiLight(size: 13, color: Colors.black),
                                      ),
                                      Text("Mumbai, Maharashtra`",
                                        style: styleSatoshiLight(size: 13, color: Colors.black),
                                      ),
                                      const Spacer(),
                                      Center(
                                        child:
                                        button(
                                          width: 164,
                                          height: 33,
                                          radius: 8,
                                          context: context, onTap: () {},
                                          title: "connect",
                                          style: styleSatoshiMedium(size: 14, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16,),),
                ),
                sizedBox20(),*/
                ///-----------premium match section ------------------
                ///-----------premium match section ------------------
     /*           GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                        const ProfileScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      image: const DecorationImage(image: AssetImage("assets/images/ic_goldbg.png"),
                      fit: BoxFit.cover)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:3,
                              child: Text("Complete your profile for more responses",
                                style: styleSatoshiBold(size: 16,
                                  color: color1C1C1c,
                                ),
                              ),
                            ),
                            SizedBox(width: 35,),
                            Expanded(
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: const BoxDecoration(
                                  color: colorE6C583,
                                  shape: BoxShape.circle
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:3,
                              child: Text("The first thing that members look for is your profile",
                                style: styleSatoshiRegular(size: 14,
                                  color: color1C1C1c,
                                ),
                              ),
                            ),
                            SizedBox(width: 35,),
                            Expanded(
                              child: elevatedButton(
                                height: 31,
                                  radius: 18,
                                  context: context,
                                  onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                                  const ProfileScreen()));
                                  },
                                  title: 'Edit',
                              style: styleSatoshiBold(size: 12, color: primaryColor))
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),*/

                ///*************************************************************

                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                        AllNewMatchesScreen(response: widget.response,)));
                  },
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('New Matches',
                        style: styleSatoshiBold(size: 18, color: Colors.black),),
                      Text('See All',
                        style: styleSatoshiBold(size: 12, color: Colors.black),),
                    ],
                  ),
                ),
                Text("Members who joined recently",
                  style: styleSatoshiMedium(size: 14,
                    color: color1C1C1c.withOpacity(0.60),
                  ),
                ),
                sizedBox14(),
                if (isLoading) Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: primaryColor,
                      size: 60,
                    )) else GridView.builder(
                    shrinkWrap: true,
                    itemCount: matches.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.7,
                     ),
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
                            height: 400,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${StringUtils.capitalize(matches[i].firstname ?? 'User')}\n${StringUtils.capitalize(matches[i].lastname ?? 'User')}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                  style: styleSatoshiBold(size: 18, color: Colors.white),),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '$age yrs',
                                          style: styleSatoshiRegular(size: 13, color: Colors.white),
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
                                          "${matches[i].physicalAttributes!.height ?? ''} ft",
                                          style: styleSatoshiRegular(size: 13, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  matches[i].basicInfo?.religion ?? '',
                                  style: styleSatoshiRegular(size: 13, color: Colors.white),
                                ),
                                Text(
                                matches[i].basicInfo?.presentAddress?.state ?? '',

                                  style: styleSatoshiRegular(size: 13, color: Colors.white),
                                ),
                                sizedBox18(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                sizedBox16(),
                // button(context: context, onTap: () {
                //
                // }, title: 'See All New Matches'),

                const SizedBox(height: 50,),


              ],
            ),
          ),
        ),
      ),

    );
  }

// /*  Stack buildStack() {
//     return Stack(
//             children: [
//               Column(
//                 children: [
//                   SizedBox(height: 60,),
//                   Container(
//                       child: SvgPicture.asset(icHomeProfileHolder)),
//                 ],
//               ),
//               Center(
//                 child: CircularPercentIndicator(
//                   radius: 120.0,
//                   lineWidth: 7.0,
//                   percent: 1,
//                   center: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 100,
//                       width: 100,
//                       clipBehavior: Clip.hardEdge,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle
//                       ),
//                       child: CachedNetworkImage(
//                         imageUrl:'$baseProfilePhotoUrl${SharedPrefs().getProfilePhoto()}',
//                         fit: BoxFit.cover,
//                         errorWidget: (context, url, error) =>
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.asset(icLogo,
//                                 height: 40,
//                                 width: 40,),
//                             ),
//                         progressIndicatorBuilder: (a, b, c) =>
//                             customShimmer(height: 0, *//*width: 0,*//*),
//                       ),
//                     ),
//                   ),
//                   progressColor: colorGreen,
//                 ),
//               ),
//               Positioned(
//                 bottom: 19,
//                 left: 20,
//                 right: 20,
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         // response?.data?.user?.username?.toString() ?? 'User',
//                         "${SharedPrefs().getUserName()}",
//                         style: styleSatoshiBold(size: 22, color: Colors.white),),
//                       Text(
//                         "${SharedPrefs().getProfileId()}",
//                         // "LV-8768787",
//                         style: styleSatoshiBold(size: 15, color: Colors.white),),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//   }*/

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const EditBasicInfoScreen()));
              },
              child: CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 2.0,
                percent: 1,
                center: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: 45,
                    width: 45,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle
                    ),
                    child: CachedNetworkImage(
                      imageUrl:'$baseProfilePhotoUrl${SharedPrefs().getProfilePhoto()}',
                      fit: BoxFit.cover,
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
                progressColor: colorGreen,
              ),
            ),
            const SizedBox(width: 10,),
            Text(StringUtils.capitalize('${SharedPrefs().getUserName()}'),
              style: styleSatoshiBold(size: 24, color: Colors.black),
            ),
          ],
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) => const ConnectScreen()));
          },
            child: 
            const Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: Icon(CupertinoIcons.bell,
                color: Colors.black,
                size: 26,
              ),
            )),

      ],
      automaticallyImplyLeading: false,

    );
  }
}



