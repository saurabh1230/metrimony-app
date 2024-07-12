
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/models/other_person_details_models.dart';
import 'package:bureau_couple/src/models/profie_model.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/views/home/profile/edit_preferred_matches.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis/profile_apis/career_info_api.dart';
import '../../../apis/profile_apis/education_info_api.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/career_info_model.dart';
import '../../../models/education_info_model.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/customAppbar.dart';
import '../../../utils/widgets/loader.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class EditCareerInfoScreen extends StatefulWidget {
  const EditCareerInfoScreen({super.key});

  @override
  State<EditCareerInfoScreen> createState() => _EditCareerInfoScreenState();
}

class _EditCareerInfoScreenState extends State<EditCareerInfoScreen> {
  final companyController = TextEditingController();
  final startingYearController = TextEditingController();
  final endingYearController = TextEditingController();
  final designationController = TextEditingController();
  bool loading = false;
  bool isLoading = false;

  @override
  void initState() {
    careerInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getProfessionList();

    });
    super.initState();
  }

  List<CareerInfoMdl> career = [];

  careerInfo() {
    isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
      career.clear();
      if (value['status'] == true) {
        setState(() {
          // profile = ProfileModel.fromJson(value);
          for (var v in value['data']['user']['career_info']) {
            career.add(CareerInfoMdl.fromJson(v));
          }
          fields();
          // print(career.length);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  final positionController = TextEditingController();
  final positionIdController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final fromController = TextEditingController();
  final endController = TextEditingController();
  // final positionController = TextEditingController();

  void fields() {
    positionController.text = career[0].positionHeld?.name.toString() ?? '';
    stateController.text = career[0].statePosting.toString() ?? '';
    districtController.text = career[0].districtPosting.toString() ?? '';
    fromController.text = career[0].from.toString() ?? '';
    endController.text = career[0].end.toString() ?? '';
  }


  List<String> selectedItems = [];
  String selectedItemId = '';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControl) {
      return    Scaffold(
        appBar:  CustomAppBar(title: "Career Info",
          // menuWidget: Row(children: [  selectedItemId.isNotEmpty
          //   ? GestureDetector(
          //   behavior: HitTestBehavior.translucent,
          //   onTap: () {
          //     careerInfoDeleteApi(id: selectedItemId).then((value) {
          //       setState(() {});
          //       if (value['status'] == true) {
          //         setState(() {
          //           loading = false;
          //           isLoading ? const Loading() : careerInfo();
          //         });
          //         ToastUtil.showToast("Deleted Successfully");
          //         print('done');
          //       } else {
          //         setState(() {
          //           loading = false;
          //         });
          //
          //         List<dynamic> errors = value['message']['error'];
          //         String errorMessage = errors.isNotEmpty
          //             ? errors[0]
          //             : "An unknown error occurred.";
          //         Fluttertoast.showToast(msg: errorMessage);
          //       }
          //     });
          //   },
          //   child: const Icon(Icons.delete,color: Colors.white,))
          //   : const SizedBox(),
          // GestureDetector(
          //   onTap: () {
          //     // showDialog(
          //     //   context: context,
          //     //   builder: (BuildContext context) {
          //     //     return StatefulBuilder(
          //     //         builder: (BuildContext context, StateSetter setState) {
          //     //           return EditDialogWidget(
          //     //               addTextField: Column(
          //     //                 crossAxisAlignment: CrossAxisAlignment.start,
          //     //                 children: [
          //     //                   Text("Career info",
          //     //                     style: styleSatoshiBold(size: 18, color: Colors.black),),
          //     //                   sizedBox16(),
          //     //
          //     //                   Row(
          //     //                     children: [
          //     //                       Expanded(
          //     //                         child: buildTextFormField(context,
          //     //                             hint: 'company', controller: companyController),
          //     //                       ),
          //     //                       const SizedBox(
          //     //                         width: 6,
          //     //                       ),
          //     //                       Expanded(
          //     //                         child: buildTextFormField(context,
          //     //                             hint: 'designation',
          //     //                             controller: designationController),
          //     //                       ),
          //     //                     ],
          //     //                   ),
          //     //                   sizedBox16(),
          //     //                   Row(
          //     //                     children: [
          //     //                       Expanded(
          //     //                         child: buildTextFormField(context,
          //     //                             hint: 'start',
          //     //                             controller: startingYearController),
          //     //                       ),
          //     //                       const SizedBox(
          //     //                         width: 6,
          //     //                       ),
          //     //                       Expanded(
          //     //                         child: buildTextFormField(context,
          //     //                             hint: 'end No',
          //     //                             controller: endingYearController,
          //     //                             keyboard: TextInputType.number),
          //     //                       ),
          //     //                     ],
          //     //                   ),
          //     //                   sizedBox10(),
          //     //                   sizedBox16(),
          //     //                   loading
          //     //                       ? loadingElevatedButton(
          //     //                       context: context, color: primaryColor)
          //     //                       : elevatedButton(
          //     //                       color: primaryColor,
          //     //                       context: context,
          //     //                       onTap: () {
          //     //                         setState(() {
          //     //                           loading = true;
          //     //                         });
          //     //                         careerInfoAddApi(
          //     //                           // id: career[0].id.toString(),
          //     //                             company: companyController.text,
          //     //                             designation: designationController.text,
          //     //                             startYear: startingYearController.text,
          //     //                             endYear: endingYearController.text)
          //     //                             .then((value) {
          //     //                           if (value['status'] == true) {
          //     //                             setState(() {
          //     //                               loading = false;
          //     //                             });
          //     //
          //     //
          //     //                             ToastUtil.showToast("Updated Successfully");
          //     //                             print('done');
          //     //                           } else {
          //     //                             setState(() {
          //     //                               loading = false;
          //     //                             });
          //     //
          //     //                             List<dynamic> errors =
          //     //                             value['message']['error'];
          //     //                             String errorMessage = errors.isNotEmpty
          //     //                                 ? errors[0]
          //     //                                 : "An unknown error occurred.";
          //     //                             Fluttertoast.showToast(msg: errorMessage);
          //     //                           }
          //     //                         });
          //     //                       },
          //     //                       title: "Save")
          //     //                 ],
          //     //               ));
          //     //         });
          //     //   },
          //     // );
          //   },
          //   child: const Padding(
          //     padding: EdgeInsets.only(right: 16.0),
          //     child: Icon(Icons.edit,color: Colors.white,),
          //   ),
          // )],
          // ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: button(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                },
                title: "Save"),
          ),
        ),
        body: isLoading
            ? const Loading()
            : CustomRefreshIndicator(
          onRefresh: () {
            setState(() {
              isLoading = true;
            });
            return careerInfo();
          },

          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                children: [
                  career.isEmpty || career == null ?
                  Center(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    return EditDialogWidget(
                                        addTextField: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Career Info",
                                              style: styleSatoshiBold(size: 18, color: Colors.black),),
                                            sizedBox16(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: buildTextFormField(context,
                                                      hint: 'company', controller: companyController),
                                                ),
                                                const SizedBox(width: 6,),
                                                Expanded(
                                                  child: buildTextFormField(context,
                                                      hint: 'designation',
                                                      controller: designationController),
                                                ),
                                              ],
                                            ),
                                            sizedBox16(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: buildTextFormField(context,
                                                      hint: 'start',
                                                      controller: startingYearController,
                                                      keyboard: TextInputType.number),
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Expanded(
                                                  child: buildTextFormField(context,
                                                      hint: 'end No',
                                                      controller: endingYearController,
                                                      keyboard: TextInputType.number),
                                                ),
                                              ],
                                            ),
                                            sizedBox10(),
                                            sizedBox16(),
                                            loading
                                                ? loadingElevatedButton(
                                                context: context, color: primaryColor)
                                                : elevatedButton(
                                                color: primaryColor,
                                                context: context,
                                                onTap: () {
                                                  setState(() {
                                                    loading = true;
                                                  });

                                                  careerInfoAddApi(
                                                    // id: career[0].id.toString(),
                                                      company: companyController.text,
                                                      designation: designationController.text,
                                                      startYear: startingYearController.text,
                                                      endYear: endingYearController.text)
                                                      .then((value) {
                                                    if (value['status'] == true) {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        loading = false;
                                                        careerInfo();
                                                      });
                                                      companyController.clear();
                                                      designationController.clear();
                                                      startingYearController.clear();
                                                      endingYearController.clear();
                                                      ToastUtil.showToast("Updated Successfully");
                                                    } else {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      Get.back();

                                                      List<dynamic> errors =
                                                      value['message']['error'];
                                                      String errorMessage = errors.isNotEmpty
                                                          ? errors[0]
                                                          : "An unknown error occurred.";
                                                      Fluttertoast.showToast(msg: errorMessage);
                                                    }
                                                  });
                                                },
                                                title: "Save")
                                          ],
                                        ));
                                  });
                            },
                          );


                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: DottedPlaceHolder(text: "Add Career Info"),
                        ),
                      )):
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: career.length,
                      itemBuilder: (_, i) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onLongPress: () {
                            setState(() {
                              selectedItemId = career[i]
                                  .id
                                  .toString(); // Set the ID of the selected item
                            });
                          },
                          child: Column(
                            children: [
                              buildListRow(
                                title: 'Position',
                                data1: StringUtils.capitalize(positionController.text), tap: () {
                                // Get.bottomSheet(
                                //   ProfessionBottomSheet(onPop: (val ) {
                                //     positionController.text = val;
                                //
                                //     print(val);
                                //   },
                                //     onPopId: (value) {
                                //       positionIdController.text = value;
                                //       print(positionIdController.text);
                                //
                                //     },
                                //   ),
                                //
                                //   backgroundColor: Colors.transparent,
                                //   isScrollControlled: true,
                                // );
                              },
                              ),
                              const Divider(),
                              sizedBox10(),
                              buildListRow(
                                title: 'Posting Date',
                                data1:StringUtils.capitalize('${career[i].from} - ${career[i].end}'), tap: () {
                                // Get.bottomSheet(
                                //   SingleChildScrollView(
                                //     child: Container(color: Colors.white,
                                //       child: Column(
                                //         children: [
                                //           Text("Date Of Posting", style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12,)),
                                //           const SizedBox(height: 5), //
                                //           Row(
                                //             children: [
                                //               Expanded(
                                //                 child: CustomTextField(
                                //                   showTitle: true,
                                //                   validation: (value) {
                                //                     if (value == null || value.isEmpty) {
                                //                       return 'Please Enter your Starting Date';
                                //                     }
                                //                     return null;
                                //                   },
                                //                   onTap: () { Get.find<AuthController>().showDatePicker(context); },
                                //                   onChanged: (value) {
                                //                     authControl.setPostingStartDate(authControl.from.toString());
                                //
                                //                   },
                                //                   readOnly:  true,
                                //                   hintText:"Starting date",
                                //                   controller: fromController,
                                //                 ),
                                //               ),
                                //               const SizedBox(width: 10,),
                                //               Expanded(
                                //                 child: CustomTextField(
                                //                   showTitle: true, validation: (value) {
                                //                   if (value == null || value.isEmpty) {
                                //                     return 'Please Enter your Ending Date';
                                //                   }
                                //                   return null;
                                //                 },
                                //                   onChanged: (value) {
                                //                     authControl.setPostingEndDate(endController.text);
                                //                   },
                                //                   hintText:"Ending date",
                                //                   controller: endController,
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                //   backgroundColor: Colors.transparent,
                                //   isScrollControlled: true,);

                                print(stateController.text);
                                print(districtController.text);
                              },
                              ),
                              const Divider(),
                              sizedBox10(),
                              buildListRow(
                                title: 'State Of Posting',
                                data1: stateController.text, tap: () {
                                // Get.bottomSheet(
                                //   SelectStateAndDistrict( onStatePop: (String ) {
                                //     stateController.text = String;
                                //     print('=========?${stateController.text}');
                                //     Get.find<AuthController>().update();
                                //   }, onDistrictPop: (String ) {
                                //     districtController.text = String;
                                //   },),
                                //   backgroundColor: Colors.transparent,
                                //   isScrollControlled: true,);

                              },
                              ),
                              const Divider(),
                              sizedBox10(),
                              buildListRow(
                                title: 'District Of Posting',
                                data1: career[i].districtPosting.toString(), tap: () {
                                // Get.bottomSheet(
                                //   SelectStateAndDistrict( onStatePop: (String ) {
                                //     stateController.text = String;
                                //   }, onDistrictPop: (String ) {
                                //     districtController.text = String;
                                //   },),
                                //   backgroundColor: Colors.transparent,
                                //   isScrollControlled: true,);
                              },
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    });


  }

  GestureDetector buildListRow({
    required String title,
    required String data1,
    required Function() tap,
  }) {
    return GestureDetector(
      onTap: tap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
            ),
          ),
          Expanded(
            // flex: 3,
            child: SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data1,
                    maxLines: 4,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Row buildDataAddRow({
    required String title,
    required String data1,
    required String data2,
    required bool isControllerTextEmpty,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
          ),
        ),
        isControllerTextEmpty
            ? Expanded(
                // flex: 3,
                child: SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        data1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data2,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
      ],
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
      title: Text(
        "Career Info",
        style: styleSatoshiBold(size: 18, color: Colors.black),
      ),
      actions: [
        selectedItemId.isNotEmpty
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  careerInfoDeleteApi(id: selectedItemId).then((value) {
                    setState(() {});
                    if (value['status'] == true) {
                      setState(() {
                        loading = false;
                        isLoading ? Loading() : careerInfo();
                      });

                      // isLoading ? Loading() :careerInfo();
                      // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                      // const KycWaitScreen()));

                      // ToastUtil.showToast("Login Successful");

                      ToastUtil.showToast("Deleted Successfully");
                      print('done');
                    } else {
                      setState(() {
                        loading = false;
                      });

                      List<dynamic> errors = value['message']['error'];
                      String errorMessage = errors.isNotEmpty
                          ? errors[0]
                          : "An unknown error occurred.";
                      Fluttertoast.showToast(msg: errorMessage);
                    }
                  });
                },
                child: Icon(Icons.delete))
            : SizedBox(),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return EditDialogWidget(
                      addTextField: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Career info",
                        style: styleSatoshiBold(size: 18, color: Colors.black),),
                      sizedBox16(),

                      Row(
                        children: [
                          Expanded(
                            child: buildTextFormField(context,
                                hint: 'company', controller: companyController),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: buildTextFormField(context,
                                hint: 'designation',
                                controller: designationController),
                          ),
                        ],
                      ),
                      sizedBox16(),
                      Row(
                        children: [
                          Expanded(
                            child: buildTextFormField(context,
                                hint: 'start',
                                controller: startingYearController),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: buildTextFormField(context,
                                hint: 'end No',
                                controller: endingYearController,
                                keyboard: TextInputType.number),
                          ),
                        ],
                      ),
                      sizedBox10(),
                      sizedBox16(),
                      loading
                          ? loadingElevatedButton(
                              context: context, color: primaryColor)
                          : elevatedButton(
                              color: primaryColor,
                              context: context,
                              onTap: () {
                                setState(() {
                                  loading = true;
                                });
                                careerInfoAddApi(
                                        // id: career[0].id.toString(),
                                        company: companyController.text,
                                        designation: designationController.text,
                                        startYear: startingYearController.text,
                                        endYear: endingYearController.text)
                                    .then((value) {
                                  if (value['status'] == true) {
                                    setState(() {
                                      loading = false;
                                    });


                                    ToastUtil.showToast("Updated Successfully");
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
                              title: "Save")
                    ],
                  ));
                });
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }

  TextFormField buildTextFormField(
    BuildContext context, {
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboard,
  }) {
    return TextFormField(
      keyboardType: keyboard ?? TextInputType.name,

      inputFormatters: [
        LengthLimitingTextInputFormatter(40),
      ],
      onChanged: (v) {
        setState(() {});
      },
      onEditingComplete: () {
        Navigator.pop(context); // Close the dialog
      },
      controller: controller,
      decoration: AppTFDecoration(hint: hint).decoration(),
      //keyboardType: TextInputType.phone,
    );
  }
}

