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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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


}
