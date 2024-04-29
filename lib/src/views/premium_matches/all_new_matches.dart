// import 'package:bureau_couple/src/constants/sizedboxe.dart';
// import 'package:bureau_couple/src/constants/textstyles.dart';
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
// import 'package:bureau_couple/src/utils/widgets/loader.dart';
// import 'package:bureau_couple/src/views/home/matches/filter_matches_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../apis/members_api.dart';
// import '../../../apis/members_api/request_apis.dart';
// import '../../../constants/assets.dart';
// import '../../../constants/colors.dart';
// import '../../../constants/textfield.dart';
// import '../../../models/matches_model.dart';
// import '../../../utils/widgets/buttons.dart';
// import '../../../utils/widgets/common_widgets.dart';
// import '../../user_profile/user_profile.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import '../dashboard_widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class MatchesScreen extends StatefulWidget {
//   const MatchesScreen({super.key});
//
//   @override
//   State<MatchesScreen> createState() => _MatchesScreenState();
// }
//
// class _MatchesScreenState extends State<MatchesScreen> {
//
//
//   List<String> images = [
//     "assets/images/ic_matches_profile.png",
//     "assets/images/ic_matches_profile.png",
//     "assets/images/ic_matches_profile.png",
//     "assets/images/ic_matches_profile.png",
//     "assets/images/ic_matches_profile.png",
//     "assets/images/ic_matches_profile.png",
//     "assets/images/ic_matches_profile.png",
//     "assets/images/ic_matches_profile.png",
//     "assets/images/ic_matches_profile.png",
//     "assets/images/ic_matches_profile.png",
//   ];
//   final searchController = TextEditingController();
//
//   List<String> name  = [
//     "Leslie Alexander",
//     "Emily Sullivan",
//     "Lily Turner",
//     "Grace Harrison",
//     "Sophia Bennett",
//     "Aria Mitchell",
//     "Ava Thompson",
//     "Ella Hayes",
//     "Mia Turner",
//     "Ruby Morgan",
//   ];
//   List<String> filteredNames = [];
//   @override
//   void initState() {
//     super.initState();
//     getMatches();
//
//   }
//
//   bool loading = false;
//   int scroll = 0;
//   int scrollLength = 0;
//   bool isSearch = false;
//   List<MatchesModel> matches = [];
//   bool isLoading = false;
//   getMatches() {
//     print("sd");
//     isLoading = true;
//     var resp = getMatchesApi(page: '1');
//     resp.then((value) {
//       matches.clear();
//       if(mounted) {
//         if(value['status'] == true) {
//           setState(() {
//             for (var v in value['data']['members']['data']) {
//               matches.add(MatchesModel.fromJson(v));
//               print(matches.length);
//             }
//             scrollLength = value['data']['members']['data'].length;
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             isLoading = false;
//           });
//         }
//       }
//     });
//   }
//   loadMore() {
//     print("dndnfdfdfd");
//     isLoading = true; // Set isLoading to true before making the API call
//     var resp = getMatchesApi(page: scroll.toString());
//     resp.then((value) {
//       if (mounted) {
//         if (value['status'] == true) {
//           setState(() {
//             // Append the newly fetched matches to the existing list
//             for (var v in value['data']['members']['data']) {
//               matches.add(MatchesModel.fromJson(v));
//             }
//             // Update scrollLength
//             scrollLength = value['data']['members']['data'].length;
//             isLoading = false; // Set isLoading to false after fetching data
//           });
//         } else {
//           setState(() {
//             isLoading = false; // Set isLoading to false if there's an error
//           });
//         }
//       }
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         automaticallyImplyLeading: false,
//         title: Text("Matches",
//           style: styleSatoshiBold(size: 22, color: Colors.black),),
//         actions: [
//           backButton(context: context,
//               image: icSearch,
//               onTap: (){
//             setState(() {
//               isSearch = !isSearch;
//             });
//               }),
//           const SizedBox(width: 10,),
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: backButton(context: context, image: icFilter, onTap: () {
//               Navigator.push(context, MaterialPageRoute(
//                   builder: (builder) => const FilterMatchesScreen()));
//             }),
//           ),
//         ],
//       ),
//       body: isLoading ? Loading():
//       CustomRefreshIndicator(
//         onRefresh: () {
//           setState(() {
//             isLoading = true;
//           });
//           return getMatches();
//         },
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,
//             bottom: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // isSearch ?
//                 // textBoxPreIcon(
//                 //     context: context,
//                 //     label: 'Search',
//                 //     img: icSearch,
//                 //     controller: searchController,
//                 //     hint: 'Search',
//                 //     length: 40,
//                 //     validator: null,
//                 //     onChanged: null) :
//                 //     SizedBox.shrink(),
//                 // sizedBox14(),
//                 // Text(
//                 // "${matches.length.toString()} members looking for you",
//                 // style: styleSatoshiMedium(size: 14, color: Colors.black.withOpacity(0.50)),),
//                 // sizedBox13(),
//                 LazyLoadScrollView(
//                   isLoading: isLoading,
//                   scrollDirection: Axis.vertical,
//                   onEndOfPage: () {
//                     if (scrollLength >= 10) {
//                       loadMore();
//                     }
//                   },
//                   child: ListView.separated(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                       itemCount: matches.length + 1,
//                       itemBuilder: (_,i) {
//                         if (i < matches.length) {
//                           return otherUserdataHolder(
//                               context: context,
//                               tap: () {
//                                 Navigator.push(
//                                     context, MaterialPageRoute(
//                                     builder: (builder) =>  UserProfileScreen(userId: matches[i].id.toString(),))
//                                 );
//                               },
//                               imgUrl:   matches[i].image == null ?
//                               "" :
//                               '${matches[i].image.toString()}',
//                               userName:  matches[i].firstname == null && matches[i].lastname == null?
//                               "" :
//                               '${matches[i].firstname} ${matches[i].lastname}',
//                               atributeReligion: "5 ft 4 in  •  Khatri Hindu",
//                               profession: "Software Engineer",
//                               Location:  "",
//                               // Location:  matches[i].address!.country == null ?
//                               // "" :
//                               // '${matches[i].address!.country}',
//                               likedColor: Colors.grey,
//                               unlikeColor: primaryColor,
//                               button: button(
//                                   fontSize: 14,
//                                   height: 30,
//                                   width: 134,
//                                   context: context,
//                                   onTap: () {
//                                     print(matches[i].id.toString());
//                                     sendRequestApi(memberId: matches[i].id.toString()
//                                       // id: career[0].id.toString(),
//                                         )
//                                         .then((value) {
//                                       if (value['status'] == true) {
//                                         setState(() {
//                                           loading = false;
//                                         });
//
//                                         // isLoading ? Loading() :careerInfo();
//                                         // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
//                                         // const KycWaitScreen()));
//
//                                         // ToastUtil.showToast("Login Successful");
//
//                                         ToastUtil.showToast("Connect Request Sent");
//                                         print('done');
//                                       } else {
//                                         setState(() {
//                                           loading = false;
//                                         });
//
//                                         List<dynamic> errors =
//                                         value['message']['error'];
//                                         String errorMessage = errors.isNotEmpty
//                                             ? errors[0]
//                                             : "An unknown error occurred.";
//                                         Fluttertoast.showToast(msg: errorMessage);
//                                       }
//                                     });
//                                   },
//                                   title: "Connect Now"),);
//                         }
//                      else if (scrollLength >= 10 && isLoading) {
//                      return Center(child: CircularProgressIndicator());
//                      } else if (scrollLength < 10) {
//                      return SizedBox.shrink();
//                      } else {
//                      return Center(child: CircularProgressIndicator());}
//                      /*  if (i < matches.length) {
//                         return
//                            otherUserdataHolder(
//                           context: context,
//                           tap: () {
//                             Navigator.push(
//                                         context, MaterialPageRoute(
//                                         builder: (builder) => const UserProfileScreen())
//                                     );
//                           },
//                           imgUrl:   matches[i].image == null ?
//                               "" :
//                           '${matches[i].image.toString()}',
//                           userName:  matches[i].firstname == null && matches[i].lastname == null?
//                           "" :
//                           '${matches[i].firstname} ${matches[i].lastname}',
//                           atributeReligion: "5 ft 4 in  •  Khatri Hindu",
//                           profession: "Software Engineer",
//                           Location:  "",
//                           // Location:  matches[i].address!.country == null ?
//                           // "" :
//                           // '${matches[i].address!.country}',
//                           buttonTap: () {},
//                           likedColor: Colors.grey,
//                           unlikeColor: primaryColor)
//                         ;
//                       }
//                        else if (scrollLength >= 10 &&
//                           isLoading) {
//                          print("1");
//                         return Center(
//                           child: LoadingAnimationWidget
//                               .staggeredDotsWave(
//                             size: 70,
//                             color: primaryColor,
//                           ),
//                         );
//                       } else if (scrollLength < 25) {
//                          print("2");
//                         return SizedBox.shrink();
//                       } else {
//                          print("3");
//                         return Center(
//                           child: LoadingAnimationWidget
//                               .staggeredDotsWave(
//                             size: 70,
//                             color: primaryColor,
//                           ),
//                         );
//                       }*/
//                       }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 30,),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//
//     );
//   }
// }

import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../apis/members_api.dart';
import '../../apis/members_api/request_apis.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/string.dart';
import '../../constants/textstyles.dart';
import '../../models/matches_model.dart';
import '../../utils/widgets/buttons.dart';
import '../../utils/widgets/common_widgets.dart';
import '../../utils/widgets/loader.dart';
import '../home/dashboard_widgets.dart';
import '../user_profile/user_profile.dart';
import 'package:intl/intl.dart';

class AllNewMatchesScreen extends StatefulWidget {
  final LoginResponse response;
  const AllNewMatchesScreen({Key? key, required this.response}) : super(key: key);

  @override
  State<AllNewMatchesScreen> createState() => _AllNewMatchesScreenState();
}

class _AllNewMatchesScreenState extends State<AllNewMatchesScreen> {
  final TextEditingController searchController = TextEditingController();

  List<MatchesModel> matches = [];
  List<bool> isLoadingList = [];
  bool isLoading = false;
  int page = 1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getMatches();
  }

  getMatches() {
    isLoading = true;
    getMatchesApi(
        page: page.toString(),
      gender:  widget.response.data!.user!.gender!.contains("M") ? "F" :"M",
    ).then((value) {
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
    isLoading = true;
    getMatchesApi(
      page: page.toString(),
      gender:  widget.response.data!.user!.gender!.contains("M") ? "F" :"M",
    ).then((value) {
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
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: Padding(
        padding: const EdgeInsets.only(left: 16),
    child: backButton(
    context: context,
    image: icArrowLeft,
    onTap: () {
    Navigator.pop(context);
    }),),
        title: Text(
          "All New Matches",
          style: styleSatoshiBold(size:18, color: Colors.black),
        ),
      ),
      body: isLoading
          ? const ShimmerWidget()
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
        child: LazyLoadScrollView(
          isLoading: isLoading,
          onEndOfPage: () {
            loadMore();
          },
          child: ListView.separated(
            itemCount: matches.length + 1,
            itemBuilder: (context, i) {
              if (i < matches.length) {
                DateTime? birthDate = matches[i].basicInfo != null ? DateFormat('yyyy-MM-dd').parse(matches[i].basicInfo!.birthDate!) : null;
                int age = birthDate != null ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                return otherUserdataHolder(
                  context: context,
                  tap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => UserProfileScreen(
                          userId: matches[i].id.toString(),
                        ),
                      ),
                    );
                  },
                  imgUrl: '$baseProfilePhotoUrl${matches[i].image ?? ''}',
                  state:matches[i].basicInfo?.presentAddress?.state ?? '',
                  userName: matches[i].firstname == null && matches[i].lastname == null
                      ? "user"
                      : '${StringUtils.capitalize(matches[i].firstname ?? '')} ${StringUtils.capitalize(matches[i].lastname ?? '')}',
                  atributeReligion: "Religion: ${matches[i].basicInfo?.religion}",
                  profession: "",
                  Location: "${matches[i].address!.state ?? ""} ${matches[i].address!.country ?? ""}",
                  dob: '$age yrs',
                  likedColor: Colors.grey,
                  unlikeColor: primaryColor,
                  button: matches[i].bookmark == 1 ?
                  button(
                      fontSize: 14,
                      height: 30,
                      width: 134,
                      context: context, onTap: (){}, title: "Request Sent"):
                  isLoadingList[i]
                      ? loadingButton(height: 30, width: 134, context: context)
                      : button(
                      fontSize: 14,
                      height: 30,
                      width: 134,
                      context: context,
                      onTap: () {
                        setState(() {
                          isLoadingList[i] = true;
                        });
                        sendRequestApi(memberId: matches[i].id.toString()).then((value) {
                          if (value['status'] == true) {
                            setState(() {
                              isLoadingList[i] = false;
                            });
                            ToastUtil.showToast("Connection Request Sent");
                          } else {
                            setState(() {
                              isLoadingList[i] = false;
                            });

                            List<dynamic> errors = value['message']['error'];
                            String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                            Fluttertoast.showToast(msg: errorMessage);
                          }
                        });
                      },
                      title: "Connect Now"),
                  height:"${matches[i].physicalAttributes!.height ?? ''} ft", bookmark: Icon(Icons.help),
                );
              } else {
                if (isLoading) {
                  return customLoader(size: 40);
                } else {
                  return Center(child: Text("All matches loaded"));
                }
              }
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 16,
            ),
          ),
        ),
      ),
    );
  }
}