// class PositionBottomSheet extends StatelessWidget {
//   const PositionBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//       Container(
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text("Position",
//               textAlign: TextAlign.left,
//               style: styleSatoshiBold(size: 16, color: Colors.black),),
//           ),
//           const SizedBox(height: 5,),
//           Wrap(
//             spacing: 8.0,
//             children: authControl.positionHeldList!.map((religion) {
//               return ChoiceChip(
//                 selectedColor: color4B164C.withOpacity(0.80),
//                 backgroundColor: Colors.white,
//                 label: Text(
//                   religion.name!,
//                   style: TextStyle(
//                     color: authControl.positionHeldIndex == religion.id
//                         ? Colors.white
//                         : Colors.black.withOpacity(0.80),
//                   ),
//                 ),
//                 selected: authControl.positionHeldIndex == religion.id,
//                 onSelected: (selected) {
//                   if (selected) {
//                     authControl.setPositionIndex(religion.id, true);
//                   }
//                 },
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }


class SelectStateAndDistrict extends StatefulWidget {
  final Function(String) onStatePop;
  final Function(String) onDistrictPop;

  SelectStateAndDistrict({super.key, required this.onStatePop, required this.onDistrictPop});

  @override
  State<SelectStateAndDistrict> createState() => _SelectStateAndDistrictState();
}

