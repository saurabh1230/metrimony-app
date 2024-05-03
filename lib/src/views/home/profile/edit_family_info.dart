import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis/profile_apis/family_info_apis.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/family_model.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';
import 'package:shimmer/shimmer.dart';
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
    fatherNameController.text = familyData.fatherName.toString() ?? 'Nil';
    fatherProfessionController.text =familyData.fatherProfession.toString() ?? 'Nil';
    fatherContactController.text =familyData.fatherContact.toString() ?? 'Nil';
    motherNameController.text = familyData.motherName.toString()?? 'Nil';
    motherProfessionController.text =familyData.motherProfession.toString() ?? 'Nil';
    motherContactController.text = familyData.motherContact.toString() ?? 'Nil';
    totalBrotherController.text =familyData.totalBrother.toString() ?? 'Nil';
    totalSisterController.text =familyData.totalSister.toString() ?? 'Nil';

  }

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: buildBottomBar(context),
      body: isLoading ? const FamilyInfoShimmerWidget(): CustomRefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return familyInfo();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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

                          ),
                        );
                      },
                    );
                  },
                  child: buildDataAddRow(title: 'Father Name',
                    data1: fatherNameController.text.isEmpty
                        ? (familyData.id == null || familyData.fatherName == null || familyData.fatherName!.isEmpty
                        ? 'Add Now'
                        : familyData.fatherName!)
                        : fatherNameController.text,
                    data2: StringUtils.capitalize(fatherNameController.text),
                    isControllerTextEmpty: fatherNameController.text.isEmpty,),

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

                          ),
                        );
                      },
                    );
                  },
                  child: buildDataAddRow(title: 'Father Profession',
                      data1: fatherProfessionController.text.isEmpty
                          ? (familyData.id == null || familyData.fatherProfession == null || familyData.fatherProfession!.isEmpty
                          ? 'Add Now'
                          : familyData.fatherProfession!)
                          : fatherProfessionController.text,
                      data2: StringUtils.capitalize(fatherProfessionController.text),
                      isControllerTextEmpty: fatherProfessionController.text.isEmpty),

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
                        ? 'Add Now'
                        : familyData.fatherContact!)
                        : fatherContactController.text,
                    data2: fatherContactController.text,
                    isControllerTextEmpty: fatherContactController.text.isEmpty,),

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
                        ? 'Add Now'
                        : familyData.motherName!)
                        : motherNameController.text,
                    data2: StringUtils.capitalize(motherNameController.text),
                    isControllerTextEmpty: motherNameController.text.isEmpty,),
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
                          ),
                        );
                      },
                    );
                  },
                  child: buildDataAddRow(title: 'Mother Profession',
                    data1: motherProfessionController.text.isEmpty
                        ? (familyData.id == null || familyData.motherProfession == null || familyData.motherProfession!.isEmpty
                        ? 'Add Now'
                        : familyData.motherProfession!)
                        : motherProfessionController.text,
                    data2: StringUtils.capitalize(motherProfessionController.text),
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
                        ? 'Add Now'
                        : familyData.motherContact!)
                        : motherContactController.text,
                    data2: motherContactController.text,
                    isControllerTextEmpty: motherContactController.text.isEmpty,),
                  // child: CarRowWidget(favourites: favourites!,)
                ),
                sizedBox16(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child:loading ? loadingButton(context: context) : button(context: context, onTap: () {
           if(fatherNameController.text.isNotEmpty &&
               fatherProfessionController.text.isNotEmpty &&
               fatherContactController.text.isNotEmpty &&
               motherNameController.text.isNotEmpty &&
               motherProfessionController.text.isNotEmpty &&
               motherContactController.text.isNotEmpty ) {
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
                 Navigator.pop(context);
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
           } else {
             Fluttertoast.showToast(msg: "Please Add All Details");
           }

          },  title: "Save"),
        ),
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


class FamilyInfoShimmerWidget extends StatelessWidget {
  const FamilyInfoShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          children: [
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),


          ],
        ),
      ),
    );
  }
}
