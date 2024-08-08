import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/data/response/profile_model.dart';
import 'package:bureau_couple/getx/features/widgets/custom_dropdown_button_field.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/models/profie_model.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/views/signup/sign_up_screen_before_three.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import '../../../apis/partner_expectation_api.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../apis/profile_apis/physical_attributes_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/attributes_model.dart';
import '../../../models/preference_model.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/customAppbar.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'edit_basic_info.dart';
class EditPreferenceScreen extends StatefulWidget {
  const EditPreferenceScreen({super.key});

  @override
  State<EditPreferenceScreen> createState() => _EditPreferenceScreenState();
}

class _EditPreferenceScreenState extends State<EditPreferenceScreen> {
  final generalInfo = TextEditingController();
  final countryController = TextEditingController();
  final heightController = TextEditingController();
  final maxHeightController = TextEditingController();
  // final weightController = TextEditingController();
  final preferredReligionController = TextEditingController();
  final minAgeController = TextEditingController();
  final maxAgeController = TextEditingController();
  final preferredProfession = TextEditingController();
  final financialCondition = TextEditingController();
  final motherTongueController = TextEditingController();
  final communityController = TextEditingController();
  final minimumDegreeController = TextEditingController();
  final smokingController = TextEditingController();
  final drinkingController = TextEditingController();
  final languageController = TextEditingController();

  bool loading = false;
  bool isLoading = false;