class _SelectStateAndDistrictState extends State<SelectStateAndDistrict> {
  @override
  Widget build(BuildContext context) {
    final stateController = TextEditingController();
    final districtController = TextEditingController();

    return GetBuilder<AuthController>(builder: (authControl) {
      return SingleChildScrollView(
        child: Container(
          height: Get.size.height * 0.7,
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              sizedBox20(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select State And District Of Posting",
                  textAlign: TextAlign.left,
                  style: styleSatoshiBold(size: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select State of Posting",
                          style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12),
                        ),
                        const SizedBox(height: 5),
                        TypeAheadFormField<String>(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: stateController,
                            decoration: authDecoration(context, "Select State of Posting"),
                          ),
                          suggestionsCallback: (pattern) async {
                            return authControl.states
                                .where((state) => state.toLowerCase().contains(pattern.toLowerCase()))
                                .toList();
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (String? suggestion) {
                            if (suggestion != null) {
                              stateController.text = suggestion;
                              widget.onStatePop(suggestion);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Select State of Posting';
                            }
                            return null;
                          },
                          onSaved: (value) => authControl.setState(value!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select District of Posting",
                          style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12),
                        ),
                        const SizedBox(height: 5),
                        TypeAheadFormField<String>(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: districtController,
                            decoration: const InputDecoration(
                              labelText: 'Select District of Posting',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return authControl.districts
                                .where((district) => district.toLowerCase().contains(pattern.toLowerCase()))
                                .toList();
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (String? suggestion) {
                            if (suggestion != null) {
                              districtController.text = suggestion;
                              widget.onDistrictPop(suggestion);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Select District of Posting';
                            }
                            return null;
                          },
                          onSaved: (value) => authControl.setDistrict(value!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

