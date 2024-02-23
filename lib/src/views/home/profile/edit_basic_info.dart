import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../apis/profile_apis/basic_info_api.dart';
import '../../../apis/profile_apis/education_info_api.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../apis/profile_apis/physical_attributes_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/textstyles.dart';
import '../../../models/attributes_model.dart';
import '../../../models/basic_info_model.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';
import 'package:fluttertoast/fluttertoast.dart';
class EditBasicInfoScreen extends StatefulWidget {
  const EditBasicInfoScreen({super.key});

  @override
  State<EditBasicInfoScreen> createState() => _EditBasicInfoScreenState();
}

class _EditBasicInfoScreenState extends State<EditBasicInfoScreen> {
  final professionController = TextEditingController();
  final genderController = TextEditingController();
  final religionController = TextEditingController();
  final smokingController = TextEditingController();
  final drinkingController = TextEditingController();
  final birthDateController = TextEditingController();
  final communityController = TextEditingController();
  final motherTongueController = TextEditingController();
  final marriedStatusController = TextEditingController();

  bool loading = false;
  bool isLoading = false;

  @override
  void initState() {
    careerInfo();
    super.initState();
  }

  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();


  BasicInfoModel basicInfo = BasicInfoModel();

  careerInfo() {
    isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
      // physicalData.clear();
      if (value['status'] == true) {
        setState(() {
          var physicalAttributesData = value['data']['user']['basic_info'];
          if (physicalAttributesData != null) {
            setState(() {
              basicInfo = BasicInfoModel.fromJson(physicalAttributesData);
              // fields();
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
    professionController.text = basicInfo.profession.toString() ?? '';
    genderController.text =basicInfo.gender.toString() ?? '';
    religionController.text =basicInfo.religion.toString() ?? '';
    smokingController.text = basicInfo.smokingStatus.toString()?? '';
    drinkingController.text =basicInfo.drinkingStatus.toString() ?? '';
    birthDateController.text = basicInfo.birthDate.toString() ?? '';
    communityController.text = basicInfo.community.toString() ?? '';
    motherTongueController.text =basicInfo.motherTongue.toString() ?? '';
    marriedStatusController.text =basicInfo.maritalStatus.toString() ?? '';

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: buildBottombarPadding(context),
      body:isLoading ? Loading() : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: Column(
            children: [
              GestureDetector(
                // onTap: _pickImage
                onTap: () async {
                  XFile? v = await _imgPicker.pickImage(
                      source: ImageSource.gallery);
                  if (v != null) {
                    setState(
                          () {
                        pickedImage = File(v.path);
                      },
                    );

                  }

                },
                child: Container(
                  height: 104,
                  width:  104,
                  clipBehavior: Clip.hardEdge,
                  decoration:  const BoxDecoration(
                    shape: BoxShape.circle,

                  ) ,
                  child: pickedImage.path.isEmpty
                      ? Image.asset(icProfilePlaceHolder,
                  )
                      : Image.file(
                    pickedImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              sizedBox16(),
              loading ?
                  loadingElevatedButton(
                      color: Colors.green,


                      height: 30,
                      width: 80,
                      context: context) :
              elevatedButton(
                color: Colors.green,
                height: 30,
                  style: styleSatoshiLight(size: 10, color: Colors.white),
                  width: 80,
                  context: context, onTap: () {
                  setState(() {
                    loading = true;
                  });
                  addProfileImageAPi( photo: pickedImage.path
                    // id: career[0].id.toString(),
                  )
                      .then((value) {
                    if (value['status'] == true) {
                      setState(() {
                        loading = false;
                      });

                      // isLoading ? Loading() :careerInfo();
                      // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                      // const KycWaitScreen()));

                      // ToastUtil.showToast("Login Successful");

                    ToastUtil.showToast("Image Updated Successfully");
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

              }, title: "Add"),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Profession',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: professionController,
                          decoration: AppTFDecoration(
                              hint: 'Profession').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(
                  title: 'Profession',
                  data1: professionController.text.isEmpty
                      ? (basicInfo.id == null || basicInfo.profession == null || basicInfo.profession!.isEmpty
                      ? 'Not Added'
                      : basicInfo.profession!)
                      : professionController.text,


                  //   complexionController.text.isEmpty
                  //       ? (physicalData == null || physicalData.complexion.isEmpty
                  //       ? 'Update Info'
                  //       : physicalData.complexion
                  // : complexionController.text,
                  /* data1:
                  complexionController.text.isEmpty ?
                  'Update Info':
                  complexionController.text,*/
                  data2: professionController.text,
                  isControllerTextEmpty: professionController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
            /*      showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Gender',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: genderController,
                          decoration: AppTFDecoration(
                              hint: 'Gender').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );*/
                },
                child: buildDataAddRow(
                  widget: const SizedBox(),
                  title: 'Gender',
                  data1: genderController.text.isEmpty
                      ? (basicInfo.id == null || basicInfo.gender == null ||  basicInfo.gender!.isEmpty
                      ? 'Not Added'
                      :  basicInfo.gender.toString())
                      : genderController.text,
                  data2: genderController.text,
                  isControllerTextEmpty: genderController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
              /*    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Religion',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: religionController,
                          decoration: AppTFDecoration(
                              hint: 'Religion').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );*/
                },
                child: buildDataAddRow(
                  widget: const SizedBox(),
                  title: 'Religion',
                  data1: religionController.text.isEmpty
                      ? ( basicInfo.id == null ||  basicInfo.religion== null || basicInfo.religion!.isEmpty
                      ? 'Not Added'
                      : basicInfo.religion.toString())
                      : religionController.text,
                  data2: religionController.text,
                  isControllerTextEmpty: religionController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Married Status',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: religionController,
                          decoration: AppTFDecoration(
                              hint: 'Married Status').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Married Status',
                  data1: religionController.text.isEmpty
                      ? ( basicInfo.id == null ||  basicInfo.maritalStatus== null || basicInfo.maritalStatus!.isEmpty
                      ? 'Not Added'
                      : basicInfo.maritalStatus.toString())
                      : religionController.text,
                  data2: religionController.text,
                  isControllerTextEmpty: religionController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Smoking status ',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: smokingController,
                          decoration: AppTFDecoration(
                              hint: 'Smoking status').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Smoking status',
                  data1: smokingController.text.isEmpty
                      ? (basicInfo.id == null || basicInfo.smokingStatus == null
                      ? 'Not Added'
                      : basicInfo.smokingStatus.toString())
                      : smokingController.text,
                  data2: smokingController.text,
                  isControllerTextEmpty: smokingController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Drinking status',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {

                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: drinkingController,
                          decoration: AppTFDecoration(
                              hint: 'Drinking status').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Drinking status',
                  data1: drinkingController.text.isEmpty
                      ? (basicInfo.id == null || basicInfo.drinkingStatus == null
                      ? 'Not Added'
                      : basicInfo.drinkingStatus.toString())
                      : drinkingController.text,
                  data2: drinkingController.text,
                  isControllerTextEmpty: drinkingController.text.isEmpty,),
                // child: CarRowWidget(drinkingController)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Birth date',
                  //       addTextField: TextFormField(
                  //         maxLength: 40,
                  //         onChanged: (v) {
                  //           setState(() {
                  //           });
                  //         },
                  //         onEditingComplete: () {
                  //           Navigator.pop(context); // Close the dialog
                  //         },
                  //         controller: birthDateController,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Birth date').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: buildDataAddRow(
                  widget: const SizedBox(),
                  title: 'Birth date',
                  data1: birthDateController.text.isEmpty
                      ? (basicInfo.id == null || basicInfo.birthDate == null || basicInfo.birthDate!.isEmpty
                      ? 'Not Added'
                      : basicInfo.birthDate!.toString())
                      : birthDateController.text,
                  data2: birthDateController.text,
                  isControllerTextEmpty: birthDateController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Community',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {
                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: birthDateController,
                          decoration: AppTFDecoration(
                              hint: 'Community').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Community',
                  data1: communityController.text.isEmpty
                      ? (basicInfo.id == null || basicInfo.community == null || basicInfo.community!.isEmpty
                      ? 'Not Added'
                      : basicInfo.community.toString())
                      : communityController.text,
                  data2: communityController.text,
                  isControllerTextEmpty: communityController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),
              sizedBox16(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Mother Tongue',
                        addTextField: TextFormField(
                          maxLength: 40,
                          onChanged: (v) {
                            setState(() {
                            });
                          },
                          onEditingComplete: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          controller: motherTongueController,
                          decoration: AppTFDecoration(
                              hint: 'Mother Tongue').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );
                },
                child: buildDataAddRow(title: 'Mother Tongue',
                  data1: motherTongueController.text.isEmpty
                      ? (basicInfo.id == null || basicInfo.motherTongue == null || basicInfo.motherTongue!.isEmpty
                      ? 'Not Added'
                      : basicInfo.motherTongue.toString())
                      : motherTongueController.text,
                  data2: motherTongueController.text,
                  isControllerTextEmpty: motherTongueController.text.isEmpty,),
                // child: CarRowWidget(favourites: favourites!,)
              ),





            ],
          ),
        ),
      ),
    );
  }

  Padding buildBottombarPadding(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child:
        loading ?
        loadingButton(context: context) :button(context: context, onTap: () {
          setState(() {
            loading = true;
          });
          updateBasicInfo(
              profession: professionController.text,
              religion: religionController.text,
              motherTongue: motherTongueController.text,
              community: communityController.text,
              smokingStatus: smokingController.text,
              drinkingStatus: drinkingController.text,
              maritalStatus: marriedStatusController.text).then((value) {
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
     Widget? widget,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 2,),

                    isControllerTextEmpty ?
                    widget??
                    Icon(Icons.edit,size: 12,) :
                        SizedBox(),
                  ],
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
      title: Text("Basic Info",
        style: styleSatoshiBold(size: 18, color: Colors.black),
      ),
    );
  }
}