  @override
  void initState() {
    careerInfo();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getReligionsList();
      Get.find<AuthController>().getCommunityList();
      Get.find<AuthController>().getMotherTongueList();
      Get.find<AuthController>().getProfessionList();
      Get.find<AuthController>().getSmokingList();
      Get.find<AuthController>().getDrinkingList();

    });
  }


  PartnerExpectation preferenceModel = PartnerExpectation();

  careerInfo() {
    isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
      // physicalData.clear();
      if (value['status'] == true) {
        setState(() {
          var physicalAttributesData = value['data']['user']['partner_expectation'];
          if (physicalAttributesData != null) {
            setState(() {
              preferenceModel = PartnerExpectation.fromJson(physicalAttributesData);
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
   generalInfo.text = preferenceModel.generalRequirement.toString() ?? '';
   countryController.text= preferenceModel.country?.toString() ?? '';
    minAgeController.text= preferenceModel.minAge?.toString() ?? '';
     maxAgeController.text= preferenceModel.maxAge?.toString() ?? '';
     heightController.text= preferenceModel.minHeight?.toString() ?? '';
   maxHeightController.text= preferenceModel.maxHeight?.toString() ?? '';
   // weightController.text= preferenceModel.maxWeight.toString() ?? '';
    preferredReligionController.text= preferenceModel.religionName.toString() ?? '';
    communityController.text= preferenceModel.communityName.toString() ?? '';
   //  smokingController.text= preferenceModel.smoking?.name?.toString() ?? '';
   // drinkingController.text= preferenceModel.drinking?.name?.toString() ?? '';
     preferredProfession.text= preferenceModel.professionName.toString() ?? '';
    minimumDegreeController.text= preferenceModel.minDegree?.toString() ?? '';
    // financialCondition.text= preferenceModel.financialCondition?.toString() ?? '';
    // languageController.text= preferenceModel.language.toString() ?? '';
  }

  DateTime _selectedTime = DateTime.now();
  String time = "-";

  int _feet = 5;
  int _inches = 0;

  int _feet2 = 5;
  int _inches2 = 0;



  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControl) {
      return  Scaffold(
        appBar: const CustomAppBar(title: "Partner Expectation",),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child:
            loading ?
            loadingButton(context: context) :button(context: context, onTap: () {
              setState(() {
                loading = true;
              });
              partnerExpectationUpdateApi(
                  generalRequirement: generalInfo.text,
                  country: countryController.text,
                  minAge: minAgeController.text,
                  maxAge: maxAgeController.text,
                  minHeight: heightController.text,
                  maxWeight: '',
                  religion: authControl.partnerReligion.toString(),
                  community: authControl.communityMainIndex.toString(),
                  smokingStatus: authControl.smokingIndex.toString(),
                  drinkingStatus: authControl.drikingIndex.toString(),
                  profession: authControl.partnerProfession.toString(),
                  minDegree: minimumDegreeController.text,
                  financialCondition: financialCondition.text,
                  language: languageController.text,
                  maxHeight: maxHeightController.text,
                  motherTongue:authControl.partnerMotherTongue.toString()).then((value) {
                setState(() {
                });
                if (value['status'] == true) {
                  setState(() {
                    loading = false;
                  });
                  Navigator.pop(context);
                  // dynamic message = value['message']['original']['message'];
                  // List<String> errors = [];
                  //
                  // if (message != null && message is Map) {
                  //   // If the message is not null and is a Map, extract the error messages
                  //   message.forEach((key, value) {
                  //     errors.addAll(value);
                  //   });
                  // }

                  // String errorMessage = errors.isNotEmpty ? errors.join(", ") : "Update succesfully.";
                  // Fluttertoast.showToast(msg: errorMessage);

                } else {
                  setState(() {
                    loading = false;
                  });
                  Fluttertoast.showToast(msg: "Add All Details");
                }
              });
            },  title: "Save"),
          ),
        ),
        body: isLoading ? const AttributesShimmerWidget() : CustomRefreshIndicator(
          onRefresh: () {
            setState(() {
              isLoading = true;
            });
            return careerInfo();
          },
          child: SingleChildScrollView(
            physics: const  AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Partner Expectations",style:styleSatoshiMedium(size: 16, color: primaryColor)),
                  sizedBox16(),
                  // GestureDetector(
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return NameEditDialogWidget(
                  //           title: 'General Introduction',
                  //           addTextField: TextFormField(
                  //             maxLength: 200,
                  //             onChanged: (v) {
                  //               setState(() {});
                  //             },
                  //             onEditingComplete: () {
                  //               Navigator.pop(context); // Close the dialog
                  //             },
                  //             controller: generalInfo,
                  //             decoration: AppTFDecoration(hint: 'General Introduction')
                  //                 .decoration(),
                  //             //keyboardType: TextInputType.phone,
                  //           ),
                  //         );
                  //       },
                  //     );
                  //
                  //   },
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Text(
                  //             "General Information",style: styleSatoshiRegular(size: 14, color: color5E5E5E),
                  //           ),
                  //           const SizedBox(width: 3,),
                  //           const Icon(
                  //             Icons.edit,
                  //             size: 12,
                  //           ),
                  //         ],
                  //       ),
                  //       generalInfo.text.isEmpty?
                  //       const SizedBox() :
                  //       Column(
                  //         children: [
                  //           sizedBox16(),
                  //
                  //           Text(
                  //               generalInfo.text.isEmpty
                  //                   ? (preferenceModel.id == null || preferenceModel.generalRequirement == null
                  //                   ? 'Not Added'
                  //                   : generalInfo.text)
                  //                   : generalInfo.text,
                  //             maxLines: 4,
                  //             overflow: TextOverflow.ellipsis,
                  //           ),
                  //
                  //         ],
                  //       )
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                  sizedBox10(),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(SingleChildScrollView(child: Container(
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox20(),
                            Text(
                              'Age Bracket',
                              style: kManrope25Black.copyWith(fontSize: 16),
                            ),
                            sizedBox12(),
                            Obx(() => SizedBox(
                              width: double.infinity,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          // Text("Min Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                          Text('${authControl.startValue.value.round().toString()} yrs',
                                            style:satoshiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                                color: Theme.of(context).primaryColor),),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          // Text("Max Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                          Text('${authControl.endValue.value.round().toString()} yrs',
                                            style:satoshiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                                color: Theme.of(context).primaryColor),),
                                        ],
                                      ),
                                    ],),
                                  RangeSlider(
                                    min: 20.0,
                                    max: 50.0,
                                    divisions: 30,
                                    labels: RangeLabels(
                                      authControl.startValue.value.round().toString(),
                                      authControl.endValue.value.round().toString(),
                                    ),
                                    values: RangeValues(
                                      authControl.startValue.value,
                                      authControl.endValue.value,
                                    ),
                                    onChanged: (values) {
                                      authControl.setAgeValue(values);
                                      minAgeController.text = authControl.startValue.value.round().toString();
                                      maxAgeController.text = authControl.endValue.value.round().toString();
                                    },
                                  ),
                                ],
                              ),
                            ),)

                          ],
                        ),
                      ),));
                    },
                    child: buildDataAddRow(title: 'Min Age',
                      data1: minAgeController.text.isEmpty
                          ? (preferenceModel.id == null || preferenceModel.minAge == null
                          ? 'Not Added'
                          : preferenceModel.minAge.toString())
                          : minAgeController.text,
                      data2: StringUtils.capitalize('${minAgeController.text} Yrs'),
                      isControllerTextEmpty: minAgeController.text.isEmpty,
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),),
                  ),
                  sizedBox10(),
                  const Divider(),
                  sizedBox10(),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(SingleChildScrollView(child: Container(
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox20(),
                            Text(
                              'Age Bracket',
                              style: kManrope25Black.copyWith(fontSize: 16),
                            ),
                            sizedBox12(),
                            Obx(() => SizedBox(
                              width: double.infinity,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          // Text("Min Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                          Text('${authControl.startValue.value.round().toString()} yrs',
                                            style:satoshiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                                color: Theme.of(context).primaryColor),),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          // Text("Max Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                          Text('${authControl.endValue.value.round().toString()} yrs',
                                            style:satoshiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                                color: Theme.of(context).primaryColor),),
                                        ],
                                      ),
                                    ],),
                                  RangeSlider(
                                    min: 20.0,
                                    max: 50.0,
                                    divisions: 30,
                                    labels: RangeLabels(
                                      authControl.startValue.value.round().toString(),
                                      authControl.endValue.value.round().toString(),
                                    ),
                                    values: RangeValues(
                                      authControl.startValue.value,
                                      authControl.endValue.value,
                                    ),
                                    onChanged: (values) {
                                      authControl.setAgeValue(values);
                                      minAgeController.text = authControl.startValue.value.round().toString();
                                      maxAgeController.text = authControl.endValue.value.round().toString();
                                    },
                                  ),
                                ],
                              ),
                            ),)

                          ],
                        ),
                      ),));
                    },
                    child: buildDataAddRow(title: 'Max Age',
                      data1: maxAgeController.text.isEmpty
                          ? (preferenceModel.id == null || preferenceModel.maxAge == null
                          ? 'Not Added'
                          : preferenceModel.maxAge.toString())
                          : maxAgeController.text,
                      data2: StringUtils.capitalize('${maxAgeController.text} Yrs'),
                      isControllerTextEmpty: maxAgeController.text.isEmpty,
                      widget: const Icon(Icons.edit, size: 12,),),
                  ),
                  // const Divider(),
                  // GestureDetector(
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return NameEditDialogWidget(
                  //           title: 'Max Age',
                  //           addTextField: TextFormField(
                  //             maxLength: 40,
                  //             onChanged: (v) {
                  //               setState(() {
                  //               });
                  //             },
                  //             onEditingComplete: () {
                  //               Navigator.pop(context); // Close the dialog
                  //             },
                  //             controller: maxAgeController,
                  //             decoration: AppTFDecoration(
                  //                 hint: 'Max Age').decoration(),
                  //             //keyboardType: TextInputType.phone,
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  //   child: buildDataAddRow(title: 'Max Age',
                  //     data1: maxAgeController.text.isEmpty
                  //         ? (preferenceModel.id == null || preferenceModel.maxAge == null
                  //         ? 'Not Added'
                  //         : preferenceModel.maxAge.toString())
                  //         : maxAgeController.text,
                  //     data2: StringUtils.capitalize(maxAgeController.text),
                  //     isControllerTextEmpty: maxAgeController.text.isEmpty, widget: const SizedBox(),),
                  // ),
                  sizedBox10(),
                  const Divider(),
                  sizedBox10(),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(SingleChildScrollView(child: Container(
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox20(),
                            Text(
                              'Height Bracket',
                              style: kManrope25Black.copyWith(fontSize: 16),
                            ),
                            sizedBox12(),
                            Obx(() => SizedBox(
                              width: double.infinity,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          // Text("Min Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                          Text('${authControl.startHeightValue.value.round().toString()} ft',
                                            style:satoshiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                                color: Theme.of(context).primaryColor),),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          // Text("Max Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                          Text('${authControl.endHeightValue.value.round().toString()} ft',
                                            style:satoshiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                                color: Theme.of(context).primaryColor),),
                                        ],
                                      ),
                                    ],),
                                  Container(
                                    width: double.infinity,
                                    child: Obx(() => RangeSlider(
                                      min: 5.0, // Minimum value
                                      max: 7.0, // Maximum value
                                      divisions: 20, // Number of divisions for finer granularity
                                      labels: RangeLabels(
                                        authControl.startHeightValue.value.toStringAsFixed(1), // Format to 1 decimal place
                                        authControl.endHeightValue.value.toStringAsFixed(1), // Format to 1 decimal place
                                      ),
                                      values: RangeValues(
                                        authControl.startHeightValue.value,
                                        authControl.endHeightValue.value,
                                      ),
                                      onChanged: (values) {
                                        authControl.setHeightValue(values);
                                        heightController.text =  authControl.startHeightValue.value.toStringAsFixed(1);
                                        maxHeightController.text =  authControl.endHeightValue.value.toStringAsFixed(1);
                                      },
                                    )),
                                  ),
                                ],
                              ),
                            ),)

                          ],
                        ),
                      ),));
                    },
                    child: buildDataAddRow(title: 'Min Height ',
                        data1: heightController.text.isEmpty
                            ? (preferenceModel.id == null || preferenceModel.minHeight == null || preferenceModel.minHeight!.isEmpty
                            ? 'Not Added'
                            : preferenceModel.minHeight.toString())
                            : heightController.text,
                        data2: Get.find<ProfileController>().convertHeightToFeetInches(heightController.text),
                        isControllerTextEmpty: heightController.text.isEmpty, widget: const Icon(Icons.edit, size: 12,),),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox10(),
                  const Divider(),
                  sizedBox10(),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(SingleChildScrollView(child: Container(
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox20(),
                            Text(
                              'Height Bracket',
                              style: kManrope25Black.copyWith(fontSize: 16),
                            ),
                            sizedBox12(),
                            Obx(() => SizedBox(
                              width: double.infinity,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          // Text("Min Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                          Text('${authControl.startHeightValue.value.round().toString()} ft',
                                            style:satoshiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                                color: Theme.of(context).primaryColor),),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          // Text("Max Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                          Text('${authControl.endHeightValue.value.round().toString()} ft',
                                            style:satoshiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                                color: Theme.of(context).primaryColor),),
                                        ],
                                      ),
                                    ],),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Obx(() => RangeSlider(
                                      min: 5.0, // Minimum value
                                      max: 7.0, // Maximum value
                                      divisions: 20, // Number of divisions for finer granularity
                                      labels: RangeLabels(
                                        authControl.startHeightValue.value.toStringAsFixed(1), // Format to 1 decimal place
                                        authControl.endHeightValue.value.toStringAsFixed(1), // Format to 1 decimal place
                                      ),
                                      values: RangeValues(
                                        authControl.startHeightValue.value,
                                        authControl.endHeightValue.value,
                                      ),
                                      onChanged: (values) {
                                        authControl.setHeightValue(values);
                                        heightController.text =  authControl.startHeightValue.value.toStringAsFixed(1);
                                        maxHeightController.text =  authControl.endHeightValue.value.toStringAsFixed(1);
                                      },
                                    )),
                                  ),
                                ],
                              ),
                            ),)

                          ],
                        ),
                      ),));
                      },
                    child: buildDataAddRow(title: 'Max Height ',
                        data1: maxHeightController.text.isEmpty
                            ? (preferenceModel.id == null || preferenceModel.minHeight == null || preferenceModel.minHeight!.isEmpty
                            ? 'Not Added'
                            : preferenceModel.minHeight.toString())
                            : maxHeightController.text,
                        data2: Get.find<ProfileController>().convertHeightToFeetInches(maxHeightController.text),
                        isControllerTextEmpty: maxHeightController.text.isEmpty,
                      widget: const Icon(Icons.edit, size: 12,),),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox10(),
                  const Divider(),
                  sizedBox10(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.bottomSheet(SingleChildScrollView(child: Container(
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                            'Preferred Religion',
                            style: kManrope25Black.copyWith(fontSize: 16),
                          ),
                          sizedBox12(),
                          CustomDropdownButtonFormField<String>(
                            value: authControl.partReligionList!.firstWhere((religion) => religion.id == authControl.partnerReligion).name,// Assuming you have a selectedPosition variable
                            items: authControl.partReligionList!.map((position) => position.name!).toList(),
                            hintText: "Select Religion",
                            onChanged: (String? value) {
                              if (value != null) {
                                var selected = authControl.partReligionList!.firstWhere((position) => position.name == value);
                                authControl.setPartnerReligion(selected.id!);
                                preferredReligionController.text = selected.name.toString();
                                // authControl.setPartnerReligion(selected.id!);
                                // print(authControl.partnerReligion);
                              }
                            },
                          ),


                        ],),
                      ),));
                    },
                    child: buildDataAddRow(
                      title: 'Preferred Religion',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: preferredReligionController.text.isEmpty
                          ? (preferenceModel.id == null ||
                          preferenceModel.religion == null
                          ? 'Not Added'
                          : preferenceModel.religionName.toString())
                          : preferredReligionController.text,
                      data2: preferredReligionController.text,
                      isControllerTextEmpty: preferredReligionController.text.isEmpty,
                    ),
                  ),
                  sizedBox10(),
                  const Divider(),
                  sizedBox10(),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(SingleChildScrollView(child: Container(
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Preferred Profession',
                              style: kManrope25Black.copyWith(fontSize: 16),
                            ),
                            sizedBox12(),
                            CustomDropdownButtonFormField<String>(
                              value: authControl.partProfessionList!.firstWhere((religion) => religion.id == authControl.partnerProfession).name,// Assuming you have a selectedPosition variable
                              items: authControl.partProfessionList!.map((position) => position.name!).toList(),
                              hintText: "Select Profession",
                              onChanged: (String? value) {
                                if (value != null) {
                                  var selected = authControl.partProfessionList!.firstWhere((position) => position.name == value);
                                  authControl.setPartnerProfession(selected.id!);
                                  preferredProfession.text = selected.name.toString();
                                }
                              },
                            ),
                          ],),
                      ),));
                    },
                    child: buildDataAddRow(
                      title: 'Preferred Profession',
                      data1: preferredProfession.text.isEmpty
                          ? (preferenceModel.id == null || preferenceModel.profession == null || preferenceModel.professionName!.isEmpty
                          ? 'Not Added'
                          : preferenceModel.professionName.toString())
                          : preferredProfession.text,
                      data2: StringUtils.capitalize(preferredProfession.text),
                      isControllerTextEmpty: preferredProfession.text.isEmpty,
                      widget: const Icon(Icons.edit, size: 12,),
                    ),),
                  sizedBox10(),
                  const Divider(),
                  sizedBox10(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.bottomSheet(SingleChildScrollView(child: Container(
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Preferred Mother Tongue',
                              style: kManrope25Black.copyWith(fontSize: 16),
                            ),
                            sizedBox12(),
                            CustomDropdownButtonFormField<String>(
                              value: authControl.partMotherTongueList!.firstWhere((religion) => religion.id == authControl.partnerMotherTongue).name,// Assuming you have a selectedPosition variable
                              items: authControl.partMotherTongueList!.map((position) => position.name!).toList(),
                              hintText: "Select Mother Tongue",
                              onChanged: (String? value) {
                                if (value != null) {
                                  var selected = authControl.partMotherTongueList!.firstWhere((position) => position.name == value);
                                  authControl.setPartnerMotherTongue(selected.id!);
                                  motherTongueController.text = selected.name.toString();
                                }
                              },
                            ),
                          ],),
                      ),));

                    },
                    child: buildDataAddRow(
                      title: 'Mother Tongue',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: motherTongueController.text.isEmpty
                          ? (preferenceModel.id == null ||
                          preferenceModel.motherTongue == null
                          ? 'Not Added'
                          : preferenceModel.motherTongueName.toString())
                          : motherTongueController.text,
                      data2: motherTongueController.text,
                      isControllerTextEmpty: motherTongueController.text.isEmpty,
                    ),
                  ),
                  sizedBox10(),
                  const Divider(),
                  sizedBox10(),



                ],
              ),
            ),
          ),
        ),
      );
    } );

  }

  String removeBrackets(String text) {
    return text.replaceAll(RegExp(r'\[|\]'), '');
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
               title, style: styleSatoshiRegular(size: 14, color: color5E5E5E),
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
      title: Text("Edit Partner Expectation",
        style: styleSatoshiBold(size: 18, color: Colors.black),
      ),
    );
  }
}


