
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_height_picker.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/widgets/dropdown_buttons.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
class SignUpScreenExpectationScreen extends StatefulWidget {

  const SignUpScreenExpectationScreen({super.key,});

  @override
  State<SignUpScreenExpectationScreen> createState() => _SignUpScreenExpectationScreenState();
  static final GlobalKey<FormState> _formKey8 = GlobalKey<FormState>();
  bool validate() {
    return _formKey8.currentState?.validate() ?? false;
  }
}

class _SignUpScreenExpectationScreenState extends State<SignUpScreenExpectationScreen> {

  final minHeightController = TextEditingController();
  final maxHeightController = TextEditingController();
  final minAgeController = TextEditingController();
  final maxAgeController = TextEditingController();

  @override
  void initState() {
    fields();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getProfessionList();
      Get.find<AuthController>().getPositionHeldList();
      Get.find<AuthController>().getCommunityList();
      Get.find<AuthController>().getSmokingList();
      Get.find<AuthController>().getDrinkingList();
      fields();
      // Get.find<AuthController>().clearStateDistrict();

      // Get.find<AuthController>().getMotherTongueList();

    });

  }


  void fields() {
    minAgeController.text = Get.find<AuthController>().partnerMinAge ?? '';
    maxAgeController.text = Get.find<AuthController>().partnerMaxAge ?? '';
    minHeightController.text = Get.find<AuthController>().partnerMinHeight ?? '';
    maxHeightController.text = Get.find<AuthController>().partnerMaxHeight ?? '';
  }





  String? cadarValue;
  String cadarFilter = '';







  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (authControl) {
          // startDateController.text =  authControl.from == null ? "" : authControl.from.toString();
          // endDateController.text =  authControl.to == null ? "" : authControl.to.toString();
          // startBatchYearController.text =  authControl.batchFromString;
          // endBatchController.text = authControl.batchToString;
          return authControl.partProfessionList == null || authControl.partProfessionList!.isEmpty ||
              authControl.partPositionHeldList == null || authControl.partPositionHeldList!.isEmpty ||
              authControl.smokingList == null || authControl.smokingList!.isEmpty ||
              authControl.drikingList == null || authControl.drikingList!.isEmpty ?
          const Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            child: Form(key: SignUpScreenExpectationScreen._formKey8,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox20(),
                    Center(
                      child: Container(
                        height: 104,
                        width: 104,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          icPartnerRegister,
                        ),
                      ),
                    ),
                    sizedBox20(),
                    // sizedBox12(),
                    Center(
                      child: Text("All Done Now Let's Add Partner Preference",
                        textAlign: TextAlign.center,
                        style: kManrope14Medium626262.copyWith(color: Colors.black),
                      ),
                    ),
                    sizedBox20(),

                    Text(
                      'Religion',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomStyledDropdownButton(
                      items: authControl.partReligionList!.map((religion) => religion.name!).toList(),
                      onChanged: (value) {
                        var selectedReligion = authControl.partReligionList!.firstWhere((religion) => religion.name == value);
                        authControl.setPartnerReligion(selectedReligion.id!);
                        print(authControl.partnerReligion);
                      },
                      title: "Select Religion",
                      selectedValue: authControl.partReligionList!.firstWhere((religion) => religion.id == authControl.partnerReligion ).name,
                    ),

                    sizedBox20(),
                    Text(
                      'Mother Tongue',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomStyledDropdownButton(
                      items: authControl.partMotherTongueList!.map((religion) => religion.name!).toList(),
                      onChanged: (value) {
                        var selected = authControl.partMotherTongueList!.firstWhere((religion) => religion.name == value);
                        authControl.setPartnerMotherTongue(selected.id!);
                        print( authControl.partnerMotherTongue);
                      },
                      title: "Mother Tongue",
                      selectedValue: authControl.partMotherTongueList!.firstWhere((religion) => religion.id == authControl.partnerMotherTongue ).name,
                    ),
                    sizedBox20(),
                    Text(
                      'Community',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomStyledDropdownButton(
                      items: authControl.partCommunityList!.map((religion) => religion.name!).toList(),
                      onChanged: (value) {
                        var selected = authControl.partCommunityList!.firstWhere((religion) => religion.name == value);
                        authControl.setPartnerCommunity(selected.id!);
                        print(authControl.partnerCommunity);
                      },
                      title: "Community",
                      selectedValue: authControl.partCommunityList!.firstWhere((religion) => religion.id == authControl.partnerCommunity  ).name,
                    ),
                    sizedBox20(),
                    Text(
                      'Profession ',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomStyledDropdownButton(
                      items: authControl.partProfessionList!.map((religion) => religion.name!).toList(),
                      onChanged: (value) {
                        var selected = authControl.partProfessionList!.firstWhere((religion) => religion.name == value);
                        authControl.setPartnerProfession(selected.id!);
                        print(authControl.partnerProfession );
                      },
                      title: "Community",
                      selectedValue: authControl.partProfessionList!.firstWhere((religion) => religion.id == authControl.partnerProfession   ).name,
                    ),
                    sizedBox20(),
                    Text(
                      'Position',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomStyledDropdownButton(
                      items: authControl.partPositionHeldList!.map((religion) => religion.name!).toList(),
                      onChanged: (value) {
                        var selected = authControl.partPositionHeldList!.firstWhere((religion) => religion.name == value);
                        authControl.setPartnerPosition(selected.id!);
                        print(authControl.partnerPosition);
                      },
                      title: "Community",
                      selectedValue: authControl.partPositionHeldList!.firstWhere((religion) => religion.id == authControl.partnerPosition    ).name,
                    ),
                    sizedBox20(),
                    Text(
                      'Preferred Age',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text("Min Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                    //           const SizedBox(height: 5), //
                    //           CustomTextField(   inputType: TextInputType.number,
                    //             controller: minAgeController,
                    //             validation: (value) {
                    //               if (value == null || value.isEmpty) {
                    //                 return 'Add Min Age';
                    //               }
                    //               return null;
                    //             },
                    //             hintText: 'Min Age',showTitle: false,
                    //             onChanged: (val) {
                    //               authControl.setPartnerMinAge(val);
                    //               print(authControl.partnerMinAge);
                    //             },
                    //
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     sizedBoxW10(),
                    //     Expanded(
                    //       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text("Max Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                    //           const SizedBox(height: 5),
                    //           CustomTextField(
                    //             inputType: TextInputType.number,
                    //             controller:maxAgeController ,
                    //             validation: (value) {
                    //               if (value == null || value.isEmpty) {
                    //                 return 'Add Max Age';
                    //               }
                    //               return null;
                    //             },
                    //             hintText: 'Max Age',showTitle: false,
                    //             onChanged: (val) {
                    //               authControl.setPartnerMaxAge(val);
                    //               print(authControl.partnerMaxAge);
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text("Min Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                        Text("Max Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                      ],),
                      RangeSlider(
                        min: 20.0,
                        max: 80.0,
                        divisions: 10,
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
                        },
                      ),
                    ],
                  ),
                ),


                    sizedBox20(),
                    Text(
                      'Preferred Height',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Min Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                              Text("Max Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                            ],),
                      Container(
                        width: double.infinity,
                        child: RangeSlider(
                          min: 5.0,  // Minimum value (as double)
                          max: 10.0, // Maximum value (as double)
                          divisions: 5, // Number of divisions
                          labels: RangeLabels(
                            authControl.startHeightValue.value.toString(),
                            authControl.endHeightValue.value.toString(),
                          ),
                          values: RangeValues(
                            authControl.startHeightValue.value.toDouble(), // Convert RxInt to double
                            authControl.endHeightValue.value.toDouble(),
                          ),
                          onChanged: (values) {
                            authControl.setHeightValue(values);
                          },
                        ),
                      ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text("Min Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                    //           const SizedBox(height: 5),
                    //           CustomTextField(
                    //             controller:minHeightController ,
                    //             readOnly: true,
                    //             validation: (value) {
                    //               if (value == null || value.isEmpty) {
                    //                 return 'Add Min Height';
                    //               }
                    //               return null;
                    //             },
                    //             onTap: () {
                    //               Get.bottomSheet( HeightPickerWidget(heightController: minHeightController,), backgroundColor: Colors.transparent, isScrollControlled: true);
                    //             },
                    //             onChanged: (val) {
                    //               authControl.setPartnerMinHeight(minHeightController.text);
                    //               print(val);
                    //               print(authControl.partnerMinHeight);
                    //             },
                    //             hintText: 'Min Height',showTitle: false,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     sizedBoxW10(),
                    //     Expanded(
                    //       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text("Max Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                    //           const SizedBox(height: 5),
                    //           CustomTextField(
                    //             controller: maxHeightController,
                    //             readOnly: true,
                    //             validation: (value) {
                    //               if (value == null || value.isEmpty) {
                    //                 return 'Add Max Height';
                    //               }
                    //               return null;
                    //             },
                    //             onTap: () {
                    //               Get.bottomSheet( HeightPickerWidget(heightController: maxHeightController,), backgroundColor: Colors.transparent, isScrollControlled: true);
                    //             },
                    //             onChanged: (val) {
                    //               authControl.setPartnerMaxHeight(maxHeightController.text);
                    //               print(authControl.partnerMaxHeight);
                    //             },
                    //             hintText: 'Max Height',showTitle: false,
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
                    sizedBox20(),
                    Text(
                      'Smoking Habit',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Smoking", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                              const SizedBox(height: 5),
                              CustomStyledDropdownButton(
                                items: authControl.smokingList!.map((religion) => religion.name!).toList(),
                                onChanged: (value) {
                                  var selected = authControl.smokingList!.firstWhere((religion) => religion.name == value);
                                  authControl.setSmokingIndex(selected.id!,true);
                                  print(authControl.smokingIndex  );
                                },
                                title: "Community",
                                selectedValue: authControl.smokingList!.firstWhere((religion) => religion.id == authControl.smokingIndex    ).name,
                              ),
                            ],
                          ),
                        ),
                        sizedBoxW15(),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Drinking", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                              const SizedBox(height: 5),
                              CustomStyledDropdownButton(
                                items: authControl.smokingList!.map((religion) => religion.name!).toList(),
                                onChanged: (value) {
                                  var selected = authControl.smokingList!.firstWhere((religion) => religion.name == value);
                                  authControl.setSmokingIndex(selected.id!,true);
                                  print(authControl.smokingIndex  );
                                },
                                title: "Community",
                                selectedValue: authControl.smokingList!.firstWhere((religion) => religion.id == authControl.smokingIndex    ).name,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),


                  ],
                )
            ),
          );
        }),
      ),
    );
  }
}

