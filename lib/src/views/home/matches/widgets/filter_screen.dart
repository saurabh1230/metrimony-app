import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/colors.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<ProfileController>().getBasicInfoApi();
    //
    // });
    return GetBuilder<AuthController>(builder: (authControl) {
      return  GetBuilder<ProfileController>(builder: (profileControl) {
        return Container(
          height: Get.size.height * 0.8,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radius15)
          ),
          width: Get.size.width,
          child: authControl.communityList == null || authControl.communityList!.isEmpty ||
              authControl.religionList == null || authControl.religionList!.isEmpty ||
              authControl.motherTongueList == null || authControl.motherTongueList!.isEmpty ?
              const Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: authControl.isLoading ? const Center(child: CircularProgressIndicator()) :
              profileControl.isLoading ? const Center(child: CircularProgressIndicator()) : Column(
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
                                authControl.communityFilterIndex == null;
                                authControl.motherTongueFilterIndex == null;
                                authControl.religionFilterIndex == null;
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

                  // sizedBox16(),
                  //
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
                            color: authControl.religionFilterIndex == religion.id
                                ? Colors.white
                                : Colors.black.withOpacity(0.80),
                          ),
                        ),
                        selected: authControl.religionFilterIndex == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            // authControl.setReligionMainIndex(religion.id, true);
                            authControl.setReligionFilterIndex(religion.id, true);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20,),
            
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Community",
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
            
                        label: Text(religion.name! ,style: TextStyle(color: authControl.communityFilterIndex == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                        selected: authControl.communityFilterIndex == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            // authControl.setCommunityMainListIndex(religion.id, true);
                            authControl.setCommunityFilterIndex(religion.id, true);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20,),
            
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
            
                        label: Text(religion.name! ,style: TextStyle(color: authControl.motherTongueFilterIndex == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                        selected: authControl.motherTongueFilterIndex == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            // authControl.setMotherTongueIndex(religion.id, true);
                            authControl.setMotherTongueFilterIndex(religion.id, true);
                          }
            
                        },
                      );
                    }).toList(),
                  ),
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
                      // sizedBoxW10(),
                      // Expanded(
                      //   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text("Select District of Posting", style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12,)),
                      //       const SizedBox(height: 5),
                      //       TypeAheadFormField<String>(
                      //         textFieldConfiguration:  TextFieldConfiguration(
                      //           controller: districtController,
                      //           decoration: const InputDecoration(
                      //             labelText: 'Select District of Posting',
                      //             border: OutlineInputBorder(),
                      //           ),
                      //         ),
                      //         suggestionsCallback: (pattern) async {
                      //           return authControl.districts.where((state) => state.toLowerCase().contains(pattern.toLowerCase())).toList();
                      //         },
                      //         itemBuilder: (context, suggestion) {
                      //           return ListTile(
                      //             title: Text(suggestion),
                      //           );
                      //         },
                      //         onSuggestionSelected: (String? suggestion) {
                      //           if (suggestion != null) {
                      //             districtController.text = suggestion;
                      //             authControl.setPPostingDistrict(suggestion);
                      //           }
                      //         },
                      //         validator: (value) {
                      //           if (value == null || value.isEmpty) {
                      //             return 'Please District of Posting';
                      //           }
                      //           return null;
                      //         },
                      //         onSaved: (value) => authControl.setDistrict(value!),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                  Text("Height Range", style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12,)),
                  const SizedBox(height: 5),
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
                        //   Get.find<MatchesController>().getMatchesList(
                        //       "1",
                        //       profileControl.userDetails!.basicInfo!.gender!.contains("M") ? "F" : "M",
                        //       authControl.religionFilterIndex.toString(),
                        //       stateController.text,
                        //       '',
                        //       profileControl.minHeight.toString(),
                        //       profileControl.maxHeight.toString(),
                        //       authControl.motherTongueFilterIndex.toString(),
                        //       authControl.communityFilterIndex.toString(),
                        //   );
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
          ),
        );
      });
    });
  }
}