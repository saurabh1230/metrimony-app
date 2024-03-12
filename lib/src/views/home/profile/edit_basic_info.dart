import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../apis/profile_apis/basic_info_api.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/basic_info_model.dart';
import '../../../models/info_model.dart';
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
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final professionController = TextEditingController();
  final genderController = TextEditingController();
  final religionController = TextEditingController();
  final smokingController = TextEditingController();
  final drinkingController = TextEditingController();
  final birthDateController = TextEditingController();
  final communityController = TextEditingController();
  final motherTongueController = TextEditingController();
  final marriedStatusController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final financialCondition = TextEditingController();
  final aboutUs = TextEditingController();
  bool load = false;
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
  InfoModel mainInfo = InfoModel();

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
              fields();
            });
          }
          var info = value['data']['user'];
          if (info != null) {
            setState(() {
              mainInfo = InfoModel.fromJson(info);
              fields();
            });
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

  void fields() {
    firstNameController.text = mainInfo?.firstname.toString() ?? '';
    lastNameController.text = mainInfo?.lastname.toString() ?? '';
    userNameController.text = mainInfo?.username.toString() ?? '';
    emailController.text = mainInfo?.email.toString() ?? '';
    professionController.text = basicInfo?.profession?.toString() ?? '';
    genderController.text = basicInfo?.gender?.toString() ?? '';
    religionController.text = basicInfo?.religion?.toString() ?? '';
    smokingController.text = basicInfo?.smokingStatus?.toString() ?? '';
    drinkingController.text = basicInfo?.drinkingStatus?.toString() ?? '';
    birthDateController.text = basicInfo?.birthDate?.toString() ?? '';
    communityController.text = basicInfo?.community?.toString() ?? '';
    motherTongueController.text = basicInfo?.motherTongue?.toString() ?? '';
    marriedStatusController.text = basicInfo?.maritalStatus?.toString() ?? '';
    stateController.text = basicInfo?.presentAddress?.state?.toString() ?? '';
    zipController.text = basicInfo?.presentAddress?.zip?.toString() ?? '';
    countryController.text =
        basicInfo?.presentAddress?.country?.toString() ?? '';
    cityController.text = basicInfo?.presentAddress?.city?.toString() ?? '';
    financialCondition.text = basicInfo?.financialCondition?.toString() ?? '';
    aboutUs.text = basicInfo?.aboutUs?.toString() ?? '';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: buildBottombarPadding(context),
      body: isLoading
          ? const Loading()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
                        width: 104,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: pickedImage.path.isEmpty
                            ? Image.asset(
                                icProfilePlaceHolder,
                              )
                            : Image.file(
                                pickedImage,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    sizedBox16(),
                    load
                        ? loadingElevatedButton(
                            color: Colors.green,
                            height: 30,
                            width: 80,
                            context: context)
                        : elevatedButton(
                            color: Colors.green,
                            height: 30,
                            style: styleSatoshiLight(
                                size: 10, color: Colors.white),
                            width: 80,
                            context: context,
                            onTap: () {
                              if (pickedImage.path.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Pick Image First");
                              } else {
                                setState(() {
                                  load = true;
                                });
                                addProfileImageAPi(photo: pickedImage.path
                                        // id: career[0].id.toString(),
                                        )
                                    .then((value) {
                                  if (value['status'] == true) {
                                    setState(() {
                                      load = false;
                                    });
                                    ToastUtil.showToast(
                                        "Image Updated Successfully");
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
                              }
                            },
                            title: "Add"),
                     GestureDetector(
                       onTap: () {
                         showDialog(
                           context: context,
                           builder: (BuildContext context) {
                             return NameEditDialogWidget(
                               title: 'About Us',
                               addTextField: TextFormField(
                                 maxLength: 200,
                                 onChanged: (v) {
                                   setState(() {});
                                 },
                                 onEditingComplete: () {
                                   Navigator.pop(context); // Close the dialog
                                 },
                                 controller: aboutUs,
                                 decoration: AppTFDecoration(hint: 'About Us')
                                     .decoration(),
                                 //keyboardType: TextInputType.phone,
                               ),
                             );
                           },
                         );

                       },
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                "About Us",
                              ),
                              SizedBox(width: 3,),
                              Icon(
                                Icons.edit,
                                size: 12,
                              ),
                            ],
                          ),
                          aboutUs.text.isEmpty?
                          SizedBox() :
                          Column(
                            children: [
                              sizedBox16(),

                              Text(
                                aboutUs.text.isEmpty
                                    ? (basicInfo.id == null ||
                                    basicInfo.aboutUs == null ||
                                    basicInfo.aboutUs!.isEmpty
                                    ? ''
                                    : basicInfo.aboutUs!)
                                    : aboutUs.text,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          )


                        ],
                                           ),
                     ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'First Name',
                              addTextField: TextFormField(
                                maxLength: 40,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller: firstNameController,
                                decoration: AppTFDecoration(hint: 'First Name')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        widget: const Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        title: 'First Name',
                        data1: firstNameController.text.isEmpty
                            ? (mainInfo == null ||
                                    mainInfo.firstname == null ||
                                    mainInfo.firstname!.isEmpty
                                ? 'Not Added'
                                : StringUtils.capitalize(mainInfo.firstname!))
                            : firstNameController.text,
                        data2: StringUtils.capitalize(firstNameController.text),
                        isControllerTextEmpty: firstNameController.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'Last Name',
                              addTextField: TextFormField(
                                maxLength: 40,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context);
                                },
                                controller: lastNameController,
                                decoration: AppTFDecoration(hint: 'Last Name')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        widget: const Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        title: 'Last Name',
                        data1: lastNameController.text.isEmpty
                            ? (mainInfo == null ||
                                    mainInfo.lastname == null ||
                                    mainInfo.lastname!.isEmpty
                                ? 'Not Added'
                                : StringUtils.capitalize(mainInfo.lastname!))
                            : StringUtils.capitalize(lastNameController.text),
                        data2: StringUtils.capitalize(lastNameController.text),
                        isControllerTextEmpty: lastNameController.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'User Name',
                              addTextField: TextFormField(
                                maxLength: 40,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller: userNameController,
                                decoration: AppTFDecoration(hint: 'User Name')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        widget: const Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        title: 'User Name',
                        data1: userNameController.text.isEmpty
                            ? (mainInfo == null ||
                                    mainInfo.username == null ||
                                    mainInfo.username!.isEmpty
                                ? 'User Name'
                                : mainInfo.username!)
                            : userNameController.text,
                        data2: userNameController.text,
                        isControllerTextEmpty: userNameController.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: buildDataAddRow(
                        widget: const SizedBox(),
                        title: 'Email',
                        data1: emailController.text.isEmpty
                            ? (mainInfo == null ||
                                    mainInfo.username == null ||
                                    mainInfo.username!.isEmpty
                                ? 'Email'
                                : mainInfo.username!)
                            : emailController.text,
                        data2: emailController.text,
                        isControllerTextEmpty: emailController.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'Profession',
                              addTextField: TextFormField(
                                maxLength: 40,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller: professionController,
                                decoration: AppTFDecoration(hint: 'Profession')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        widget: const Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        title: 'Profession',
                        data1: professionController.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.profession == null ||
                                    basicInfo.profession!.isEmpty
                                ? 'Not Added'
                                : basicInfo.profession!)
                            : professionController.text,
                        data2:
                            StringUtils.capitalize(professionController.text),
                        isControllerTextEmpty:
                            professionController.text.isEmpty,
                      ),
                      // child: CarRowWidget(favourites: favourites!,)
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: buildDataAddRow(
                        widget: const SizedBox(),
                        title: 'Gender',
                        data1: genderController.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.gender == null ||
                                    basicInfo.gender!.isEmpty
                                ? 'Not Added'
                                : basicInfo.gender.toString())
                            : genderController.text,
                        data2: StringUtils.capitalize(genderController.text),
                        isControllerTextEmpty: genderController.text.isEmpty,
                      ),
                      // child: CarRowWidget(favourites: favourites!,)
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: buildDataAddRow(
                        widget: const SizedBox(),
                        title: 'Religion',
                        data1: religionController.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.religion == null ||
                                    basicInfo.religion!.isEmpty
                                ? 'Not Added'
                                : basicInfo.religion.toString())
                            : religionController.text,
                        data2: religionController.text,
                        isControllerTextEmpty: religionController.text.isEmpty,
                      ),
                      // child: CarRowWidget(favourites: favourites!,)
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: buildDataAddRow(
                        widget: const SizedBox(),
                        title: 'Married Status',
                        data1: marriedStatusController.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.maritalStatus == null ||
                                    basicInfo.maritalStatus!.isEmpty
                                ? 'Not Added'
                                : basicInfo.maritalStatus.toString())
                            : marriedStatusController.text,
                        data2: StringUtils.capitalize(
                            marriedStatusController.text),
                        isControllerTextEmpty:
                            marriedStatusController.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return PrivacyStatusBottomSheet(
                              privacyStatus: '',
                              onPop: (val) {
                                smokingController.text = val;
                                print(smokingController.text);
                              },
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        title: 'Smoking status',
                        widget: const Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        data1: smokingController.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.smokingStatus == null
                                ? 'Not Added'
                                : basicInfo.smokingStatus.toString())
                            : smokingController.text,
                        data2: smokingController.text,
                        isControllerTextEmpty: smokingController.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return DrinkingStatusBottomSheet(
                              privacyStatus: '',
                              onPop: (val) {
                                drinkingController.text = val;
                                // print(smokingController.text);
                              },
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        title: 'Drinking status',
                        widget: const Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        data1: drinkingController.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.drinkingStatus == null
                                ? 'Not Added'
                                : basicInfo.drinkingStatus.toString())
                            : drinkingController.text,
                        data2: drinkingController.text,
                        isControllerTextEmpty: drinkingController.text.isEmpty,
                      ),
                      // child: CarRowWidget(drinkingController)
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: buildDataAddRow(
                        widget: const SizedBox(),
                        title: 'Birth date',
                        data1: birthDateController.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.birthDate == null ||
                                    basicInfo.birthDate!.isEmpty
                                ? 'Not Added'
                                : basicInfo.birthDate!.toString())
                            : birthDateController.text,
                        data2: birthDateController.text,
                        isControllerTextEmpty: birthDateController.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: buildDataAddRow(
                        title: 'Community',
                        widget:const  SizedBox(),
                        data1: communityController.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.community == null ||
                                    basicInfo.community!.isEmpty
                                ? 'Not Added'
                                : basicInfo.community.toString())
                            : communityController.text,
                        data2: StringUtils.capitalize(communityController.text),
                        isControllerTextEmpty: communityController.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'Financial Condition',
                              addTextField: TextFormField(
                                maxLength: 40,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller: financialCondition,
                                decoration:
                                    AppTFDecoration(hint: 'Financial Condition')
                                        .decoration(),
                              ),
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        title: 'Financial Condition',
                        widget: const Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        data1: financialCondition.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.financialCondition == null ||
                                    basicInfo.financialCondition!.isEmpty
                                ? 'Not Added'
                                : basicInfo.financialCondition.toString())
                            : financialCondition.text,
                        data2: StringUtils.capitalize(financialCondition.text),
                        isControllerTextEmpty: financialCondition.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: buildDataAddRow(
                        title: 'Mother Tongue',
                        widget: SizedBox(),
                        data1: motherTongueController.text.isEmpty
                            ? (basicInfo.id == null ||
                                    basicInfo.motherTongue == null ||
                                    basicInfo.motherTongue!.isEmpty
                                ? 'Not Added'
                                : basicInfo.motherTongue.toString())
                            : motherTongueController.text,
                        data2:
                            StringUtils.capitalize(motherTongueController.text),
                        isControllerTextEmpty:
                            motherTongueController.text.isEmpty,
                      ),
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'City',
                              addTextField: TextFormField(
                                maxLength: 40,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller: cityController,
                                decoration:
                                    AppTFDecoration(hint: 'City').decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        widget: Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        title: 'City',
                        data1: cityController.text.isEmpty
                            ? (basicInfo.presentAddress?.city == null
                                ? 'City'
                                : basicInfo.presentAddress!.city!)
                            : cityController.text,
                        data2: StringUtils.capitalize(cityController.text),
                        isControllerTextEmpty: cityController.text.isEmpty,
                      ),
                      // child: CarRowWidget(favourites: favourites!,)
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'State',
                              addTextField: TextFormField(
                                maxLength: 40,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller: stateController,
                                decoration:
                                    AppTFDecoration(hint: 'State').decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        widget: Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        title: 'State',
                        data1: stateController.text.isEmpty
                            ? (basicInfo.presentAddress == null ||
                                    basicInfo.presentAddress!.state == null
                                ? 'State'
                                : basicInfo.presentAddress!.state!)
                            : stateController.text,
                        data2: StringUtils.capitalize(stateController.text),
                        isControllerTextEmpty: stateController.text.isEmpty,
                      ),
                      // child: CarRowWidget(favourites: favourites!,)
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'Zip Code',
                              addTextField: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 40,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller: zipController,
                                decoration: AppTFDecoration(hint: 'Zip Code')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        widget: Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        title: 'Zip Code',
                        data1: zipController.text.isEmpty
                            ? (basicInfo.presentAddress == null ||
                                    basicInfo.presentAddress!.zip == null
                                ? 'Zip Code'
                                : basicInfo.presentAddress!.zip!)
                            : zipController.text,
                        data2: zipController.text,
                        isControllerTextEmpty: zipController.text.isEmpty,
                      ),

                      // chil
                      // d: CarRowWidget(favourites: favourites!,)
                    ),
                    sizedBox16(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'Country',
                              addTextField: TextFormField(
                                maxLength: 40,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller: countryController,
                                decoration: AppTFDecoration(hint: 'Country')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      },
                      child: buildDataAddRow(
                        widget: Icon(
                          Icons.edit,
                          size: 12,
                        ),
                        title: 'Country',
                        data1: countryController.text.isEmpty
                            ? (basicInfo.presentAddress == null ||
                                    basicInfo.presentAddress!.country == null
                                ? 'Country'
                                : basicInfo.presentAddress!.country!)
                            : countryController.text,
                        data2: countryController.text,
                        isControllerTextEmpty: countryController.text.isEmpty,
                      ),
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
        child: loading
            ? loadingButton(context: context)
            : button(
                context: context,
                onTap: () {
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
                          maritalStatus: marriedStatusController.text,
                          birthDate: birthDateController.text,
                          state: stateController.text,
                          zip: zipController.text,
                          city: cityController.text,
                          country: countryController.text,
                          gender: genderController.text,
                          financialCondition: financialCondition.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                      aboutUs: aboutUs.text)
                      .then((value) {
                    setState(() {});
                    if (value['status'] == true) {
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                      dynamic message = value['message']['original']['message'];
                      List<String> errors = [];

                      if (message != null && message is Map) {
                        message.forEach((key, value) {
                          errors.addAll(value);
                        });
                      }

                      String errorMessage = errors.isNotEmpty
                          ? errors.join(", ")
                          : "Update succesfully.";
                      Fluttertoast.showToast(msg: errorMessage);
                    } else {
                      setState(() {
                        loading = false;
                      });
                      List<dynamic> errors =
                          value['message']['original']['message'];
                      String errorMessage = errors.isNotEmpty
                          ? errors[0]
                          : "An unknown error occurred.";
                      Fluttertoast.showToast(msg: errorMessage);
                    }
                  });
                },
                title: "Save"),
      ),
    );
  }

  Row buildDataAddRow({
    required String title,
    required String data1,
    required String data2,
    required bool isControllerTextEmpty,
    required Widget widget,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                title,
              ),
              const SizedBox(
                width: 3,
              ),
              widget,
            ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            data1,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Expanded(
                child: SizedBox(
                  width: 180,
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
        "Basic Info",
        style: styleSatoshiBold(size: 18, color: Colors.black),
      ),
    );
  }
}

class PrivacyStatusBottomSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const PrivacyStatusBottomSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<PrivacyStatusBottomSheet> createState() => _PrivacyStatusBottomSheet();
}

class _PrivacyStatusBottomSheet extends State<PrivacyStatusBottomSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Smoking Status",
                  style: styleSatoshiMedium(size: 16, color: Colors.black),
                ),
                sizedBox16(),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 0;
                    Navigator.of(context).pop();
                    widget.onPop("1");
                  }),
                  child: Container(
                    height: 44,
                    width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 0 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                      'Yes',
                      style: styleSatoshiLight(
                          size: 14,
                          color: _gIndex == 0 ? Colors.white : Colors.black),
                      // style: _gIndex == 0
                      //     ? textColorF7E64114w400
                      //     : ColorSelect.colorF7E641
                    )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 1;
                    Navigator.of(context).pop();
                    widget.onPop("0");
                  }),
                  child: Container(
                    height: 44,
                    width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 1 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                      'No',
                      style: styleSatoshiLight(
                          size: 14,
                          color: _gIndex == 1 ? Colors.white : Colors.black),
                      // style
                      // : _gIndex == 1
                      //     ? kManRope_500_16_white
                      //     : kManRope_500_16_626A6A,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.privacyStatus == "1") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "0") {
      _gIndex = 1;
    }
    super.initState();
  }
}

class DrinkingStatusBottomSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const DrinkingStatusBottomSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<DrinkingStatusBottomSheet> createState() =>
      _DrinkingStatusBottomSheet();
}

class _DrinkingStatusBottomSheet extends State<DrinkingStatusBottomSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Drinking Status",
                  style: styleSatoshiMedium(size: 16, color: Colors.black),
                ),
                sizedBox16(),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 0;
                    Navigator.of(context).pop();
                    widget.onPop("1");
                  }),
                  child: Container(
                    height: 44,
                    width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 0 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                      'Yes',
                      style: styleSatoshiLight(
                          size: 14,
                          color: _gIndex == 0 ? Colors.white : Colors.black),
                      // style: _gIndex == 0
                      //     ? textColorF7E64114w400
                      //     : ColorSelect.colorF7E641
                    )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 1;
                    Navigator.of(context).pop();
                    widget.onPop("0");
                  }),
                  child: Container(
                    height: 44,
                    width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 1 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                      'No',
                      style: styleSatoshiLight(
                          size: 14,
                          color: _gIndex == 1 ? Colors.white : Colors.black),
                      // style
                      // : _gIndex == 1
                      //     ? kManRope_500_16_white
                      //     : kManRope_500_16_626A6A,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.privacyStatus == "1") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "0") {
      _gIndex = 1;
    }
    super.initState();
  }
}
