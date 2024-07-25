
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_height_picker.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../constants/string.dart';
import '../../constants/textfield.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/dropdown_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreenPartnerExp extends StatefulWidget {

  const SignUpScreenPartnerExp({super.key,});

  @override
  State<SignUpScreenPartnerExp> createState() => _SignUpScreenPartnerExpState();
  static final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
  bool validate() {
    return _formKey4.currentState?.validate() ?? false;
  }
}

class _SignUpScreenPartnerExpState extends State<SignUpScreenPartnerExp> {

  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();

  @override
  void initState() {
    fields();
    super.initState();
  }
  // final _emailController = TextEditingController();
  final _phNoController = TextEditingController();

  void fields() {
    // _emailController.text = Get.find<AuthController>().email ?? '';
    _phNoController.text = Get.find<AuthController>().phone ?? '';

  }





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (authControl) {
         /* startDateController.text =  authControl.from == null ? "Select StartDate" : authControl.from.toString();
          endDateController.text =  authControl.to == null ? "Select EndDate" : authControl.to.toString();
          startBatchYearController.text =  authControl.batchFromString;
          endBatchController.text = authControl.batchToString;
          return authControl.partProfessionList == null || authControl.partProfessionList!.isEmpty ||
              authControl.partPositionHeldList == null || authControl.partPositionHeldList!.isEmpty ||
              authControl.smokingList == null || authControl.smokingList!.isEmpty ||
              authControl.drikingList == null || authControl.drikingList!.isEmpty ?
          const Center(child: CircularProgressIndicator()) :*/
        return  SingleChildScrollView(
            child: Form(key: SignUpScreenPartnerExp._formKey4,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 104,
                      width: 104,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        icEmailRegister,
                      ),
                    ),
                  ),
                  sizedBox20(),
                  Text(
                    'Please Enter Active Mobile Number',
                    textAlign: TextAlign.center,
                    style: kManrope14Medium626262.copyWith(color: Colors.black),
                  ),
                  // sizedBox12(),
                  // Text(
                  //   'Email Id',
                  //   style: kManrope25Black,
                  // ),
                  // sizedBox12(),
                  // CustomTextField(
                  //   controller: _emailController,
                  //   hintText: 'Email',
                  //   validation: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your email';
                  //     } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                  //         .hasMatch(value)) {
                  //       return 'Please enter a valid email address';
                  //     }
                  //     return null;
                  //   },
                  //   onChanged: (value) {
                  //     authControl.setEmail(_emailController.text);
                  //   },
                  // ),
                  // sizedBox20(),
                  Center(
                    child: Text(
                      'Phone Number',
                      style: kManrope25Black,
                    ),
                  ),
                  sizedBox12(),
                  CustomTextField(
                    inputType: TextInputType.number,
                    isNumber: true,
                    controller: _phNoController,
                    hintText: 'Phone',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Phone No';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      authControl.setPhone(_phNoController.text);
                    },
                  ),
              sizedBox20(),
              RichText(textAlign: TextAlign.center,
               text: TextSpan(
                children: <TextSpan>[
                TextSpan(
                  text: 'By Creating Account, You Agreed To Our',
                  style: kManrope14Medium626262.copyWith(color: Colors.black,fontSize: 12),
                ),
                TextSpan(
                  text: ' Privacy Policy',
                  style: kManrope14Medium626262.copyWith(color: Colors.redAccent,fontSize: 12),
                ),
                TextSpan(
                  text: ' and',
                  style: kManrope14Medium626262.copyWith(color: Colors.black,fontSize: 12),
                ),
                TextSpan(
                  text: ' Terms & Condition',
                  style: kManrope14Medium626262.copyWith(color: Colors.redAccent,fontSize: 12),
                ),
              ],
            ),
            ),],


              ),




















                  /// #############################################################################################
              /// #######################################################################
              /// ####################################
            /*  Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Partner Expectation',
                    style: kManrope25Black,),
                  const  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.centerLeft, child: Text("Profession", textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),),
                  const SizedBox(height: 5,),
                  Wrap(
                    spacing: 8.0, children: authControl.partProfessionList!.map((religion) {
                      return ChoiceChip(
                        selectedColor: color4B164C.withOpacity(0.80),
                        backgroundColor: Colors.white,
                        label: Text(
                          religion.name!,
                          style: TextStyle(
                            color: authControl.partnerProfession == religion.id
                                ? Colors.white
                                : Colors.black.withOpacity(0.80),
                          ),
                        ),
                        selected: authControl.partnerProfession == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            authControl.setPartnerProfession(religion.id!);
                            print(authControl.partnerProfession);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Religion",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 5,),
                  Wrap(
                    spacing: 8.0,
                    children: authControl.partReligionList!.map((religion) {
                      return ChoiceChip(
                        selectedColor: color4B164C.withOpacity(0.80),
                        backgroundColor: Colors.white,
                        label: Text(
                          religion.name!,
                          style: TextStyle(
                            color: authControl.partnerReligion == religion.id
                                ? Colors.white
                                : Colors.black.withOpacity(0.80),
                          ),
                        ),
                        selected: authControl.partnerReligion == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            authControl.setPartnerReligion(religion.id!);
                            print(authControl.partnerReligion);
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
                  const SizedBox(height: 5,),
                  Wrap(
                    spacing: 8.0, // Adjust spacing as needed
                    children: authControl.partMotherTongueList!.map((religion) {
                      return ChoiceChip(
                        selectedColor: color4B164C.withOpacity(0.80),
                        backgroundColor: Colors.white,

                        label: Text(religion.name! ,style: TextStyle(color: authControl.partnerMotherTongue == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                        selected: authControl.partnerMotherTongue == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            authControl.setPartnerMotherTongue(religion.id!);
                            print( authControl.partnerMotherTongue);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Caste",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 5,),

                  Wrap(
                    spacing: 8.0, // Adjust spacing as needed
                    children: authControl.partCommunityList!.map((religion) {
                      return ChoiceChip(
                        selectedColor: color4B164C.withOpacity(0.80),
                        backgroundColor: Colors.white,

                        label: Text(religion.name! ,style: TextStyle(color: authControl.partnerCommunity == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                        selected: authControl.partnerCommunity == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            authControl.setPartnerCommunity(religion.id!);
                            print(authControl.partnerCommunity);
                          }
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Position",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 5,),
                  Wrap(
                    spacing: 8.0,
                    children: authControl.partPositionHeldList!.map((religion) {
                      return ChoiceChip(
                        selectedColor: color4B164C.withOpacity(0.80),
                        backgroundColor: Colors.white,
                        label: Text(
                          religion.name!,
                          style: TextStyle(
                            color: authControl.partnerPosition == religion.id
                                ? Colors.white
                                : Colors.black.withOpacity(0.80),
                          ),
                        ),
                        selected: authControl.partnerPosition == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            // authControl.setPositionIndex(religion.id, true);
                            authControl.setPartnerPosition(religion.id!);
                            print(authControl.partnerPosition);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  sizedBox20(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Other Info",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                       Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Min Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                            const SizedBox(height: 5), //
                            CustomTextField(
                              controller: minAgeController,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Min Age';
                                }
                                return null;
                              },
                              hintText: 'Min Age',showTitle: false,
                              onChanged: (val) {
                                authControl.setPartnerMinAge(val);
                                print(authControl.partnerMinAge);
                              },

                            ),
                          ],
                        ),
                      ),
                      sizedBoxW10(),
                       Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Max Age", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                           const SizedBox(height: 5),
                            CustomTextField(
                              controller:maxAgeController ,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Max Age';
                                }
                                return null;
                              },
                              hintText: 'Max Age',showTitle: false,
                              onChanged: (val) {
                               authControl.setPartnerMaxAge(val);
                               print(authControl.partnerMaxAge);
                            },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                       Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Min Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller:minHeightController ,
                              readOnly: true,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Min Height';
                                }
                                return null;
                              },
                              onTap: () {
                                Get.bottomSheet( HeightPickerWidget(heightController: minHeightController,), backgroundColor: Colors.transparent, isScrollControlled: true);
                              },
                              onChanged: (val) {
                                authControl.setPartnerMinHeight(minHeightController.text);
                                print(val);
                                print(authControl.partnerMinHeight);
                              },
                              hintText: 'Min Height',showTitle: false,
                            ),
                          ],
                        ),
                      ),
                      sizedBoxW10(),
                       Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Max Height", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: maxHeightController,
                              readOnly: true,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Max Height';
                                }
                                return null;
                              },
                              onTap: () {
                                Get.bottomSheet( HeightPickerWidget(heightController: maxHeightController,), backgroundColor: Colors.transparent, isScrollControlled: true);
                              },
                              onChanged: (val) {
                                authControl.setPartnerMaxHeight(maxHeightController.text);
                                print(authControl.partnerMaxHeight);
                              },
                              hintText: 'Max Height',showTitle: false,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30,),
                    Align(
                    alignment: Alignment.centerLeft, child: Text("Smoking Habit", textAlign: TextAlign.left,
                    style: styleSatoshiBold(size: 16, color: Colors.black),),),
                  const SizedBox(height: 5,),
                  Wrap(
                    spacing: 8.0, children: authControl.smokingList!.map((religion) {
                    return ChoiceChip(
                      selectedColor: color4B164C.withOpacity(0.80),
                      backgroundColor: Colors.white,
                      label: Text(
                        religion.name!,
                        style: TextStyle(
                          color: authControl.smokingIndex == religion.id
                              ? Colors.white
                              : Colors.black.withOpacity(0.80),
                        ),
                      ),
                      selected: authControl.smokingIndex == religion.id,
                      onSelected: (selected) {
                        if (selected) {
                          authControl.setSmokingIndex(religion.id!,true);
                          print(authControl.smokingIndex);
                        }
                      },
                    );
                  }).toList(),
                  ),
                  const SizedBox(height: 30,),

                  Align(
                    alignment: Alignment.centerLeft, child: Text("Drinking Habit", textAlign: TextAlign.left,
                    style: styleSatoshiBold(size: 16, color: Colors.black),),),
                  const SizedBox(height: 5,),
                  Wrap(
                    spacing: 8.0, children: authControl.drikingList!.map((religion) {
                    return ChoiceChip(
                      selectedColor: color4B164C.withOpacity(0.80),
                      backgroundColor: Colors.white,
                      label: Text(
                        religion.name!,
                        style: TextStyle(
                          color: authControl.drikingIndex == religion.id
                              ? Colors.white
                              : Colors.black.withOpacity(0.80),
                        ),
                      ),
                      selected: authControl.drikingIndex == religion.id,
                      onSelected: (selected) {
                        if (selected) {
                          authControl.setDrikingIndex(religion.id!,true);
                          print(authControl.drikingIndex);
                        }
                      },
                    );
                  }).toList(),
                  ),
                 *//* Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Smoking",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 12,),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ChipList(
                        elements: authControl.smokingStatus,
                        onChipSelected: (val) {
                          authControl.setPartnerSmokingStatus(val == "Yes" ? "1" :"2");
                          print(authControl.smokingStatus);

                          // authControl.setGender(
                          //     selectedGender == "Male" ? "M" : selectedGender == "Female" ? "F" : "O"
                          // );
                          // setState(() {
                          //
                          //   // SharedPrefs().setGender(selectedGender);
                          //   // SharedPrefs().getGender();
                          // });
                        },
                        defaultSelected: "Yes",
                      ),),
                  ),
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Drinking",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 12,),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ChipList(
                        elements: authControl.drinkingStatus,
                        onChipSelected: (val) {
                          authControl.setPartnerDrinkingStatus(val == "Yes" ? "1" :"2");
                          print(authControl.drinkingStatus);
                          // authControl.setGender(
                          //     selectedGender == "Male" ? "M" : selectedGender == "Female" ? "F" : "O"
                          // );
                          // setState(() {
                          //
                          //   // SharedPrefs().setGender(selectedGender);
                          //   // SharedPrefs().getGender();
                          // });
                        },
                        defaultSelected: "Yes",
                      ),),
                  ),*//*

                ],
              ),*/
            ),
          );
        }),
      ),
    );
  }
}
class ChipList extends StatefulWidget {
  final List<dynamic> elements;
  final Function(dynamic) onChipSelected;
  final dynamic? defaultSelected;

