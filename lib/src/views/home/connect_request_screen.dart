import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../apis/members_api/request_apis.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/textstyles.dart';
import '../../models/connectionRequestModel.dart';
import '../../utils/widgets/common_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectionRequestScreen extends StatefulWidget {
  const ConnectionRequestScreen({super.key});

  @override
  State<ConnectionRequestScreen> createState() => _ConnectionRequestScreenState();
}

class _ConnectionRequestScreenState extends State<ConnectionRequestScreen> {

  List<String> selectedItems = [];
  bool allImagesSelected = false;
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

  @override
  void initState() {
    educationInfo();
    super.initState();
  }
  List<bool> isLoadingList = [];
  List<bool> rejectList = [];
  List<ConnectionRequestModel> request = [];
  bool isLoading = false;
  educationInfo() {
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

  bool loading = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
      body:
      CustomRefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return educationInfo();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: isLoading ? Loading(): Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
            child: Column(
              children: [
                request.isEmpty || request == null ?
                    Center(
                      child: Column(
                        children: [
                          sizedBox16(),
                          Image.asset(icWaitPlaceHolder,
                          height: 80,),
                          sizedBox16(),
                          Text("No Request Yet",

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
                        if (selectedItems.isEmpty) {
                          setState(() {
                            selectedItems.add(name[i]);
                          });
                        }
                      },
                      onTap: () {
                        if (selectedItems.isEmpty) {

                        } else {
                          if (selectedItems.contains(name[i])) {
                            setState(() {
                              selectedItems.remove(name[i]);
                            });
                          } else {
                            setState(() {
                              selectedItems.add(name[i]);
                            });
                          }
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 0.5,
                                    color: selectedItems.contains(name[i])
                                        ? Colors.red
                                        : Colors.grey
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
                                        child: Image.asset(icDemoProfile,
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
                                            "${request[i].user!.firstname} ${request[i].user!.lastname}",
                                             maxLines: 2,
                                             overflow: TextOverflow.ellipsis,
                                             // request[i].
                                            // "Jessica s",
                                            style: styleSatoshiMedium(size: 16, color: primaryColor),),
                                          Text("Sent you Connection request",
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
                                    rejectList[i] ? loadingButton(
                                      color: Colors.red,
                                        height: 30,
                                        width: 90,
                                        context: context) :button(
                                        color: Colors.red,
                                        fontSize: 10,
                                        height: 30,
                                        width:90,
                                        context: context,
                                        onTap: () {
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
                                        title: "Reject"),
                                    SizedBox(width: 7,),
                                    isLoadingList[i] ? loadingButton(
                                        height: 30,
                                        width: 100,
                                        context: context) :button(
                                        fontSize: 10,
                                        height: 30,
                                        width: 100,
                                        context: context,
                                        onTap: () {
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


                                              isLoading? const Loading() : educationInfo();

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
                                        title: "Accept"),
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
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: backButton(
            context: context,
            image: icArrowLeft,
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      title: Text("Connection Request",
        style: styleSatoshiBold(size: 22, color: Colors.black),
      ),
      actions: [

        const SizedBox(width: 5,),
        selectedItems.isNotEmpty ?
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      if (allImagesSelected) {
                        // If all images are selected, clear the list
                        selectedItems.clear();
                      } else {
                        // If not all images are selected, add all images
                        selectedItems.addAll(name);
                      }
                      allImagesSelected = !allImagesSelected;
                    });

                  },
                  child: Image.asset(icSelectAll,height: 24,
                    width: 24,)),
              Icon(Icons.delete),
            ],
          ),
        ) :
        SizedBox(),
      ],
    );
  }
}
