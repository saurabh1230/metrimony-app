import 'dart:async';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/widgets/Custom_image_widget.dart';
import 'package:bureau_couple/getx/features/widgets/matches_shimmer_widget.dart';
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
      page: page.toString(), userId: Get.find<ProfileController>().profile!.id.toString(),
    ).then((value) {
      if (mounted) {
        setState(() {
          if (value['status'] == true) {
            for (var v in value['data']['data']) {
              matches.add(ConnectionModel.fromJson(v));
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
            ? const CustomEmptyMatchScreen(title: "No Connected Matches",isBackButton: true,)
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
                            ],
                          ),
                        );
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


