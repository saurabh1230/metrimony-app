import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis/profile_apis/education_info_api.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/textstyles.dart';
import '../../../models/education_info_model.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/loader.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';

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
      appBar: buildAppBar(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomRefreshIndicator(
          onRefresh: () {
            setState(() {
              isLoading = true;
            });
            return educationInfo();
          },
          child: SingleChildScrollView(
            child: button(context: context, onTap: () {
              print(selectedItemId);
            },  title: "Save"),
          ),
        ),
      ),
      body:isLoading ?Loading() :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: Column(
            children: [

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
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
                        buildListRow(title: 'Institute', data1: educationDetails[i].institute.toString(), ),
                        buildListRow(title: 'Degree', data1: educationDetails[i].degree.toString(), ),
                        buildListRow(title: 'Study', data1: educationDetails[i].fieldOfStudy.toString(), ),
                        buildListRow(title: 'Registration No', data1: educationDetails[i].regNo.toString(), ),
                        buildListRow(title: 'Roll No', data1: educationDetails[i].rollNo.toString(), ),
                        buildListRow(title: 'Starting Year', data1: educationDetails[i].start.toString(), ),
                        buildListRow(title: 'Ending Year', data1: educationDetails[i].end.toString(), ),
                        buildListRow(title: 'Result', data1: educationDetails[i].result.toString(), ),
                        buildListRow(title: 'Out of', data1: educationDetails[i].outOf.toString(), ),


                      ],
                    ),
                  ), tap: () {


                },
                  borderColor:  selectedItemId == educationDetails[i].id.toString()
                      ? Colors.red
                      : Colors.grey,
                );
              }),
          /*    GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Institute',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: instituteController,
                          decoration: AppTFDecoration(
                              hint: 'Institute').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Institute',
                    data1: instituteController.text.isEmpty ?
                    'Update Info':
                     instituteController.text, data2: instituteController.text,
                  isControllerTextEmpty: instituteController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'degree',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: degreeController,
                          decoration: AppTFDecoration(
                              hint: 'degree').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'degree',
                  data1: degreeController.text.isEmpty ?
                  'Update Info':
                  degreeController.text, data2: degreeController.text,
                  isControllerTextEmpty: degreeController.text.isEmpty),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Study',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: fieldOfStudyController,
                          decoration: AppTFDecoration(
                              hint: 'Study').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Study',
                  data1: fieldOfStudyController.text.isEmpty ?
                  'Update Info':
                  fieldOfStudyController.text, data2: fieldOfStudyController.text,
                  isControllerTextEmpty: fieldOfStudyController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Registration No',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: registrationNoController,
                          decoration: AppTFDecoration(
                              hint: 'Registration No').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Registration No',
                  data1: registrationNoController.text.isEmpty ?
                  'Update Info':
                  registrationNoController.text, data2: registrationNoController.text,
                  isControllerTextEmpty: registrationNoController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Roll No',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: rollNoController,
                          decoration: AppTFDecoration(
                              hint: 'Roll No').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Roll No',
                  data1: rollNoController.text.isEmpty ?
                  'Update Info':
                  rollNoController.text, data2: rollNoController.text,
                  isControllerTextEmpty: rollNoController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Starting Year',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: startingYearController,
                          decoration: AppTFDecoration(
                              hint: 'Starting Year').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Starting Year',
                  data1: startingYearController.text.isEmpty ?
                  'Update Info':
                  startingYearController.text, data2: startingYearController.text,
                  isControllerTextEmpty: startingYearController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Ending Year',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: endingYearController,
                          decoration: AppTFDecoration(
                              hint: 'Ending Year').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Ending Year',
                  data1: endingYearController.text.isEmpty ?
                  'Update Info':
                  endingYearController.text, data2: endingYearController.text,
                  isControllerTextEmpty: endingYearController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Result',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: resultController,
                          decoration: AppTFDecoration(
                              hint: 'Result').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Result',
                  data1: resultController.text.isEmpty ?
                  'Update Info':
                  resultController.text, data2: resultController.text,
                  isControllerTextEmpty: resultController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Out of',
                        addTextField:TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: outOfController,
                          decoration: AppTFDecoration(
                              hint: 'hint').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Out Of',
                  data1: outOfController.text.isEmpty ?
                  'Update Info':
                  outOfController.text, data2: outOfController.text,
                  isControllerTextEmpty: outOfController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),*/


            ],
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
          onTap: () {
            educationInfoDeleteApi(id: selectedItemId
               ).then((value) {
              setState(() {
              });
              if (value['status'] == true) {
                setState(() {
                  loading = false;
                  isLoading  ? Loading() :  educationInfo();
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
                String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                Fluttertoast.showToast(msg: errorMessage);
              }
            });
          },
            child: Icon(Icons.delete)) :
            SizedBox(),
        GestureDetector(
          onTap: () {

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return EditDialogWidget(
                        addTextField: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextFormField(context, hint: 'Institute', controller: instituteController),
                                ),
                                SizedBox(width: 6,),
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
                                SizedBox(width: 6,),
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
                                SizedBox(width: 6,),
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
                                SizedBox(width: 6,),
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
                                  regNO: resultController.text, start: startingYearController.text,
                                  end: endingYearController.text, result: resultController.text,
                                  outOf: outOfController.text, rollNo: rollNoController.text).then((value) {
                                setState(() {
                                });
                                if (value['status'] == true) {
                                  setState(() {
                                    loading = false;
                                  });

                                  // isLoading ? Loading() :careerInfo();
                                  // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                                  // const KycWaitScreen()));

                                  // ToastUtil.showToast("Login Successful");

                                  ToastUtil.showToast("Updated Successfully");
                                  print('done');
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
            padding: const EdgeInsets.only(right: 16.0),
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

      inputFormatters: [
        LengthLimitingTextInputFormatter(40),
      ],
                            onChanged: (v) {
                              setState(() {

                              });
                            },
                            onEditingComplete: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            controller: controller,
                            decoration: AppTFDecoration(
                                hint: hint).decoration(),
                            //keyboardType: TextInputType.phone,
                          );
  }
}
