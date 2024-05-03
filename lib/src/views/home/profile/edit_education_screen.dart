import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis/profile_apis/education_info_api.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/education_info_model.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/customAppbar.dart';
import '../../../utils/widgets/loader.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';
import 'package:get/get.dart';
class EditEducationScreen extends StatefulWidget {
  const EditEducationScreen({super.key});

  @override
  State<EditEducationScreen> createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditEducationScreen> {


  bool isLoading = false;
  @override
  void initState() {
    educationInfo();
    super.initState();
  }

  List<EducationInfoModel> educationDetails = [];
  educationInfo() {
    isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
      educationDetails.clear();
      if(value['status'] == true) {
        setState(() {
          // profile = ProfileModel.fromJson(value);
          for (var v in value['data']['user']['education_info']) {
            educationDetails.add(EducationInfoModel.fromJson(v));
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

  final instituteController = TextEditingController();
  final degreeController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final registrationNoController = TextEditingController();
  final rollNoController = TextEditingController();
  final startingYearController = TextEditingController();
  final endingYearController = TextEditingController();
  final resultController = TextEditingController();
  final outOfController = TextEditingController();


  bool loading = false;
  List<String> selectedItems = [];
  String selectedItemId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: "Education Info",menuWidget: Row(children: [selectedItemId.isNotEmpty ?
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            educationInfoDeleteApi(id: selectedItemId
            ).then((value) {
              setState(() {
              });
              if (value['status'] == true) {
                setState(() {
                  loading = false;
                  isLoading  ?  const Loading() :  educationInfo();
                });

                // isLoading ? Loading() :careerInfo();
                // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                // const KycWaitScreen()));

                // ToastUtil.showToast("Login Successful");

                ToastUtil.showToast("Deleted Successfully");

              } else {
                setState(() {
                  loading = false;
                });


                List<dynamic> errors = value['message']['error'];
                String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                Fluttertoast.showToast(msg: errorMessage);
              }
            });
          },
          child:const  Icon(Icons.delete,color: Colors.white,)) :
      const  SizedBox(),
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
                              Text("Education",
                                style: styleSatoshiBold(size: 18, color: Colors.black),),
                              sizedBox16(),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildTextFormField(context, hint: 'Institute', controller: instituteController),
                                  ),
                                  const SizedBox(width: 6,),
                                  Expanded(
                                    child: buildTextFormField(context, hint: 'Degress', controller: degreeController),
                                  ),
                                ],
                              ),
                              sizedBox10(),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildTextFormField(context, hint: 'Study', controller: fieldOfStudyController),
                                  ),
                                  const SizedBox(width: 6,),
                                  Expanded(
                                    child: buildTextFormField(context, hint: 'Registration No',
                                        controller: registrationNoController,
                                        keyboard: TextInputType.number
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox10(),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildTextFormField(context, hint: 'Roll No', controller: rollNoController,
                                        keyboard: TextInputType.number),
                                  ),
                                  const SizedBox(width: 6,),
                                  Expanded(
                                    child: buildTextFormField(context, hint: 'Starting year', controller: startingYearController,
                                        keyboard: TextInputType.number),
                                  ),
                                ],
                              ),
                              sizedBox10(),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildTextFormField(context, hint: 'Ending Year', controller: endingYearController,
                                        keyboard: TextInputType.number),
                                  ),
                                  const SizedBox(width: 6,),
                                  Expanded(
                                    child: buildTextFormField(context, hint: 'Result in no', controller: resultController,
                                        keyboard: TextInputType.number),
                                  ),
                                ],
                              ),
                              sizedBox10(),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildTextFormField(context, hint: 'Out of', controller: outOfController,
                                        keyboard: TextInputType.number),
                                  ),

                                ],
                              ),
                              sizedBox16(),
                              loading ?
                              loadingElevatedButton(context: context,
                                  color: primaryColor):
                              elevatedButton(
                                  color: primaryColor,
                                  context: context, onTap: () {
                                setState(() {
                                  loading =true;
                                });
                                educationInfoAddApi(
                                    institute: instituteController.text,
                                    degree: degreeController.text,
                                    fieldOfStudy: fieldOfStudyController.text,
                                    regNO: resultController.text,
                                    start: startingYearController.text,
                                    end: endingYearController.text,
                                    result: resultController.text,
                                    outOf: outOfController.text,
                                    rollNo: rollNoController.text).then((value) {
                                  setState(() {
                                  });
                                  if (value['status'] == true) {


                                    setState(() {
                                      loading = false;
                                      educationInfo();
                                    });
                                    instituteController.clear();
                                    degreeController.clear();
                                    fieldOfStudyController.clear();
                                    resultController.clear();
                                    startingYearController.clear();
                                    endingYearController.clear();
                                    resultController.clear();
                                    outOfController.clear();
                                    rollNoController.clear();
                                    Navigator.pop(context);
                                    ToastUtil.showToast("Updated Successfully");

                                  } else {
                                    setState(() {
                                      loading = false;
                                    });


                                    List<dynamic> errors = value['message']['error'];
                                    String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                                    Fluttertoast.showToast(msg: errorMessage);
                                  }
                                });
                              }, title: "Save")
                            ],
                          )
                      );
                    }
                );
              },
            );


          },
          child: const Padding(
            padding:  EdgeInsets.only(right: 16.0),
            child: Icon(Icons.add,color: Colors.white,),
          ),
        )],
      ),),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: button(context: context, onTap: () {
            Navigator.pop(context);
          },  title: "Save"),
        ),
      ),
      body:isLoading ? const Loading() :CustomRefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return educationInfo();
        },
        child: SingleChildScrollView(
          physics: const  AlwaysScrollableScrollPhysics(),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
            child: Column(
              children: [
                educationDetails.isEmpty ||educationDetails == null ?
                    Center(child: GestureDetector(
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
                                          Text("Education",
                                            style: styleSatoshiBold(size: 18, color: Colors.black),),
                                          sizedBox16(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildTextFormField(context, hint: 'Institute', controller: instituteController),
                                              ),
                                              const SizedBox(width: 6,),
                                              Expanded(
                                                child: buildTextFormField(context, hint: 'Degress', controller: degreeController),
                                              ),
                                            ],
                                          ),
                                          sizedBox10(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildTextFormField(context, hint: 'Study', controller: fieldOfStudyController),
                                              ),
                                              const SizedBox(width: 6,),
                                              Expanded(
                                                child: buildTextFormField(context, hint: 'Registration No',
                                                    controller: registrationNoController,
                                                    keyboard: TextInputType.number
                                                ),
                                              ),
                                            ],
                                          ),
                                          sizedBox10(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildTextFormField(context, hint: 'Roll No', controller: rollNoController,
                                                    keyboard: TextInputType.number),
                                              ),
                                              const SizedBox(width: 6,),
                                              Expanded(
                                                child: buildTextFormField(context, hint: 'Starting year', controller: startingYearController,
                                                    keyboard: TextInputType.number),
                                              ),
                                            ],
                                          ),
                                          sizedBox10(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildTextFormField(context, hint: 'Ending Year', controller: endingYearController,
                                                    keyboard: TextInputType.number),
                                              ),
                                              const SizedBox(width: 6,),
                                              Expanded(
                                                child: buildTextFormField(context, hint: 'Result in no', controller: resultController,
                                                    keyboard: TextInputType.number),
                                              ),
                                            ],
                                          ),
                                          sizedBox10(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildTextFormField(context, hint: 'Out of', controller: outOfController,
                                                    keyboard: TextInputType.number),
                                              ),

                                            ],
                                          ),
                                          sizedBox16(),
                                          loading ?
                                          loadingElevatedButton(context: context,
                                              color: primaryColor):
                                          elevatedButton(
                                              color: primaryColor,
                                              context: context, onTap: () {
                                            setState(() {
                                              loading =true;
                                            });
                                            Get.back();

                          
                                            educationInfoAddApi(
                                                institute: instituteController.text,
                                                degree: degreeController.text,
                                                fieldOfStudy: fieldOfStudyController.text,
                                                regNO: resultController.text, start: startingYearController.text,
                                                end: endingYearController.text, result: resultController.text,
                                                outOf: outOfController.text, rollNo: rollNoController.text).then((value) {
                                            /*  setState(() {
                                              });*/
                                              if (value['status'] == true) {
                                                setState(() {
                                                  loading = false;
                                                });
                                                ToastUtil.showToast("Updated Successfully");
                                                instituteController.clear();
                                                degreeController.clear();
                                                fieldOfStudyController.clear();
                                                resultController.clear();
                                                startingYearController.clear();
                                                degreeController.clear();
                                                endingYearController.clear();
                                                resultController.clear();
                                                outOfController.clear();
                                                rollNoController.clear();


                                  
                                              } else {
                                                setState(() {
                                                  loading = false;
                                                });
                                                List<dynamic> errors = value['message']['error'];
                                                String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                                                Fluttertoast.showToast(msg: errorMessage);
                                              }
                                            });
                                          }, title: "Save")
                                        ],
                                      )
                                  );
                                }
                            );
                          },
                        );

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: DottedPlaceHolder(text: "Add Education Info"),
                      )
                    )):
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: educationDetails.length,
                    itemBuilder: (_,i) {
                  return customCard(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onLongPress: () {
                        setState(() {
                          selectedItemId = educationDetails[i].id.toString(); // Set the ID of the selected item
                        });
                      },
                      child: Column(
                        children: [
                          buildListRow(title: 'Institute', data1: StringUtils.capitalize(educationDetails[i].institute.toString()), ),
                          sizedBox6(),
                          buildListRow(title: 'Degree', data1:  StringUtils.capitalize(educationDetails[i].degree.toString()), ),
                          sizedBox6(),
                          buildListRow(title: 'Study', data1: StringUtils.capitalize(educationDetails[i].fieldOfStudy.toString()), ),
                          sizedBox6(),
                          buildListRow(title: 'Registration No', data1: educationDetails[i].regNo.toString(), ),
                          sizedBox6(),
                          buildListRow(title: 'Roll No', data1: educationDetails[i].rollNo.toString(), ),
                          sizedBox6(),
                          buildListRow(title: 'Starting Year', data1: educationDetails[i].start.toString(), ),
                          sizedBox6(),
                          buildListRow(title: 'Ending Year', data1: educationDetails[i].end.toString(), ),
                          sizedBox6(),
                          buildListRow(title: 'Result',
                            data1: double.parse(educationDetails[i].result.toString()).toStringAsFixed(0),),
                          sizedBox6(),
                          buildListRow(title: 'Out of',
                            data1: double.parse(educationDetails[i].outOf.toString()).toStringAsFixed(0),),


                        ],
                      ),
                    ), tap: () {


                  },
                    borderColor:  selectedItemId == educationDetails[i].id.toString()
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
        isControllerTextEmpty ?
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
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ) :
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(data2,
                maxLines: 4,
                textAlign: TextAlign.end,
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
      title: Text("Education",
        style: styleSatoshiBold(size: 18, color: Colors.black),
      ),
      actions: [
        selectedItemId.isNotEmpty ?
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            educationInfoDeleteApi(id: selectedItemId
               ).then((value) {
              setState(() {
              });
              if (value['status'] == true) {
                setState(() {
                  loading = false;
                  isLoading  ?  const Loading() :  educationInfo();
                });

                // isLoading ? Loading() :careerInfo();
                // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                // const KycWaitScreen()));

                // ToastUtil.showToast("Login Successful");

                ToastUtil.showToast("Deleted Successfully");
  
              } else {
                setState(() {
                  loading = false;
                });


                List<dynamic> errors = value['message']['error'];
                String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                Fluttertoast.showToast(msg: errorMessage);
              }
            });
          },
            child:const  Icon(Icons.delete)) :
          const  SizedBox(),
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
                            Text("Education",
                              style: styleSatoshiBold(size: 18, color: Colors.black),),
                            sizedBox16(),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Institute', controller: instituteController),
                                ),
                                const SizedBox(width: 6,),
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Degress', controller: degreeController),
                                ),
                              ],
                            ),
                            sizedBox10(),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Study', controller: fieldOfStudyController),
                                ),
                                const SizedBox(width: 6,),
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Registration No',
                                      controller: registrationNoController,
                                      keyboard: TextInputType.number
                                  ),
                                ),
                              ],
                            ),
                            sizedBox10(),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Roll No', controller: rollNoController,
                                      keyboard: TextInputType.number),
                                ),
                                const SizedBox(width: 6,),
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Starting year', controller: startingYearController,
                                      keyboard: TextInputType.number),
                                ),
                              ],
                            ),
                            sizedBox10(),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Ending Year', controller: endingYearController,
                                      keyboard: TextInputType.number),
                                ),
                                const SizedBox(width: 6,),
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Result in no', controller: resultController,
                                      keyboard: TextInputType.number),
                                ),
                              ],
                            ),
                            sizedBox10(),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Out of', controller: outOfController,
                                      keyboard: TextInputType.number),
                                ),

                              ],
                            ),
                            sizedBox16(),
                            loading ?
                            loadingElevatedButton(context: context,
                            color: primaryColor):
                            elevatedButton(
                                color: primaryColor,
                                context: context, onTap: () {
                              setState(() {
                                loading =true;
                              });
                              educationInfoAddApi(
                                  institute: instituteController.text,
                                  degree: degreeController.text,
                                  fieldOfStudy: fieldOfStudyController.text,
                                  regNO: resultController.text,
                                  start: startingYearController.text,
                                  end: endingYearController.text,
                                  result: resultController.text,
                                  outOf: outOfController.text,
                                  rollNo: rollNoController.text).then((value) {
                                setState(() {
                                });
                                if (value['status'] == true) {


                                  setState(() {
                                    loading = false;
                                  });
                                  instituteController.clear();
                                  degreeController.clear();
                                  fieldOfStudyController.clear();
                                  resultController.clear();
                                  startingYearController.clear();
                                  endingYearController.clear();
                                  resultController.clear();
                                  outOfController.clear();
                                  rollNoController.clear();
                                  Navigator.pop(context);
                                  ToastUtil.showToast("Updated Successfully");
                  
                                } else {
                                  setState(() {
                                    loading = false;
                                  });


                                  List<dynamic> errors = value['message']['error'];
                                  String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                                  Fluttertoast.showToast(msg: errorMessage);
                                }
                              });
                            }, title: "Save")
                          ],
                        )
                    );
                }
                );
              },
            );


          },
          child: const Padding(
            padding:  EdgeInsets.only(right: 16.0),
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }

  TextFormField buildTextFormField(BuildContext context,
  {required String hint,required TextEditingController controller,
    TextInputType ? keyboard,}) {
    return TextFormField(
      keyboardType: keyboard ?? TextInputType.name,
      textInputAction: TextInputAction.next,

      inputFormatters: [
        LengthLimitingTextInputFormatter(40),
      ],
                            onChanged: (v) {
                              setState(() {

                              });
                            },
                            onEditingComplete: () {
                              // Navigator.pop(context); // Close the dialog
                            },
                            controller: controller,
                            decoration: AppTFDecoration(
                                hint: hint).decoration(),
                            //keyboardType: TextInputType.phone,
                          );
  }
}