class AttributesShimmerWidget extends StatelessWidget {
  const AttributesShimmerWidget({super.key});

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


class FinancialBottomSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const FinancialBottomSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<FinancialBottomSheet> createState() => _FinancialBottomSheet();
}

class _FinancialBottomSheet extends State<FinancialBottomSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: GetBuilder<AuthController>(builder: (authControl) {
          return  Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Financial Condition",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ChipList(
                        elements: authControl.financialConditionList,
                        onChipSelected: (selectedFinancialCondition) {
                          print(selectedFinancialCondition);
                          widget.onPop(selectedFinancialCondition);
                          // authControl.setFinancialCondition(
                          //     selectedGender == "Male" ? "M" : selectedGender == "Female" ? "F" : "O"
                          // );
                          // setState(() {
                          //
                          //   // SharedPrefs().setGender(selectedGender);
                          //   // SharedPrefs().getGender();
                          // });
                        },
                        defaultSelected: "Male",
                      ),),
                  ),
                ],
              ),
            ),
          );
    }



      ),
    ),);
  }

  @override
  void initState() {
    if (widget.privacyStatus == "Below 3 lacs") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "4-8 lacs") {
      _gIndex = 1;
    }
    else if (widget.privacyStatus == "Above 8 lacs") {
      _gIndex = 2;
    }
    super.initState();
  }
}


class ReligionSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const ReligionSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<ReligionSheet> createState() => _ReligionSheet();
}

class _ReligionSheet extends State<ReligionSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: GetBuilder<AuthController>(builder: (authControl) {
          return Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Religion",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 12,),
                  Wrap(
                    spacing: 8.0,
                    children: authControl.religionList!.map((religion) {
                      return ChoiceChip(
                        selectedColor: color4B164C.withOpacity(0.80),
                        backgroundColor: Colors.white,
                        label: Text(
                          religion.name!,
                          style: TextStyle(
                            color: authControl.religionMainIndex == religion.id
                                ? Colors.white
                                : Colors.black.withOpacity(0.80),
                          ),
                        ),
                        selected: authControl.religionMainIndex == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            authControl.setReligionMainIndex(religion.id, true);
                            widget.onPop(religion.name!); // Call the callback with the selected religion name
                            Navigator.pop(context); // Close the sheet
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        } )



      ),
    );
  }

}




class MotherTongueSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const MotherTongueSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<MotherTongueSheet> createState() => _MotherTongueSheet();
}

class _MotherTongueSheet extends State<MotherTongueSheet> {
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
                  "Select Mother Tongue",
                  style: styleSatoshiMedium(size: 16, color: Colors.black),
                ),
                sizedBox16(),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 0;
                    Navigator.of(context).pop();
                    widget.onPop("Hindi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 0 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Hindi',
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
                    widget.onPop("Bhojpuri");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 1 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Bhojpuri',
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
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 2;
                    Navigator.of(context).pop();
                    widget.onPop("Marathi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 2 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Marathi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 2 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 3;
                    Navigator.of(context).pop();
                    widget.onPop("Bengali");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 3 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Bengali',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 3 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 4;
                    Navigator.of(context).pop();
                    widget.onPop("Odia");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 4 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Odia',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 4 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 5;
                    Navigator.of(context).pop();
                    widget.onPop("Gujarati");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 5 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Gujarati',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 5 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 6;
                    Navigator.of(context).pop();
                    widget.onPop("Punjabi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 6 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Punjabi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 6 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 7;
                    Navigator.of(context).pop();
                    widget.onPop("Urdu");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 7 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Urdu',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 7 ? Colors.white : Colors.black),
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
    if (widget.privacyStatus == "Hindi") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "Bhojpuri") {
      _gIndex = 1;
    }
    else if (widget.privacyStatus == "Marathi") {
      _gIndex = 2;
    } else if (widget.privacyStatus == "Bengali") {
      _gIndex = 3;
    }  else if (widget.privacyStatus == "Odia") {
      _gIndex = 4;
    } else if (widget.privacyStatus == "Gujarati") {
      _gIndex = 5;
    } else if (widget.privacyStatus == "Punjabi") {
      _gIndex = 6;
    }  else if (widget.privacyStatus == "Urdu") {
      _gIndex = 7;
    }
    super.initState();
  }
}

class CommuitySheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const CommuitySheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<CommuitySheet> createState() => _CommuitySheet();
}

class _CommuitySheet extends State<CommuitySheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: GetBuilder<AuthController>(builder: (authControl) {
          return  Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Caste",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 12,),

                  Wrap(
                    spacing: 8.0, // Adjust spacing as needed
                    children: authControl.communityList!.map((religion) {
                      return ChoiceChip(
                        selectedColor: color4B164C.withOpacity(0.80),
                        backgroundColor: Colors.white,

                        label: Text(religion.name! ,style: TextStyle(color: authControl.communityMainIndex == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                        selected: authControl.communityMainIndex == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            authControl.setCommunityMainListIndex(religion.id, true);
                            widget.onPop(religion.name!); // Call the callback with the selected religion name
                            Navigator.pop(context);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  // Text(
                  //   "Select Community",
                  //   style: styleSatoshiMedium(size: 16, color: Colors.black),
                  // ),
                  // sizedBox16(),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 0;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Brahmin");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 0 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Brahmin',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 0 ? Colors.white : Colors.black),
                  //           // style: _gIndex == 0
                  //           //     ? textColorF7E64114w400
                  //           //     : ColorSelect.colorF7E641
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 1;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Rajput");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 1 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Rajput',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 1 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 2;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Kamma");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 2 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Kamma',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 2 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 3;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Yadav");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 3 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Yadav',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 3 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 4;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Gupta");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 4 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Gupta',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 4 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 5;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Muslim");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 5 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Muslim',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 5 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 6;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Sikh");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 6 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Sikh',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 6 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 7;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Punjabi");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 7 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Punjabi',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 7 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 8;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Aggarwal");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 8 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Aggarwal',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 8 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 9;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Muslim");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 9 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Muslim',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 9 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 10;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Marathi");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 10 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Marathi',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 10 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),


                ],
              ),
            ),
          );
        }),



      ),
    );
  }

}