  const ChipList({
    Key? key,
    required this.elements,
    required this.onChipSelected,
    this.defaultSelected,
  }) : super(key: key);

  @override
  _ChipListState createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  late dynamic selectedChip;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    selectedChip = widget.defaultSelected ?? '';
    // selectedChip = widget.defaultSelected ?? widget.elements.first; // Set the default selected chip
    errorMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: widget.elements.map((e) => ChipBox(value: e)).toList(),
        ),
        if (errorMessage.isNotEmpty)
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  void handleChipSelected(dynamic chipValue) {
    if (validateChip(chipValue)) {
      setState(() {
        selectedChip = chipValue;
        widget.onChipSelected(selectedChip);
        errorMessage = '';
      });
    } else {
      setState(() {
        errorMessage = 'Invalid chip selected';
      });
    }
  }

  bool validateChip(dynamic chipValue) {
    return chipValue != null; // Simple validation: Check if the chipValue is not null
  }
}

class ChipBox extends StatelessWidget {
  final dynamic value;

  const ChipBox({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ChipListState chipListState =
    context.findAncestorStateOfType<_ChipListState>()!;

    return ActionChip(
      onPressed: () {
        chipListState.handleChipSelected(value);
      },
      backgroundColor:
      value == chipListState.selectedChip ? color4B164C.withOpacity(0.80) : Colors.white,
      label: Text(
        value.toString(),
        style:
        TextStyle(
          fontSize: 16,
          color: value == chipListState.selectedChip ? Colors.white : color4B164C.withOpacity(0.80),
        ),
      ),
    );
  }
}
