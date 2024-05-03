
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/models/other_person_details_models.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
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
    super.initState();
  }

  List<CareerInfoModel> career = [];

  careerInfo() {
    isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
      career.clear();
      if (value['status'] == true) {
        setState(() {
          // profile = ProfileModel.fromJson(value);
          for (var v in value['data']['user']['career_info']) {
            career.add(CareerInfoModel.fromJson(v));
          }
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

  List<String> selectedItems = [];
  String selectedItemId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: "Career Info",menuWidget: Row(children: [  selectedItemId.isNotEmpty
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
          child: Icon(Icons.delete,color: Colors.white,))
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
                                  const SizedBox(
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
          child: const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.add,color: Colors.white,),
          ),
        )],),),
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
          ? Loading()
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
                                                const SizedBox(
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
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: career.length,
                          itemBuilder: (_, i) {
                            return customCard(
                              child: GestureDetector(
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
                                      title: 'company',
                                      data1: StringUtils.capitalize(career[i].company.toString()),
                                    ),
                                    buildListRow(
                                      title: 'designation',
                                      data1:StringUtils.capitalize(career[i].designation.toString()),
                                    ),
                                    buildListRow(
                                      title: 'start',
                                      data1: career[i].start.toString(),
                                    ),
                                    buildListRow(
                                      title: 'end',
                                      data1: career[i].end.toString(),
                                    ),
                                  ],
                                ),
                              ),
                              tap: () {},
                              borderColor:
                                  selectedItemId == career[i].id.toString()
                                      ? Colors.red
                                      : Colors.grey,
                            );
                          }),
                    ],
                  ),
                ),
              ),
          ),
    );
  }

  Row buildListRow({
    required String title,
    required String data1,
  }) {
    return Row(
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
