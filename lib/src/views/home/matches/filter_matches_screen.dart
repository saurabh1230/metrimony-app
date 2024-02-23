import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../apis/members_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/textfield.dart';
import '../../../models/matches_model.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/dropdown_buttons.dart';
import '../../../utils/widgets/loader.dart';
import '../../signup/signup_dashboard.dart';
import '../../user_profile/user_profile.dart';
import '../home_dashboard.dart';
class FilterMatchesScreen extends StatefulWidget {
  const FilterMatchesScreen({super.key});

  @override
  State<FilterMatchesScreen> createState() => _FilterMatchesScreenState();
}

class _FilterMatchesScreenState extends State<FilterMatchesScreen> {

  @override
  void initState() {
    super.initState();
    getMatches();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return TopBottomSheet();
        },
      );
    });
  }


  List<MatchesModel> matches = [];
  // MatchesData matches = MatchesModel();
  bool isLoading = false;
  getMatches() {
    isLoading = true;
    var resp = getMatchesApi(page: '1');
    resp.then((value) {
      matches.clear();
      if(mounted) {
        if(value['status'] == true) {
          setState(() {
            for (var v in value['data']['members']['data']) {
              // matches = MatchesModel.fromJ
              matches.add(MatchesModel.fromJson(v));
              // print("gh");
              print(matches.length);
            }
            // dashboardDetails =  DashboardModel.fromJson(value);
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
        automaticallyImplyLeading: false,
      /* leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: backButton(
          context: context,
          image: icArrowLeft,
          onTap: () {
            Navigator.pop(context);
          }),
        ),*/
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return TopBottomSheet();
                },
              );
            },
            child: Container(
                padding: const EdgeInsets.only(right: 16.0,
                    top: 6,
                    bottom: 6,
                    left: 10),
              child: Icon(Icons.filter_alt_outlined),
            ),
          )
        ],
      ),
      body: isLoading ?
      Loading() :
      RefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return getMatches();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,
                bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox14(),
                Text("${matches.length.toString()} members looking for you",
                  style: styleSatoshiMedium(size: 14, color: Colors.black.withOpacity(0.50)),),
                sizedBox13(),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: matches.length,
                  itemBuilder: (_,i) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (builder) =>  UserProfileScreen(
                              userId: matches[i].id.toString(),))
                        );
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 160,
                                clipBehavior: Clip.hardEdge,
                                decoration :BoxDecoration(
                                    color: colorDarkCyan.withOpacity(0.03),
                                    // color:Colors.red,
                                    borderRadius : BorderRadius.circular(10)
                                ),
                                child:  CachedNetworkImage(
                                  imageUrl:
                                  '${matches[i].image.toString()}',
                                  fit: BoxFit.cover,
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
                              flex:2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex:4,
                                        child: Text('${matches[i].firstname} ${matches[i].lastname}',
                                          // child: Text(filteredNames[i],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: styleSatoshiBold(size: 19, color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Image.asset(icBookMark,
                                          height: 24,
                                          width: 24,),
                                      )
                                    ],
                                  ),
                                  Text(
                                    // '${matches[i].physicalAttributes!.height} cm • ${matches[i].religion}',
                                    "5 ft 4 in  •  Khatri Hindu",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: styleSatoshiMedium(
                                        size: 13, color: Colors.black.withOpacity(0.80)),
                                  ),
                                  sizedBox16(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Image.asset(icBag,
                                          height: 17,
                                          width: 17,),
                                      ),
                                      SizedBox(width: 10,),

                                      Expanded(
                                        flex:10,
                                        child: Text("Software Engineer",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines:2,

                                          style: styleSatoshiMedium(
                                              size: 13, color: Colors.black.withOpacity(0.70)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBox8(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Image.asset(icLocation,
                                          height: 17,
                                          width: 17,),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        flex:10,
                                        child: Text(
                                          // '${matches[i].address!.country}',
                                          "New York, USA",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines:2,

                                          style: styleSatoshiMedium(
                                              size: 13, color: Colors.black.withOpacity(0.70)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBox16(),
                                  button(
                                      fontSize: 14,
                                      height: 30,
                                      width: 134,
                                      context: context,
                                      onTap: (){},
                                      title: "Connect Now"),
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 30,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class TopBottomSheet extends StatefulWidget {
  @override
  State<TopBottomSheet> createState() => _TopBottomSheetState();
}

class _TopBottomSheetState extends State<TopBottomSheet> {
  double _maxHeightInFeet = 10.0;
  double _value = 5.0;
  String? selectedValue;
  final motherTongueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   'Select your preferences',
            //   style: styleSatoshiLight(size: 16, color: Colors.black),
            // ),
            Text("Select Preferred Height",
              style: styleSatoshiLight(size: 12, color: Colors.black),),
            SfSlider(
              activeColor: primaryColor,
              min: 5.0,
              max: 8.0,
              value: _value,
              interval: 1,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              onChanged: (dynamic value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            sizedBox16(),
            Text("Select Preferred Religion",
              style: styleSatoshiLight(size: 12, color: Colors.black),),
            sizedBox16(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: SizedBox(
                width: 1.sw,
                child: CustomStyledDropdownButton(
                  items: ['Hindu', 'Muslim', 'Christain','Buddism'],
                  selectedValue: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  }, title: 'Religion',
                ),
              ),
            ),
            sizedBox16(),
            SizedBox(
              width: 1.sw,
              child: CustomStyledDropdownButton(
                items: ['Male', 'Female', 'Bisexual'],
                selectedValue: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                  });
                }, title: 'Looking for',
              ),
            ),


          ],
        ),
      ),
    );
  }
}