import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../apis/members_api/request_apis.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/shared_prefs.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/connectionRequestModel.dart';
import '../../../utils/urls.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {

  @override
  void initState() {
    educationInfo();
    requestInfo();
    // getRequestApi();
    super.initState();
  }


  List<ConnectionRequestModel> request = [];
  List<ConnectionRequestModel> connections = [];
  bool isLoading = false;
  bool loading = false;
  List<String> selectedItems = [];
  educationInfo() {
    isLoading = true;

    var resp = getRequestApi();
    resp.then((value) {
      request.clear();
      if (value['status'] == true) {
        setState(() {
          for (var v in value['data']['data']) {
            if (v['status'] == 1) { // Check if status is 0 before adding to list
              connections.add(ConnectionRequestModel.fromJson(v));
            }
          }
          for (var v in value['data']['data']) {
            if (v['status'] == 2) { // Check if status is 0 before adding to list
              request.add(ConnectionRequestModel.fromJson(v));
              isLoadingList.add(false); //
              rejectList.add(false); //
              print(request.length);
            }
          }
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  List<bool> isLoadingList = [];
  List<bool> rejectList = [];
  List<ConnectionRequestModel> model = [];
  requestInfo() {
    isLoading = true;


    var resp = getRequestApi();
    resp.then((value) {
      request.clear();
      if (value['status'] == true) {
        setState(() {
          for (var v in value['data']['data']) {
              if (v['status'] == 2) { // Check if status is 0 before adding to list
                request.add(ConnectionRequestModel.fromJson(v));
                isLoadingList.add(false); //
                rejectList.add(false); //
                print(request.length);
              }
            }
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Notification",isBackButtonExist: true,),
    //   appBar:  AppBar(
    // leading: Padding(
    // padding: const EdgeInsets.only(left: 16),
    // child: backButton(
    // context: context,
    // image: icArrowLeft,
    // onTap: () {
    // Navigator.pop(context);
    // }),),
    // centerTitle: false,
    // automaticallyImplyLeading: false,
    // title: Text("Notification",
    // style: styleSatoshiBold(size: 22, color: Colors.black),),
    // ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 16),
      //     child: backButton(
      //         context: context,
      //         image: icArrowLeft,
      //         onTap: () {
      //           Navigator.pop(context);
      //         }),
      //   ),
      //   title: Text(" Request",
      //     style: styleSatoshiBold(size: 22, color: Colors.black),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           /*   Text("Connections",
                style: styleSatoshiBold(size: 16, color: color1C1C1c),
              ),
              sizedBox16(),
              Column(
                children: [
                  request.isEmpty || request == null ?
                  Center(
                    child: Column(
                      children: [
                        sizedBox16(),
                        Image.asset(icWaitPlaceHolder,
                          height: 80,),
                        sizedBox16(),
                        Text("No Connections Yet",

                          style: styleSatoshiLight(size: 18, color: Colors.black),)
                      ],
                    ),
                  ) :
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: request.length,
                    shrinkWrap: true,
                    itemBuilder: (_,i) {
                      String timestampString = request[i].createdAt.toString();
                      DateTime timestamp = DateTime.parse(timestampString);
                      String formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onLongPress: () {
                          // if (selectedItems.isEmpty) {
                          //   setState(() {
                          //     selectedItems.add(name[i]);
                          //   });
                          // }
                        },
                        onTap: () {
                          // if (selectedItems.isEmpty) {
                          //
                          //   // Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) =>
                          //   //             selectedItems()));
                          // } else {
                          //   if (selectedItems.contains(name[i])) {
                          //     setState(() {
                          //       selectedItems.remove(name[i]);
                          //     });
                          //   } else {
                          //     setState(() {
                          //       selectedItems.add(name[i]);
                          //     });
                          //   }
                          // }
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 0.5,
                                      color:
                                      // selectedItems.contains(name[i])
                                      //     ? Colors.red
                                      //     :
                                      Colors.grey
                                  )
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          clipBehavior: Clip.hardEdge,
                                          decoration : const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:'$baseProfilePhotoUrl${request[i].user!.image}',
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) =>
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Image.asset(icLogo,
                                                    height: 40,
                                                    width: 40,),
                                                ),
                                            progressIndicatorBuilder: (a, b, c) =>
                                                customShimmer(height: 0, *//*width: 0,*//*),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex:3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              StringUtils.capitalize( "${request[i].user!.firstname} ${request[i].user!.lastname} "),
                                              // "${request[i].user!.firstname} ${request[i].user!.lastname}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              // request[i].
                                              // "Jessica s",
                                              style: styleSatoshiBlack(size: 14, color: Colors.black),),
                                            Text(
                                              StringUtils.capitalize( "Profession: ${request[i].user!.basicInfo!.profession.toString()}",),

                                              // request[i].user!.username.toString(),
                                              style: styleSatoshiMedium(size: 12, color: color828282),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),)

                ],
              ),
              // buildDataRowBold(title: 'Connections', text: 'Change', onTap: () {
              //   // Navigator.push(context, MaterialPageRoute(builder: (builder) => const AllConnectionsScreen()));
              // }),
              sizedBox16(),*/
              // buildDataRowBold(title: 'Connection Requests', text: 'Change', onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (builder) => const ConnectionRequestScreen()));
              // }),
              Text("Connection Request",
                style: styleSatoshiBold(size: 16, color: color1C1C1c),
              ),
              sizedBox16(),
              Column(
                children: [
                  request.isEmpty || request == null ?
                  Center(
                    child: Column(
                      children: [
                        // sizedBox16(),

                        sizedBox16(),
                        Text("No Notifications",

                          style: styleSatoshiLight(size: 18, color: Colors.black),)
                      ],
                    ),
                  ) :

                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: request.length,
                    shrinkWrap: true,
                    itemBuilder: (_,i) {
                      String timestampString = request[i].createdAt.toString();
                      DateTime timestamp = DateTime.parse(timestampString);
                      String formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onLongPress: () {
                          // if (selectedItems.isEmpty) {
                          //   setState(() {
                          //     selectedItems.add(name[i]);
                          //   });
                          // }
                        },
                        onTap: () {
                          // if (selectedItems.isEmpty) {
                          //
                          //   // Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) =>
                          //   //             selectedItems()));
                          // } else {
                          //   if (selectedItems.contains(name[i])) {
                          //     setState(() {
                          //       selectedItems.remove(name[i]);
                          //     });
                          //   } else {
                          //     setState(() {
                          //       selectedItems.add(name[i]);
                          //     });
                          //   }
                          // }
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 0.5,
                                      color:
                                      // selectedItems.contains(name[i])
                                      //     ? Colors.red
                                      //     :
                                      Colors.grey
                                  )
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          clipBehavior: Clip.hardEdge,
                                          decoration : const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:'$baseProfilePhotoUrl${request[i].user!.image}',
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
                                      Expanded(
                                        flex:3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                        StringUtils.capitalize( "${request[i].user!.firstname} ${request[i].user!.lastname} want to connect"),
                                              // "${request[i].user!.firstname} ${request[i].user!.lastname}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              // request[i].
                                              // "Jessica s",
                                              style: styleSatoshiBlack(size: 14, color: Colors.black),
                                            ),
                                            Text("Profession: ${request[i].user!.basicInfo!.profession.toString()}",
                                              style: styleSatoshiMedium(size: 12, color: color828282),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  sizedBox16(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      rejectList[i] ?
                                  Center(
                                  child: LoadingAnimationWidget.threeArchedCircle(
                                    color: primaryColor,
                                    size: 28,
                                  )) :
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap : () {
                                          setState(() {
                                            rejectList[i] = true;
                                          });
                                          rejectRequestApi(id:
                                          request[i].id.toString()
                                            // id: career[0].id.toString(),
                                          )
                                              .then((value) {
                                            if (value['status'] == true) {
                                              setState(() {
                                                rejectList[i] = false;
                                              });

                                              // isLoading ? Loading() :careerInfo();
                                              // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                                              // const KycWaitScreen()));

                                              // ToastUtil.showToast("Login Successful");

                                              ToastUtil.showToast("Request Rejected");
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
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          padding: const  EdgeInsets.all(4),
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: primaryColor
                                            ),
                                          ),
                                          child: Image.asset(icX,
                                            fit: BoxFit.cover,
                                            color: primaryColor,),),),

                                      // button(
                                      //     color: Colors.red,
                                      //     fontSize: 10,
                                      //     height: 30,
                                      //     width:90,
                                      //     context: context,
                                      //     onTap: () {
                                      //       setState(() {
                                      //         rejectList[i] = true;
                                      //       });
                                      //       rejectRequestApi(id:
                                      //       request[i].id.toString()
                                      //         // id: career[0].id.toString(),
                                      //       )
                                      //           .then((value) {
                                      //         if (value['status'] == true) {
                                      //           setState(() {
                                      //             rejectList[i] = false;
                                      //           });
                                      //
                                      //           // isLoading ? Loading() :careerInfo();
                                      //           // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                                      //           // const KycWaitScreen()));
                                      //
                                      //           // ToastUtil.showToast("Login Successful");
                                      //
                                      //           ToastUtil.showToast("Request Rejected");
                                      //           print('done');
                                      //         } else {
                                      //           setState(() {
                                      //             loading = false;
                                      //           });
                                      //
                                      //           List<dynamic> errors =
                                      //           value['message']['error'];
                                      //           String errorMessage = errors.isNotEmpty
                                      //               ? errors[0]
                                      //               : "An unknown error occurred.";
                                      //           Fluttertoast.showToast(msg: errorMessage);
                                      //         }
                                      //       });
                                      //     },
                                      //     title: "Reject"),
                                      SizedBox(width: 12,),
                                      isLoadingList[i] ?
                                      Center(
                                          child: LoadingAnimationWidget.threeArchedCircle(
                                            color: primaryColor,
                                            size: 28,
                                          )) :
                                          GestureDetector(
                                           behavior: HitTestBehavior.translucent,
                                            onTap : () {
                                                    setState(() {
                                                      isLoadingList[i] = true;
                                                    });
                                                    acceptRequestApi(id:
                                                    request[i].id.toString()
                                                      // id: career[0].id.toString(),
                                                    )
                                                        .then((value) {
                                                      if (value['status'] == true) {
                                                        setState(() {
                                                          isLoadingList[i] = false;
                                                        });


                                                        isLoading? Loading() : educationInfo();

                                                        // isLoading ? Loading() :careerInfo();
                                                        // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                                                        // const KycWaitScreen()));

                                                        // ToastUtil.showToast("Login Successful");

                                                        ToastUtil.showToast("Request Accepted");
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
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              padding: const  EdgeInsets.all(4),
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: primaryColor
                                                ),
                                              ),
                                              child: Image.asset(icTick, fit: BoxFit.cover,
                                              color: primaryColor,),
                                            ),
                                          )
                                      // button(
                                      //     fontSize: 10,
                                      //     height: 30,
                                      //     width: 100,
                                      //     context: context,
                                      //     onTap: () {
                                      //       setState(() {
                                      //         isLoadingList[i] = true;
                                      //       });
                                      //       acceptRequestApi(id:
                                      //       request[i].id.toString()
                                      //         // id: career[0].id.toString(),
                                      //       )
                                      //           .then((value) {
                                      //         if (value['status'] == true) {
                                      //           setState(() {
                                      //             isLoadingList[i] = false;
                                      //           });
                                      //
                                      //
                                      //           isLoading? Loading() : educationInfo();
                                      //
                                      //           // isLoading ? Loading() :careerInfo();
                                      //           // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                                      //           // const KycWaitScreen()));
                                      //
                                      //           // ToastUtil.showToast("Login Successful");
                                      //
                                      //           ToastUtil.showToast("Request Accepted");
                                      //           print('done');
                                      //         } else {
                                      //           setState(() {
                                      //             loading = false;
                                      //           });
                                      //
                                      //           List<dynamic> errors =
                                      //           value['message']['error'];
                                      //           String errorMessage = errors.isNotEmpty
                                      //               ? errors[0]
                                      //               : "An unknown error occurred.";
                                      //           Fluttertoast.showToast(msg: errorMessage);
                                      //         }
                                      //       });
                                      //     },
                                      //     title: "Accept"),
                                      /*   isLoadingList[i] ? elevatedSmallLoadingButton(
                                        paddingVerticle: 6,
                                        paddinghorizontal: 16,
                                        context: context):
                                    elevatedSmallButton(
                                        paddingVerticle: 6,
                                        paddinghorizontal: 16,
                                        color: primaryColor,
                                        context: context, onTap: () {
                                          setState(() {
                                            isLoadingList[i] = true;
                                          });
                                      acceptRequestApi(id:
                                      request[i].id.toString()
                                        // id: career[0].id.toString(),
                                      )
                                          .then((value) {
                                        if (value['status'] == true) {
                                          setState(() {
                                            isLoadingList[i] = false;
                                          });

                                          // isLoading ? Loading() :careerInfo();
                                          // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                                          // const KycWaitScreen()));

                                          // ToastUtil.showToast("Login Successful");

                                          ToastUtil.showToast("Request Accepted");
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
                                        title: "Accept",
                                        style: styleSatoshiLight(size: 12, color: Colors.white)),*/
                                    ],
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),)

                ],
              ),


            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (builder) => const EditBasicInfoScreen()));
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
      /*  GestureDetector(
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
            )),*/

      ],
      automaticallyImplyLeading: false,

    );
  }
}