class PositionBottomSheet extends StatelessWidget {
  final Function(String) onPop;
  final Function(String)? onPopId;
  const PositionBottomSheet({super.key, required this.onPop, this.onPopId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControl) {
      return SingleChildScrollView(
        child: Container(color: Theme.of(context).cardColor,
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Profession",
                  textAlign: TextAlign.left,
                  style: styleSatoshiBold(size: 16, color: Colors.black),),
              ),
              const SizedBox(height: 5,),
              Wrap(
                spacing: 8.0,
                children: authControl.positionHeldList!.map((religion) {
                  return ChoiceChip(
                    selectedColor: color4B164C.withOpacity(0.80),
                    backgroundColor: Colors.white,
                    label: Text(
                      religion.name!,
                      style: TextStyle(
                        color: authControl.positionHeldIndex == religion.id
                            ? Colors.white
                            : Colors.black.withOpacity(0.80),
                      ),
                    ),
                    selected: authControl.positionHeldIndex == religion.id,
                    onSelected: (selected) {
                      if (selected) {
                        authControl.setPositionIndex(religion.id, true);
                        onPop(religion.name!);
                        onPopId!(religion.id.toString());

                        Navigator.pop(context);
                      }
                    },
                  );
                }).toList(),
              ),


              ],
            ),
          ),
      );
    });
  }
}

class MotherTongueBottomSheet extends StatelessWidget {
  final Function(String) onPop;
  const MotherTongueBottomSheet({super.key, required this.onPop});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControl) {
      return SingleChildScrollView(
        child: Container(color: Theme.of(context).cardColor,
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(children: [
            sizedBox20(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Mother Tongue",
                textAlign: TextAlign.left,
                style: styleSatoshiBold(size: 16, color: Colors.black),),
            ),
            const SizedBox(height: 12,),
            Wrap(
              spacing: 8.0, // Adjust spacing as needed
              children: authControl.motherTongueList!.map((religion) {
                return ChoiceChip(
                  selectedColor: color4B164C.withOpacity(0.80),
                  backgroundColor: Colors.white,

                  label: Text(religion.name! ,style: TextStyle(color: authControl.motherTongueIndex == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                  selected: authControl.motherTongueIndex == religion.id,
                  onSelected: (selected) {
                    if (selected) {
                      authControl.setMotherTongueIndex(religion.id, true);
                      onPop(religion.name!); // Call the callback with the selected religion name
                      Navigator.pop(context);
                    }
                  },
                );
              }).toList(),
            ),


          ],
          ),
        ),
      );
    });
  }
}