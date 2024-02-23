import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:bureau_couple/src/views/home/profile/profile_screen.dart';
import 'package:bureau_couple/src/views/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../apis/members_api.dart';
import '../../apis/members_api/request_apis.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../models/matches_model.dart';
import '../../utils/urls.dart';
import '../premium_matches/all_new_matches.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../user_profile/user_profile.dart';
import 'connect/connect_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

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
   // bool loading = false;
   List<MatchesModel> matches = [];
   LoginResponse? response;

   /*@override
   void initState() {
     super.initState();
     getMatches();
   }
*/
   getMatches() {
     isLoading = true;
     getNewMatchesApi(page: page.toString()).then((value) {
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
                buildStack(),
                sizedBox28(),
                Text("8 members looking for you",
                style: styleSatoshiBold(size: 18, color: color1C1C1c),),
                sizedBox18(),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_,i) {
                    return Column(
                      children: [
                        Expanded(
                          flex:2,
                          child: Container(
                            height: 65,
                            width: 65,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: Image.asset("assets/images/ic_profile_male1.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text("Eleanor",
                          style: styleSatoshiBlack(size: 14, color: Colors.black.withOpacity(0.60)),),
                        )
                      ],
                    );
                  }, separatorBuilder: (BuildContext context, int index) => SizedBox(width: 16,),),
                ),
                SizedBox(height: 20,),
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
                GestureDetector(
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
                ),
                SizedBox(height: 30,),
                Text('New Matches',
                  style: styleSatoshiBold(size: 18, color: Colors.black),),
                Text("Members who joined recently",
                  style: styleSatoshiMedium(size: 14,
                    color: color1C1C1c.withOpacity(0.60),
                  ),
                ),
                sizedBox14(),
                isLoading ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: primaryColor,
                      size: 60,
                    )) :
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: matches.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (builder) => const UserProfileScreen(userId: '',))
                        );
                      },
                      child: Stack(
                        children: [

                          Container(
                            height: 500,
                            clipBehavior: Clip.hardEdge,
                            decoration:  const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(Radius.circular(10.0),),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:matches[i].image != null ? '$baseProfilePhotoUrl${matches[i].image}' : '',
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
                          Positioned(
                            top:6,
                            right:6,
                            left:6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // customContainer(
                                //   child: Text("13",
                                //     style: styleSatoshiLight(size: 13, color: Colors.white),),
                                //   radius: 6,
                                //   color: Colors.black.withOpacity(0.30), horizontal: 12, vertical: 3, click: () {  },
                                // ),
                                Image.asset(icIdea,
                                  height: 20,
                                  width: 20,)
                              ],
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
                                  '${matches[i].firstname} \n  ${matches[i].lastname}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      // "Jassica S.",
                                  style: styleSatoshiBold(size: 22, color: Colors.white),),
                                Text(
                                    '${matches[i].username}',
                                  // "Jassica S.",
                                  style: styleSatoshiRegular(size: 13, color: Colors.white),),
                                sizedBox18(),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Center(
                                    child:
                                    isLoadingList[i] ?
                                    loadingButton(
                                      width: 100,
                                      height: 34,
                                      radius: 20,
                                      context: context,
                                        ):
                                    button(
                                      width: 100,
                                      height: 34,
                                      radius: 20,
                                      context: context, onTap: () {
                                      setState(() {
                                        isLoadingList[i] = true;
                                      });
                                      print(matches[i].id.toString());
                                      sendRequestApi(memberId: matches[i].id.toString()
                                        // id: career[0].id.toString(),
                                      )
                                          .then((value) {
                                        if (value['status'] == true) {
                                          setState(() {
                                            isLoadingList[i] = false;
                                          });
                                          ToastUtil.showToast("Connection Request Sent");
                                          print('done');
                                        } else {
                                          setState(() {
                                            isLoadingList[i] = false;
                                          });

                                          List<dynamic> errors =
                                          value['message']['error'];
                                          String errorMessage = errors.isNotEmpty
                                              ? errors[0]
                                              : "An unknown error occurred.";
                                          Fluttertoast.showToast(msg: errorMessage);
                                        }
                                      });
                                    },
                                      title: "connect",
                                      style: styleSatoshiMedium(size: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
             /* GridView.count(
                physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 10.0,
              shrinkWrap: true,
              childAspectRatio: 0.65,
              children: List.generate(matches.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (builder) => const UserProfileScreen(userId: '',))
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration:  const BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10.0),),
                        ),
                        child: Image.asset("assets/images/ic_new_matches.png",
                        fit: BoxFit.cover,),
                      ),
                      Positioned(
                        top:6,
                        right:6,
                        left:6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customContainer(
                              child: Text("13",
                              style: styleSatoshiLight(size: 13, color: Colors.white),),
                              radius: 6,
                              color: Colors.black.withOpacity(0.30), horizontal: 12, vertical: 3, click: () {  },
                            ),
                            Image.asset(icIdea,
                            height: 20,
                            width: 20,)
                          ],
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
                              '${matches[index].firstname} ${matches[index].lastname}'
                              "Jassica S.",
                            style: styleSatoshiBold(size: 22, color: Colors.white),),
                            Text("Jassica S.",
                              style: styleSatoshiRegular(size: 13, color: Colors.white),),
                            sizedBox18(),

                            Center(
                              child:
                              button(
                                width: 100,
                                height: 34,
                                radius: 20,
                                context: context, onTap: () {},
                                title: "connect",
                                style: styleSatoshiMedium(size: 14, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },),
            ),*/
                sizedBox16(),
                button(context: context, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => const AllNewMatchesScreen()));
                }, title: 'See All New Matches'),


                SizedBox(height: 50,),


              ],
            ),
          ),
        ),
      ),

    );
  }

  Stack buildStack() {
    return Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 60,),
                  Container(
                      child: SvgPicture.asset(icHomeProfileHolder)),
                ],
              ),
              Center(
                child: CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 7.0,
                  percent: 0.7,
                  center: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 100,
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
              Positioned(
                bottom: 19,
                left: 20,
                right: 20,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // response?.data?.user?.username?.toString() ?? 'User',
                        "${SharedPrefs().getUserName()}",
                      style: styleSatoshiBold(size: 22, color: Colors.white),),
                      Text(
                        "${SharedPrefs().getProfileId()}",
                        // "LV-8768787",
                        style: styleSatoshiBold(size: 15, color: Colors.white),),
                    ],
                  ),
                ),
              )
            ],
          );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SvgPicture.asset(icHomeLogo,
        height: 35,
        width: 44,),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("New Delhi",
            style: styleSatoshiBold(size: 15, color: Colors.black),
            ),
          ),
          // SizedBox(width: 5,),
          // SvgPicture.asset(icArrowDown,
          // height: 8,)
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) => ConnectScreen()));

          },
            child: Icon(Icons.person,
            size: 32,)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) => NotificationScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SvgPicture.asset(icBell,
              height: 28,
            width: 28,),
          ),
        )

      ],
      automaticallyImplyLeading: false,

    );
  }
}



