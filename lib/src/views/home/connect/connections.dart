import 'dart:async';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
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

  List<ConnectedModel> matches = [];
  List<ConnectedModel> bookmarkList = [];
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



  getMatches() {
    isLoading = true;
    getConnectedMatchesApi(
      page: page.toString(),
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) {
            for (var v in value['data']['data']) {
              matches.add(ConnectedModel.fromJson(v));
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

  loadMore() {
    print('ndnd');
    // if (!isLoading) {
    isLoading = true;
    getConnectedMatchesApi(
      page: page.toString(),
      // gender: "",
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) {
            for (var v in value['data']['data']) {
              matches.add(ConnectedModel.fromJson(v));
              // isLoadingList.add(false); // Add false for each new match
              // like.add(false);
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
                          // DateTime? birthDate = matches[i].basicInfo != null
                          //     ? DateFormat('yyyy-MM-dd')
                          //     .parse(matches[i].basicInfo!.birthDate!)
                          //     : null;
                          // int age = birthDate != null
                          //     ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                          return Column(
                            children: [
                              GestureDetector(onTap : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) =>
                                        UserProfileScreen(
                                          userId: matches[i].profile!.id.toString(),
                                        ),
                                  ),
                                );
                              },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 160,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            color: colorDarkCyan.withOpacity(0.03),
                                            // color:Colors.red,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          '$baseProfilePhotoUrl${matches[i].profile!.image.toString()}',
                                          fit: BoxFit.fill,
                                          errorWidget: (context, url, error) =>
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(icLogo,
                                                  height: 40,
                                                  width: 40,),
                                              ),
                                          progressIndicatorBuilder: (a, b, c) =>
                                              customShimmer(height: 170, /*width: 0,*/),
                                        ),

                                        // child: Image.asset(images[i],
                                        // height: 170,),
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  '${StringUtils.capitalize(
                                                matches[i].profile!.firstname.toString())} ${StringUtils.capitalize(
                                                      matches[i].profile!.lastname.toString())}',
                                                  // child: Text(filteredNames[i],
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: styleSatoshiBold(
                                                      size: 19, color: Colors.black),
                                                ),
                                              ),
                                              const SizedBox(width: 10,),


                                            ],
                                          ),
                                          const SizedBox(height: 4,),
                                          Row(
                                            children: [
                                              Text(
                                                matches[i].profile!.email.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,

                                                style: styleSatoshiMedium(
                                                    size: 13,
                                                    color: Colors.black.withOpacity(
                                                        0.70)),
                                              ),
                                              const SizedBox(width: 6,),
                                            ],
                                          ),
                                          const SizedBox(height: 4,),
                                          Text(
                                            matches[i].profile!.mobile.toString().substring(2),
                                            maxLines: 2,
                                            style: styleSatoshiMedium(
                                                size: 13,
                                                color: Colors.black.withOpacity(0.80)),
                                          ),
                                          const SizedBox(height: 4,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Image.asset(icLocation,
                                                  height: 17,
                                                  width: 17,),
                                              ),
                                              const SizedBox(width: 2,),
                                              Expanded(
                                                flex: 10,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      // 'Location',
                                                      '${matches[i].profile!.basicInfo!.presentAddress!.city}',
                                                      // "New York, USA",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,

                                                      style: styleSatoshiMedium(
                                                          size: 13,
                                                          color: Colors.black.withOpacity(
                                                              0.70)),
                                                    ),
                                                    SizedBox(width: 3,),
                                                    Container(
                                                      height: 4,
                                                      width: 5,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(width: 3,),

                                                    Text(
                                                      '${matches[i].profile!.basicInfo!.presentAddress!.state}',

                                                      // '${matches[i].address!.country}',
                                                      // "New York, USA",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,

                                                      style: styleSatoshiMedium(
                                                          size: 13,
                                                          color: Colors.black.withOpacity(
                                                              0.70)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),


                                          sizedBox16(),
                                          connectButton(
                                              fontSize: 14,
                                              height: 30,
                                              width: 134,
                                              context: context,
                                              onTap: () {},
                                              title: "Connected"),],
                                      ),
                                    )
                                  ],
                                ),
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


