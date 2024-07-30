import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/colors.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CareerInfoEditBottomSheet extends StatelessWidget {
  CareerInfoEditBottomSheet ({super.key});
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<ProfileController>().getBasicInfoApi();
    //
    // });
    return GetBuilder<AuthController>(builder: (authControl) {
      return  GetBuilder<ProfileController>(builder: (profileControl) {
        return Container(
          color: Theme.of(context).cardColor,
          width: Get.size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: authControl.isLoading ? const CircularProgressIndicator() :
            profileControl.isLoading ? const CircularProgressIndicator() : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                sizedBox16(),
                Text(
                  "Select Preferred Matches",
                  style: styleSatoshiLight(
                      size: 12, color: Colors.black),
                ),
                //
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select State of Posting", style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12,)),
                          const SizedBox(height: 5),
                          TypeAheadFormField<String>(
                            textFieldConfiguration:  TextFieldConfiguration(
                              controller: stateController,
                              decoration: authDecoration(
                                  context, "Select State of Posting"
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return authControl.states.where((state) => state.toLowerCase().contains(pattern.toLowerCase())).toList();
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (String? suggestion) {
                              if (suggestion != null) {

                                stateController.text = suggestion;
                                // authControl.setPostingState(suggestion);

                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select State of Posting';
                              }
                              return null;
                            },
                            onSaved: (value) => authControl.setState(value!),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxW10(),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select District of Posting", style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12,)),
                          const SizedBox(height: 5),
                          TypeAheadFormField<String>(
                            textFieldConfiguration:  TextFieldConfiguration(
                              controller: districtController,
                              decoration: const InputDecoration(
                                labelText: 'Select District of Posting',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return authControl.districts.where((state) => state.toLowerCase().contains(pattern.toLowerCase())).toList();
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (String? suggestion) {
                              if (suggestion != null) {
                                districtController.text = suggestion;
                                authControl.setPPostingDistrict(suggestion);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please District of Posting';
                              }
                              return null;
                            },
                            onSaved: (value) => authControl.setDistrict(value!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20,),

                // Padding(
                //   padding:
                //   const EdgeInsets.symmetric(horizontal: 0.0),
                //   child: SizedBox(
                //     width: 1.sw,
                //     child: CustomStyledDropdownButton(
                //       items: const  [
                //         "Hindu",
                //         'Muslim',
                //         "Jain",
                //         'Buddhist',
                //         'Sikh',
                //         'Marathi'
                //       ],
                //       selectedValue: religionValue,
                //       onChanged: (String? value) {
                //         setState(() {
                //           religionValue = value;
                //           religionFilter = religionValue ?? '';
                //
                //         });
                //       },
                //       title: 'Religion',
                //     ),
                //   ),
                // ),
                // sizedBox16(),
                // sizedBox16(),

                // textBox(
                //   context: context,
                //   label: 'State',
                //   controller: stateController,
                //   hint: 'State',
                //   length: null,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your State';
                //     }
                //     return null;
                //   },
                //   onChanged: (value) {
                //
                //   },),
                SfRangeSlider(
                  min: 5.0,
                  max: 8.0,
                  values: SfRangeValues(profileControl.minHeight, profileControl.maxHeight),
                  interval: 0.4,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (SfRangeValues values) {
                    profileControl.setMinHeight(values.start);
                    profileControl.setMaxHeight(values.end);
                  },
                ),

                sizedBox16(),
                elevatedButton(
                    color: primaryColor,
                    context: context,
                    onTap: () {
                      // print("check ============= >");
                      // Get.find<MatchesController>().getMatchesList(
                      //     "1",
                      //     /*  profileControl.userDetails!.data!.user!.basicInfo!.gender!.contains("M") ? "F" :*/ "M",
                      //     authControl.religionMainIndex.toString(),
                      //     stateController.text,
                      //     '',
                      //     '',
                      //     '',
                      //     // profileControl.minHeight.toString(),
                      //     // profileControl.maxHeight.toString(),
                      //     // '',
                      //     authControl.motherTongueIndex.toString(),
                      //     ''
                      // );
                      Get.back();


                      // setState(() {
                      //   Navigator.pop(context);
                      //   isLoading = true;
                      //   page = 1;
                      //
                      //
                      //   getMatches();
                      // });
                    },
                    title: "Apply")
              ],
            ),
          ),
        );
      });





    });


  }
}