import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../apis/members_api.dart';
import '../../apis/members_api/request_apis.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/textfield.dart';

import '../../models/matches_model.dart';
import '../../utils/widgets/common_widgets.dart';
import '../../utils/widgets/loader.dart';
import '../home/dashboard_widgets.dart';
import '../user_profile/user_profile.dart';

class AllNewMatchesScreen extends StatefulWidget {
  const AllNewMatchesScreen({super.key});

  @override
  State<AllNewMatchesScreen> createState() => _AllNewMatchesScreenState();
}

class _AllNewMatchesScreenState extends State<AllNewMatchesScreen> {


  List<String> images = [
    "assets/images/ic_new_matches.png",
    "assets/images/ic_new_matches.png",
    "assets/images/ic_new_matches.png",
    "assets/images/ic_new_matches.png",
    "assets/images/ic_new_matches.png",
    "assets/images/ic_new_matches.png",
    "assets/images/ic_new_matches.png",
    "assets/images/ic_new_matches.png",
    "assets/images/ic_new_matches.png",
    "assets/images/ic_new_matches.png",
  ];
  final searchController = TextEditingController();

  List<String> name  = [
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
    filteredNames.addAll(name);
    getMatches();
  }

  bool isSearch = false;



  List<bool> isLoadingList = [];
  bool isLoading = false;
  int page = 1;
  // bool loading = false;
  List<MatchesModel> matches = [];

  getMatches() {
    isLoading = true;
    getMatchesApi(page: page.toString()).then((value) {
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

  loadMore() {
    print('ndnd');
    if (!isLoading) {
      isLoading = true;
      getMatchesApi(page: page.toString()).then((value) {
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
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: backButton(context: context, image: icArrowLeft, onTap: () {
            Navigator.pop(context);
          }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: backButton(context: context,
                image: icSearch,
                onTap: (){
                  setState(() {
                    isSearch = !isSearch;
                  });
                }),
          ),
          SizedBox(width: 10,),
          // Padding(
          //   padding: const EdgeInsets.only(right: 16.0),
          //   child: backButton(context: context, image: icFilter, onTap: () {
          //     Navigator.push(context, MaterialPageRoute(
          //         builder: (builder) => const FilterMatchesScreen()));
          //   }),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Loading()
            : Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16,top: 10,
              bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("All New Matches",
                style: styleSatoshiBold(size: 22, color: Colors.black),),
              isSearch ?
              textBoxPreIcon(
                  context: context,
                  label: 'Search',
                  img: icSearch,
                  controller: searchController,
                  hint: 'Search',
                  length: 40,
                  validator: null,
                  onChanged: search) :
              SizedBox.shrink(),
              // sizedBox14(),
           /*   Text("10 new matches found",
                style: styleSatoshiMedium(size: 14, color: Colors.black.withOpacity(0.50)),),*/
              sizedBox13(),
          SizedBox(
                height: 1.sh,
                child: LazyLoadScrollView(
                  isLoading: isLoading,
                  onEndOfPage: () {
                    loadMore();
                  },
                  child: ListView.separated(
                    itemCount: matches.length,
                    itemBuilder: (context, i) {
                      if (i < matches.length) {
                        return otherUserdataHolder(
                          context: context,
                          tap: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (builder) =>  UserProfileScreen(userId: matches[i].id.toString(),))
                            );
                          },
                          imgUrl:   matches[i].image == null ?
                          "" :
                          '${matches[i].image.toString()}',
                          userName:  matches[i].firstname == null && matches[i].lastname == null?
                          "" :
                          '${matches[i].firstname} ${matches[i].lastname}',
                          atributeReligion: "5 ft 4 in  •  Khatri Hindu",
                          profession: "Software Engineer",
                          Location:  "",
                          likedColor: Colors.grey,
                          unlikeColor: primaryColor,
                          button:
                          isLoadingList[i] ? loadingButton(
                              height: 30,
                              width: 134,
                              context: context) :button(
                              fontSize: 14,
                              height: 30,
                              width: 134,
                              context: context,
                              onTap: () {
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
                              title: "Connect Now"),
                        );
                      } else if (page >= 8 &&
                          isLoading) {
                        print("1");
                        return const Center(
                            child: CircularProgressIndicator()
                        );
                      } else if (page < 8) {
                        print("2");
                        return const SizedBox.shrink();
                      } else {
                        print("3");
                        return const Center(
                            child: CircularProgressIndicator()
                        );}
                    }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16,),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }

  void search(String text) {
    filteredNames.clear();
    if(text.isEmpty) {
      filteredNames.addAll(name);
    } else {
      filteredNames.addAll(name.where((name) => name.toLowerCase().contains(text.toLowerCase())));
    }
    setState(() {

    });
  }

/*  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Text("Matches",
        style: styleSatoshiBold(size: 22, color: Colors.black),),
      actions: [
        backButton(context: context,
            image: icSearch,
            onTap: (){}),
        SizedBox(width: 10,),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: backButton(context: context, image: icFilter, onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (builder) => FilterMatchesScreen()));
          }),
        ),
      ],
    );
  }*/
}
