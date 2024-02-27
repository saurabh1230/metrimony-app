import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:bureau_couple/src/views/signIn/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../apis/members_api/request_apis.dart';
import '../../apis/other_user_api/other_user_profile_details.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/textstyles.dart';
import '../../models/other_person_details_models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/widgets/buttons.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  const UserProfileScreen({super.key, required this.userId,});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final List<String>? interest = ["Football","Nature","Language","Fashion","Photography","Music","Writing"];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getProfileDetails();

  }
  OtherProfileModel model = OtherProfileModel();
  // List<OtherProfileModel> model = [];
  getProfileDetails() {
    isLoading = true;
    var resp = getOtherUserProfileApi(otherUserId: widget.userId);
    resp.then((value) {
      // matches.clear();
      if(mounted) {
        if(value['status'] == true) {
          setState(() {
            model = OtherProfileModel.fromJson(value);
          /*  for (var v in value['data']['matches']) {
              model = OtherProfileModel.fromJson(v);
              // model.add(OtherProfileModel.fromJson(v));
            }*/
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

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: isLoading ?Loading() :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.60),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                      '$baseProfilePhotoUrl${model.data?.matches?.image ?? ''}',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(icLogo,
                                height: 200,
                                width: 200,),
                            ),
                          ),
                      progressIndicatorBuilder: (a, b, c) =>
                          customShimmer(height: 170, /*width: 0,*/),
                    ),
                  ),
                  Positioned(
                    bottom: 26,
                    left: 26,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("27 year",
                        //   style: styleSatoshiMedium(size: 16, color: Colors.white),),
                        Row(
                          children: [
                            Text(
                              "${model.data!.matches!.firstname ?? '- - - - '} ${model.data!.matches!.lastname ?? 'User'}",
                              // "Cody Fisher ",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: styleSatoshiBold(size: 30, color: Colors.white),),
                            SvgPicture.asset(icVerified,
                              height: 24,
                              width: 24,)
                          ],
                        ),
                        Text(
                          model.data?.matches?.religion ?? '- - - - -',
                            // (model.data!.matches!.religion == null || model.data!.matches!.religion!.isEmpty) ? "" : "${model.data!.matches!.religion}",
                          // "Khatri Hindu",
                          style: styleSatoshiBold(size: 16, color: Colors.white),),
                        sizedBox16(),
                        loading ? loadingButton(
                            height: 30,
                            width: 134,
                            context: context) :button(
                            fontSize: 14,
                            height: 30,
                            width: 134,
                            context: context,
                            onTap: () {
                              setState(() {
                                loading = true;
                              });

                              sendRequestApi(memberId: model.data!.matches!.id!.toString()
                                // id: career[0].id.toString(),
                              )
                                  .then((value) {
                                if (value['status'] == true) {
                                  setState(() {
                                    loading = false;
                                  });
                                  ToastUtil.showToast("Connection Request Sent");
                                  print('done');
                                } else {
                                  setState(() {
                                    loading = false;
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
                            title: "Connect Now")
                      ],
                    ),
                  ),

                ],
              ),
              // sizedBox20(),
              // Text("About",
              //   style: styleSatoshiBold(size: 19, color: color22172A),),
              // Text("My name is Cody and I enjoy meet new people and in a partner, I'm looking for someone who is kind, honest, and has a good sense of humor.",
              //   style:styleSatoshiLight(size: 14, color: color14152B.withOpacity(0.60)),
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 3,),
              sizedBox20(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 22,right: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("You Match of her Preferences",
                            style: styleSatoshiRegular(size: 14, color: Colors.white),),
                          Text("9/14",
                            style: styleSatoshiRegular(size: 16, color: Colors.white),)
                        ],
                      ),
                    ),

                  ),
                  sizedBox20(),
                  // buildProfileRow(image: icAgeIcon, title: 'Age', text: '41 to 45'),
                  buildProfileRow(image: icHeightIcon, title: 'Height',
                      text:
                      model.data?.matches?.physicalAttributes?.height ?? '- - - - -'
                      // (model.data!.matches!.physicalAttributes!.height == null ||
                      //     model.data!.matches!.physicalAttributes!.height!.isEmpty) ? "" : "${model.data!.matches!.physicalAttributes!.height}",
                  ),
                  buildProfileRow(image: icChildrenIcon, title: 'Family', text: 'Father: ${model.data!.matches!.family?.fatherName ?? "not added yet"}, Mother: ${model.data!.matches!.family?.motherName ?? "not added yet"},'),
                  buildProfileRow(image: icReligionIcon, title: 'Religion / Community', text:  '${model.data!.matches?.religion ?? "not added yet"}'),
                  buildProfileRow(image: icMotherToungeIcon,
                      title: 'Mother Tongue',
                      text: "${model.data!.matches?.motherTongue ?? "not added yet"}"),
                  // buildProfileRow(image: icGotraIcon, title: 'Gotra', text: '41 to 45'),
                  Text("Professional Info",
                    style: styleSatoshiBold(size: 16, color: color1C1C1c),),
                  sizedBox10(),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.asset(icUserEducation,
                                  height: 20,
                                  width: 20,
                            ),
                            ),
                            Expanded(child: Text(
                            // (model.data!.matches!.educationInfo![0].degree == null ||
    // model.data!.matches!.educationInfo![0].degree!.isEmpty) ? "Not Added Yet" : "${model.data!.matches!.educationInfo![0].degree }",
                            "${model.data?.matches?.educationInfo != null && model.data!.matches!.educationInfo!.isNotEmpty ? model.data!.matches!.educationInfo![0].degree ?? "not added yet" : "not added yet"}",

    // "Computer Science",
                            style: styleSatoshiMedium(size: 14, color: Colors.black.withOpacity(0.70),
                            ),
                            ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Image.asset(icUserBagIcon,
                                height: 20,
                                width: 20,)),
                            Expanded(child: Text(
                          "${model.data?.matches?.basicInfo?.profession ?? "not added yet"}",
    // "Software Engineer",
                           style: styleSatoshiMedium(
                             size: 14,
                             color: Colors.black.withOpacity(0.70),
                           ),
                            ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  sizedBox14(),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Image.asset(icUserHeightIcon,
                              height: 20,
                              width: 20,)),
                            Expanded(child: Text(
                              "${model.data?.matches?.physicalAttributes?.height ?? "not added yet"}",
                              // "5 foot, 4 inch",
                              style: styleSatoshiMedium(
                                size: 14,
                                color: Colors.black.withOpacity(0.70),
                              ),))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Image.asset(icUserLocationIcon,
                                height: 20,
                                width: 20,)),
                            Expanded(child: Text(
                             // ' ${model.data!.matches! ?? "not added yet"}',
                              "New York Usa",
                              style: styleSatoshiMedium(
                                size: 14,
                                color: Colors.black.withOpacity(0.70),
                              ),))
                          ],
                        ),
                      ),
                    ],
                  ),
                  sizedBox10(),
                  SizedBox(height: 14,),
                  // Text("Interests",
                  //   style: styleSatoshiBold(size: 16, color: color1C1C1c),),
                  sizedBox10(),
                  // Wrap(
                  //   spacing: 8.0, // Adjust spacing as needed
                  //   runSpacing: 8.0, // Adjust run spacing as needed
                  //   children: interest!.map((e) => chipBox(name: e)).toList(),
                  // ),




                ],
              ),
              SizedBox(height:30),


            ],
          ),
        ),
      ),

    );
  }

  Container chipBox({required String name}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(
              width: 0.5,
              color: color4B164C.withOpacity(0.20)
          ),
          color: Colors.transparent),
      padding: EdgeInsets.all(10),
      child: Text(
        name,
        style: styleSatoshiMedium(size: 16, color: color4B164C),

      ),
    );
  }

  Padding buildProfileRow({
    required String image,
    required String title,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0,bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SvgPicture.asset(
              image,
              height: 48,
              width: 48,
            ),
          ),
          const SizedBox(width: 20,),
          Expanded(
            flex: 5,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: styleSatoshiMedium(size: 14, color: color6C7378),),
                SizedBox(
                  width: 280,
                  child: Text(text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleSatoshiBold(size: 14, color: Colors.black),),
                ),

              ],
            ),
          )

        ],),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: SvgPicture.asset(icArrowBack,
            height: 24,
            width: 24,),
        ),
      ),
      title: Row(
        children: [
          Center(
            child: Text('${model.data?.matches?.profileId ?? ''}',
              style: styleSatoshiBold(size: 16, color: Colors.black),
            ),
          ),
        ],
      ),
/*      actions: [
        Popupmen(menuList: [
          PopupMenuItem(
            child: ListTile(
              title: InkWell(
                onTap: () {
                },
                child: const Text(
                  'Account',
                ),
              ),
            ),
          ),

          PopupMenuItem(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => SignInScreen()));

              },
              child: const ListTile(
                title: Text(
                  'Log out',
                ),
              ),
            ),
          ),
        ], icon: SvgPicture.asset(ic3dots,
          height: 48,
          width: 48,))
        *//* GestureDetector(
          onTap: () {

          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SvgPicture.asset(ic3dots,
              height: 48,
              width: 48,),
          ),
        ),*//*

      ],*/
      automaticallyImplyLeading: false,

    );
  }
}


