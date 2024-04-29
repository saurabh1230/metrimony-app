import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


import 'package:flutter_svg/flutter_svg.dart';
import '../../apis/members_api/bookmart_api.dart';
import '../../apis/members_api/request_apis.dart';
import '../../apis/other_user_api/other_user_profile_details.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/string.dart';
import '../../constants/textstyles.dart';
import '../../models/other_person_details_models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/widgets/buttons.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';

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

  getProfileDetails() {
    isLoading = true;
    var resp = getOtherUserProfileApi(otherUserId: widget.userId);
    resp.then((value) {
      // matches.clear();
      if(mounted) {
        if(value['status'] == true) {
          setState(() {
            model = OtherProfileModel.fromJson(value);
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


  DateTime? birthDate;
  int age = 0;
  bool loading = false;

  bool like = false;

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    String? birthDateString = model.data?.matches?.basicInfo?.birthDate;
    if (birthDateString != null) {
      birthDate = DateFormat('yyyy-MM-dd').parse(birthDateString);
      age = birthDate != null ? DateTime.now().difference(birthDate!).inDays ~/ 365 : 0;
    }
    return Scaffold(
      // appBar: buildAppBar(),
      body: isLoading ? const Loading() :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(32),
                   bottomLeft:Radius.circular(32) ),
                child: CarouselSlider.builder(
                  itemCount: model.data?.matches?.galleries?.length ?? 0,
                  itemBuilder: (ctx, index, realIndex) {
                    return CachedNetworkImage(
                      imageUrl: '$baseGalleryImage${model.data?.matches?.galleries?[index].image}',
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(icLogo),
                      ),
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          customShimmer(height: 0),
                    );
                  },
                  options: CarouselOptions(
                    height: 500,
                    viewportFraction: 2,
                    enlargeFactor: 0.3,
                    aspectRatio: 0.8,
                      enableInfiniteScroll : false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    model.data?.matches?.galleries?.length ?? 0,
                        (index) => Container(
                      width: 40,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: _currentIndex == index ? Colors.white : Colors.black.withOpacity(0.30),
                      ),
                    ),
                  ),
                ),
              ),
           /*   Positioned(
                top: 40,
                right:16,
                child: GestureDetector(
                  onTap: () {
                    model.data!.matches!.bookmark == 1 ?
                    matchesControl.unSaveBookmarkApi(matches[i].profileId.toString()) :

                    matchesControl.bookMarkSaveApi(matches[i].profileId.toString());
                    // setState(() {
                    //   like[i] = false;
                    // });
                  },
                  child: const Icon(
                    Icons.bookmark,
                    color: primaryColor,

                    size: 22,
                  ),
                ),
              ),*/
              Positioned(
                bottom: 26,
                left: 26,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${StringUtils.capitalize(model.data!.matches!.firstname ?? '')} ${StringUtils.capitalize(model.data!.matches!.lastname ?? 'User')}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: styleSatoshiBold(size: 30, color: Colors.white),),

                      ],
                    ),
                    Text(
                      StringUtils.capitalize(model.data?.matches?.religion ?? ''),
                      style: styleSatoshiBold(size: 16, color: Colors.white),),
                    Row(
                      children: [
                        Text(
                          StringUtils.capitalize('$age yrs'),
                          style: styleSatoshiBold(size: 16, color: Colors.white),),
                        const SizedBox(width: 10,),
                        Text(
                          StringUtils.capitalize('${model.data?.matches?.physicalAttributes?.height} ft'),
                          style: styleSatoshiBold(size: 16, color: Colors.white),),
                      ],
                    ),
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
                          sendRequestApi(memberId: model.data!.matches!.id!.toString())
                              .then((value) {
                            if (value['status'] == true) {
                              setState(() {
                                loading = false;
                              });
                              ToastUtil.showToast("Connection Request Sent");
          
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
              Padding(
                padding: const EdgeInsets.only(left: 16,
                    top: 30),
                child: backButton(
                    context: context,
                    image: icArrowLeft,
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
                ],
              ),


              sizedBox20(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.data!.matches!.basicInfo!.aboutUs!.isEmpty ?
                    const SizedBox() : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Introduction",
                          style: styleSatoshiBold(size: 16, color: color1C1C1c),),
                        sizedBox10(),
                        ReadMoreText(
                          model.data?.matches?.basicInfo?.aboutUs ?? "hi am ${model.data?.matches?.firstname ?? "User"}${model.data?.matches?.lastname ?? ""}",
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: ' Show less',
                          moreStyle: styleSatoshiLight(size: 14, color: primaryColor),
                          lessStyle: styleSatoshiLight(size: 14, color: primaryColor),
                        ),
                      ],
                    ),

                    sizedBox10(),
                    Text(
                      "Professional Info",
                      style: styleSatoshiBold(size: 16, color: color1C1C1c),),
                    sizedBox10(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                },
                                child: SvgPicture.asset(icEducation,
                                  height: 18,
                                  width: 18,),
                              ),
                              sizedBox6(),
                              Text(
                                ' ${model.data?.matches?.educationInfo?[0].degree ?? "" }',
                                textAlign: TextAlign.center,
                                style: styleSatoshiMedium(
                                  size: 14,
                                  color: Colors.black.withOpacity(0.70),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                icUserBagIcon,
                                height: 20,
                                width: 20,),
                              sizedBox6(),
                              Text(
                                StringUtils.capitalize(model.data!.matches!.basicInfo!.profession ?? ""),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: styleSatoshiMedium(
                                  size: 14,
                                  color: Colors.black.withOpacity(0.70),
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                    sizedBox12(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                icUserHeightIcon,
                                height: 20,
                                width: 20,),
                              sizedBox6(),
                              Text(
                                "${model.data?.matches?.physicalAttributes?.height} ft" ?? "not added yet",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: styleSatoshiMedium(
                                  size: 14,
                                  color: Colors.black.withOpacity(0.70),
                                ),)
                            ],
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(icUserLocationIcon,
                                height: 20,
                                width: 20,),
                              sizedBox6(),
                              Text(
                                ' ${model.data!.matches!.address!.country ?? ""}',
                                textAlign: TextAlign.center,
                                style: styleSatoshiMedium(
                                  size: 14,
                                  color: Colors.black.withOpacity(0.70),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
                                Text("User Details",
                                  style: styleSatoshiRegular(size: 14, color: Colors.white),),
                                Text("",
                                  style: styleSatoshiRegular(size: 16, color: Colors.white),)
                              ],
                            ),
                          ),

                        ),
                        sizedBox20(),
                        buildProfileRow(image: icHeightIcon, title: 'Height',
                            text:
                            "${model.data?.matches?.physicalAttributes?.height} ft" ?? ''
                        ),
                        buildProfileRow(image: icChildrenIcon, title: 'Family',
                         text: 'Father: ${StringUtils.capitalize(model.data!.matches!.family?.fatherName ?? "")}, \nMother: ${StringUtils.capitalize(model.data!.matches!.family?.motherName ?? "")},'),
                        buildProfileRow(image: icReligionIcon,
                         title: 'Religion / Community',
                          text: StringUtils.capitalize(model.data!.matches?.basicInfo?.religion  ?? "") ),
                        buildProfileRow(image: icMotherToungeIcon,
                            title: 'Mother Tongue',
                            text: StringUtils.capitalize(model.data!.matches?.basicInfo?.motherTongue  ?? "")
                            ),
                        buildProfileRow(image: icMarriedStatusPro,
                            title: 'Married Status',
                            text: StringUtils.capitalize(model.data!.matches?.basicInfo?.maritalStatus ?? "")
                            ),
                        Text("Preference",
                          style: styleSatoshiBold(size: 16, color: color1C1C1c),),
                        sizedBox6(),
                        Row(
                          children: [
                            Expanded(
                              child: customContainer(
                                  vertical: 8,
                                  child: Center(
                                    child: Text(model.data!.matches?.basicInfo?.religion ?? "",
                                      style: styleSatoshiLight(size: 12, color: Colors.white),),
                                  ),
                                  radius: 16,
                                  color:  primaryColor,
                                  click: () {}
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: customContainer(
                                  vertical: 8,
                                  child: Center(
                                    child: Text(model.data!.matches?.basicInfo?.maritalStatus  ?? "",
                                      style: styleSatoshiLight(size: 12, color: Colors.white),
                                    ),
                                  ),
                                  radius: 16,
                                  color: primaryColor,
                                  click: () {}
                              ),
                            ),
                            const SizedBox(width: 5,),


                            Expanded(
                              child: customContainer(
                                  vertical: 8,
                                  child: Center(
                                    child: Text(model.data!.matches!.address!.country.toString() ?? "",
                                      style: styleSatoshiLight(size: 12, color: Colors.white),
                                    ),
                                  ),
                                  radius: 16,
                                  color:  primaryColor,
                                  click: () {}
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: customContainer(
                                  vertical: 8,
                                  child: Center(
                                    child: Text(model.data!.matches!.basicInfo!.gender!.contains("F") ? "Female" :"Male" ?? "",
                                      style: styleSatoshiLight(size: 12, color: Colors.white),
                                    ),
                                  ),
                                  radius: 16,
                                  color:  primaryColor,
                                  click: () {}
                              ),)

                          ],
                        ),


                        sizedBox14(),
                        sizedBox10(),
                        const SizedBox(height: 14,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  Container chipBox({required String name}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(
              width: 0.5,
              color: color4B164C.withOpacity(0.20)
          ),
          color: Colors.transparent),
      padding: const EdgeInsets.all(10),
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
            child: Text('${StringUtils.capitalize(model.data?.matches?.firstname ?? '')} ${StringUtils.capitalize(model.data?.matches?.lastname ?? '')}',
              style: styleSatoshiBold(size: 16, color: Colors.black),
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,

    );
  }
}


