import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/filter_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_dropdown_button_field.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/colors.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
   FilterBottomSheet ({super.key});
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getReligionsList();
      Get.find<AuthController>().getCommunityList();
      Get.find<AuthController>().getMotherTongueList();
      Get.find<AuthController>().getProfessionList();
    });
    return
      GetBuilder<AuthController>(builder: (authControl) {
      return  authControl.partReligionList == null || authControl.partReligionList!.isEmpty ||
          authControl.partCommunityList == null || authControl.partCommunityList!.isEmpty ||
          authControl.partProfessionList == null || authControl.partProfessionList!.isEmpty ||
          authControl.partProfessionList == null || authControl.partProfessionList!.isEmpty ||
          authControl.partMotherTongueList == null || authControl.partMotherTongueList!.isEmpty ?
      Container(height: Get.size.height * 0.8,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radius15)
          ),
          child: const Center(child: CircularProgressIndicator())) :
        GetBuilder<FilterController>(builder: (filterController) {
        final visibleCommunityChips = authControl.isExpanded
            ? authControl.partCommunityList
            : authControl.partCommunityList!.take(10).toList();
        return Container(
          height: Get.size.height * 0.8,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radius15)
          ),
          width: Get.size.width,
          child:
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(alignment: Alignment.centerRight,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Preferred Matches",
                          style: styleSatoshiLight(
                              size: 12, color: Colors.black),
                        ),
                        button(height: 24,width: 80,
                            style: kManrope14Medium626262.copyWith(color: Colors.white),
                            context: context, onTap: () {
                              Get.find<MatchesController>().getMatches(
                                  '1',
                                  Get.find<ProfileController>().profile!.basicInfo!.gender!.contains('Male')
                                      ? "Female" :
                                  Get.find<ProfileController>().profile!.basicInfo!.gender!.contains('Female')
                                      ? "Male" :
                                  "Others",
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '');
                              // Get.find<MatchesController>().getMatchesList(
                              //   "1",
                              //   profileControl.userDetails!.basicInfo!.gender!.contains("M") ? "F" : "M",
                              //   '', '', '', '', '', '', '',
                              // );
                              Get.back();
                            }, title: 'Clear All')
                      ],
                    )),
                sizedBox16(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
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
                          children: authControl.partReligionList!.map((religion) {
                            // Check if the current religion is in the list of selected religions
                            final isSelected = filterController.filterReligion.contains(religion.name);
                            return ChoiceChip(
                              backgroundColor: Colors.white,
                              selectedColor: color4B164C.withOpacity(0.80),
                              label: Text(
                                religion.name!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? Colors.white : color4B164C.withOpacity(0.80),
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                filterController.setFilterReligion(religion.name!);
                                print(filterController.filterReligion);
                              },
                            );
                          }).toList(),
                        ),


                        // CustomDropdownButtonFormField<String>(
                        //   value: authControl.partReligionList!.firstWhere((religion) => religion.id == authControl.partnerReligion).name,// Assuming you have a selectedPosition variable
                        //   items: authControl.partReligionList!.map((position) => position.name!).toList(),
                        //   hintText: "Select Religion",
                        //   onChanged: (String? value) {
                        //     if (value != null) {
                        //       var selected = authControl.partReligionList!.firstWhere((position) => position.name == value);
                        //       authControl.setPartnerReligion(selected.id!);
                        //       print(authControl.partnerReligion);
                        //     }
                        //   },
                        //   // itemLabelBuilder: (String item) => item,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please Select Religion';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Community",
                            textAlign: TextAlign.left,
                            style: styleSatoshiBold(size: 16, color: Colors.black),),
                        ),
                        const SizedBox(height: 12,),
                        Wrap(
                          spacing: 8.0,
                          children: visibleCommunityChips!.map((val) {
                            // Check if the current religion is in the list of selected religions
                            final isSelected = filterController.filterCommunity.contains(val.name);
                            return ChoiceChip(
                              backgroundColor: Colors.white,
                              selectedColor: color4B164C.withOpacity(0.80),
                              label: Text(
                                val.name!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? Colors.white : color4B164C.withOpacity(0.80),
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                filterController.setFilterCommunity(val.name!);
                                print(filterController.filterCommunity);
                              },
                            );
                          }).toList(),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: authControl.toggleExpanded,
                            child: SizedBox(
                              width: 180,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(authControl.isExpanded ? 'View Less' : 'View More',
                                    style:  kManrope14Medium626262.copyWith(color: Colors.black),),
                                  const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,)
                                ],
                              ),
                            ),
                          ),
                        ),
                        // CustomDropdownButtonFormField<String>(
                        //   value: authControl.partCommunityList!.firstWhere((religion) => religion.id == authControl.partnerCommunity).name,// Assuming you have a selectedPosition variable
                        //   items: authControl.partCommunityList!.map((position) => position.name!).toList(),
                        //   hintText: "Select Community",
                        //   onChanged: (String? value) {
                        //     if (value != null) {
                        //       var selected = authControl.partCommunityList!.firstWhere((position) => position.name == value);
                        //       authControl.setPartnerCommunity(selected.id!);
                        //       print( authControl.partnerCommunity);
                        //     }
                        //   },
                        //   // itemLabelBuilder: (String item) => item,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please Select Community';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Mother Tongue",
                            textAlign: TextAlign.left,
                            style: styleSatoshiBold(size: 16, color: Colors.black),),
                        ),
                        const SizedBox(height: 12,),
                        Wrap(
                          spacing: 8.0,
                          children: authControl.partMotherTongueList!.map((religion) {
                            // Check if the current religion is in the list of selected religions
                            final isSelected = filterController.filterMotherTongue.contains(religion.name);
                            return ChoiceChip(
                              backgroundColor: Colors.white,
                              selectedColor: color4B164C.withOpacity(0.80),
                              label: Text(
                                religion.name!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? Colors.white : color4B164C.withOpacity(0.80),
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                filterController.setFilterMotherTongue(religion.name!);
                                print(filterController.filterMotherTongue);
                              },
                            );
                          }).toList(),
                        ),
                        // CustomDropdownButtonFormField<String>(
                        //   value: authControl.partMotherTongueList!.firstWhere((religion) => religion.id == authControl.partnerMotherTongue).name,// Assuming you have a selectedPosition variable
                        //   items: authControl.partMotherTongueList!.map((position) => position.name!).toList(),
                        //   hintText: "Select Mother Tongue",
                        //   onChanged: (String? value) {
                        //     if (value != null) {
                        //       var selected = authControl.partMotherTongueList!.firstWhere((position) => position.name == value);
                        //       authControl.setPartnerMotherTongue(selected.id!);
                        //       print(authControl.partnerMotherTongue);
                        //     }
                        //   },
                        //   // itemLabelBuilder: (String item) => item,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please Select Mother Tongue';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Profession",
                            textAlign: TextAlign.left,
                            style: styleSatoshiBold(size: 16, color: Colors.black),),
                        ),
                        const SizedBox(height: 12,),
                        Wrap(
                          spacing: 8.0,
                          children: authControl.partProfessionList!.map((religion) {
                            // Check if the current religion is in the list of selected religions
                            final isSelected = filterController.filterProfession.contains(religion.name);
                            return ChoiceChip(
                              backgroundColor: Colors.white,
                              selectedColor: color4B164C.withOpacity(0.80),
                              label: Text(
                                religion.name!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? Colors.white : color4B164C.withOpacity(0.80),
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                filterController.setFilterProfession(religion.name!);
                                print(filterController.filterProfession);
                              },
                            );
                          }).toList(),
                        ),
                        // CustomDropdownButtonFormField<String>(
                        //   value: authControl.partProfessionList!.firstWhere((religion) => religion.id == authControl.partnerProfession).name,// Assuming you have a selectedPosition variable
                        //   items: authControl.partProfessionList!.map((position) => position.name!).toList(),
                        //   hintText: "Select Profession",
                        //   onChanged: (String? value) {
                        //     if (value != null) {
                        //       var selected = authControl.partProfessionList!.firstWhere((position) => position.name == value);
                        //       authControl.setPartnerProfession(selected.id!);
                        //       print( authControl.partnerProfession);
                        //     }
                        //   },
                        //   // itemLabelBuilder: (String item) => item,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please Select Profession';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("State",
                            textAlign: TextAlign.left,
                            style: styleSatoshiBold(size: 16, color: Colors.black),),
                        ),
                        const SizedBox(height: 12,),
                        CustomDropdownButtonFormField<String>(
                          value:  authControl.posselectedState,
                          items: authControl.posstates,
                          hintText: "Select Posting State",
                          onChanged: (value) {
                            authControl.possetState(value ?? authControl.posstates.first);
                            print('cadre =========== >${authControl.posselectedState}');
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty || value == 'Please Posting State') {
                              return 'Please Posting State';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Age Bracket ",
                            textAlign: TextAlign.left,
                            style: styleSatoshiBold(size: 16, color: Colors.black),),
                        ),
                        const SizedBox(height: 12,),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
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
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Height Bracket ",
                            textAlign: TextAlign.left,
                            style: styleSatoshiBold(size: 16, color: Colors.black),),
                        ),
                        sizedBox12(),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      // Text("Min Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                      Text('${authControl.startHeightValue.value.round().toString()} Ft',
                                        style:satoshiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                            color: Theme.of(context).primaryColor),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // Text("Max Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                                      Text('${authControl.endHeightValue.value.round().toString()} Ft',
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
                                    authControl.setHeightValue(values); // Update the values when slider changes
                                    print('Updated range values: ${values.start.toStringAsFixed(1)} - ${values.end.toStringAsFixed(1)}');
                                  },
                                )),
                              ),
                            ],
                          ),
                        ),
                        sizedBox16(),
                        elevatedButton(
                            color: primaryColor,
                            context: context,
                            onTap: () {
                              Get.find<MatchesController>().getMatches(
                                  '1',
                                  Get.find<ProfileController>().profile!.basicInfo!.gender!.contains('Male')
                                      ? "Female" :
                                  Get.find<ProfileController>().profile!.basicInfo!.gender!.contains('Female')
                                      ? "Male" :
                                  "Others",
                                  authControl.partnerReligion.toString(),
                                  authControl.partnerProfession.toString(),
                                  authControl.posselectedState.toString(),
                                  '',
                                  '',
                                  authControl.partnerMotherTongue.toString(),
                                  '');
                              Get.back();
                            },
                            title: "Apply")
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      });
    });
  }
}