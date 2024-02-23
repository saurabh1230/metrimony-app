import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis/profile_apis/family_info_apis.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/textstyles.dart';
import '../../../models/family_model.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';

class EditFamilyInfoScreen extends StatefulWidget {
  const EditFamilyInfoScreen({super.key});

  @override
  State<EditFamilyInfoScreen> createState() => _EditFamilyInfoScreenState();
}

class _EditFamilyInfoScreenState extends State<EditFamilyInfoScreen> {
  final fatherNameController = TextEditingController();
  final fatherProfessionController = TextEditingController();
  final fatherContactController = TextEditingController();
  final motherNameController = TextEditingController();
  final motherProfessionController = TextEditingController();
  final motherContactController = TextEditingController();
  final totalBrotherController = TextEditingController();
  final totalSisterController = TextEditingController();

  bool loading = false;
  bool isLoading = false;

  @override
  void initState() {
    familyInfo();
    super.initState();
  }


  FamilyModel familyData = FamilyModel();

  familyInfo() {
      isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
      // physicalData.clear();
      if (value['status'] == true) {
        setState(() {
          var physicalAttributesData = value['data']['user']['family'];
          if (physicalAttributesData != null) {
            setState(() {
              familyData = FamilyModel.fromJson(physicalAttributesData);
              fields();
            });
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

  void fields() {
    fatherNameController.text = familyData.fatherName.toString() ?? '';
    fatherProfessionController.text =familyData.fatherProfession.toString() ?? '';
    fatherContactController.text =familyData.fatherContact.toString() ?? '';
    motherNameController.text = familyData.motherName.toString()?? '';
    motherProfessionController.text =familyData.motherProfession.toString() ?? '';
    motherContactController.text = familyData.motherContact.toString() ?? '';
    totalBrotherController.text =familyData.totalBrother.toString() ?? '';
    totalSisterController.text =familyData.totalSister.toString() ?? '';

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: buildBottomBar(context),
      body: isLoading ? Loading(): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Father Name',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: fatherNameController,
                          decoration: AppTFDecoration(
                              hint: 'Father Name').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Father Name',
                  data1: fatherNameController.text.isEmpty
                      ? (familyData.id == null || familyData.fatherName == null || familyData.fatherName!.isEmpty
                      ? 'Not Added'
                      : familyData.fatherName!)
                      : fatherNameController.text,
                  data2: fatherNameController.text,
                  isControllerTextEmpty: fatherNameController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Father Profession',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: fatherProfessionController,
                          decoration: AppTFDecoration(
                              hint: 'Father Profession').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Father Profession',
                    data1: fatherProfessionController.text.isEmpty
                        ? (familyData.id == null || familyData.fatherProfession == null || familyData.fatherProfession!.isEmpty
                        ? 'Not Added'
                        : familyData.fatherProfession!)
                        : fatherProfessionController.text,
                    data2: fatherProfessionController.text,
                    isControllerTextEmpty: fatherProfessionController.text.isEmpty),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Father Contact',
                        addTextField: TextFormField(
                          keyboardType : TextInputType.number,
                          maxLength: 10,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: fatherContactController,
                          decoration: AppTFDecoration(
                              hint: 'Father Contact').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Father Contact',
                  data1:fatherContactController.text.isEmpty
                      ? (familyData.id == null || familyData.fatherContact == null || familyData.fatherContact!.isEmpty
                      ? 'Not Added'
                      : familyData.fatherContact!)
                      : fatherContactController.text,
                  data2: fatherContactController.text,
                  isControllerTextEmpty: fatherContactController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Mother Name',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: motherNameController,
                          decoration: AppTFDecoration(
                              hint: 'Mother Name').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Mother Name',
                  data1: motherNameController.text.isEmpty
                      ? (familyData.id == null || familyData.motherName == null || familyData.motherName!.isEmpty
                      ? 'Not Added'
                      : familyData.motherName!)
                      : motherNameController.text,
                  data2: motherNameController.text,
                  isControllerTextEmpty: motherNameController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Mother Profession',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: motherProfessionController,
                          decoration: AppTFDecoration(
                              hint: 'Mother Profession').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Mother Profession',
                  data1: motherProfessionController.text.isEmpty
                      ? (familyData.id == null || familyData.motherProfession == null || familyData.motherProfession!.isEmpty
                      ? 'Not Added'
                      : familyData.motherProfession!)
                      : motherProfessionController.text,
                  data2: motherProfessionController.text,
                  isControllerTextEmpty: motherProfessionController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Mother Contact',
                        addTextField: TextFormField(
                          keyboardType : TextInputType.number,
                          maxLength: 10,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: motherContactController,
                          decoration: AppTFDecoration(
                              hint: 'Mother Contact').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Mother Contact',
                  data1: motherContactController.text.isEmpty
                      ? (familyData.id == null || familyData.motherContact == null || familyData.motherContact!.isEmpty
                      ? 'Not Added'
                      : familyData.motherContact!)
                      : motherContactController.text,
                  data2: motherContactController.text,
                  isControllerTextEmpty: motherContactController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
             /* GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Total Brothers',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: totalBrotherController,
                          decoration: AppTFDecoration(
                              hint: 'Total Brothers').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Total Brothers',
                  data1:  totalBrotherController.text.isEmpty
                      ? (familyData.id == null || familyData.totalBrother == null || familyData.motherContact!.isEmpty
                      ? 'Not Added'
                      : familyData.motherContact!)
                      : totalBrotherController.text,
                  data2: totalBrotherController.text,
                  isControllerTextEmpty: totalBrotherController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),*/




            ],
          ),
        ),
      ),
    );
  }

  Padding buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child:loading ? loadingButton(context: context) : button(context: context, onTap: () {
          setState(() {
            loading = true;
          });
          familyInfoUpdateApi(
              fatherName: fatherNameController.text,
              fatherProfession: fatherProfessionController.text,
              fatherContact: fatherContactController.text,
              motherName: motherNameController.text,
              motherProfession: motherProfessionController.text,
              motherContact: motherContactController.text,
              totalBrother: '0',
              totalSister: "0").then((value) {
            setState(() {
            });
            if (value['status'] == true) {
              setState(() {
                loading = false;
              });
              dynamic message = value['message']['original']['message'];
              List<String> errors = [];

              if (message != null && message is Map) {
                // If the message is not null and is a Map, extract the error messages
                message.forEach((key, value) {
                  errors.addAll(value);
                });
              }

              String errorMessage = errors.isNotEmpty ? errors.join(", ") : "Update succesfully.";
              Fluttertoast.showToast(msg: errorMessage);

              // isLoading ? Loading() :careerInfo();
              // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
              // const KycWaitScreen()));

              // ToastUtil.showToast("Login Successful");

              // ToastUtil.showToast("Updated Successfully");
              print('done');
            } else {
              setState(() {
                loading = false;
              });


              List<dynamic> errors = value['message']['original']['message'];
              String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
              Fluttertoast.showToast(msg: errorMessage);
            }
          });

        },  title: "Save"),
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
      title: Text("Family Info",
        style: styleSatoshiBold(size: 18, color: Colors.black),
      ),
    );
  }
}
