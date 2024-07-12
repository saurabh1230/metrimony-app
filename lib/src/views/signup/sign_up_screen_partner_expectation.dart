
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_height_picker.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
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
  static final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
  bool validate() {
    return _formKey5.currentState?.validate() ?? false;
  }
}

class _SignUpScreenPartnerExpState extends State<SignUpScreenPartnerExp> {

  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();



  final countryController = TextEditingController();
  final profileController = TextEditingController();
  final countyController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final motherTongue = TextEditingController();
  final professionController = TextEditingController();
  final ageController = TextEditingController();
  final startBatchYearController = TextEditingController();
  final endBatchController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  final highestDegreeController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final instituteController = TextEditingController();


  final minHeightController = TextEditingController();
  final maxHeightController = TextEditingController();

  final minAgeController = TextEditingController();
  final maxAgeController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getProfessionList();
      Get.find<AuthController>().getPositionHeldList();
      // Get.find<AuthController>().clearStateDistrict();

      // Get.find<AuthController>().getMotherTongueList();

    });

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authControl) {
        startDateController.text =  authControl.from == null ? "Select StartDate" : authControl.from.toString();
        endDateController.text =  authControl.to == null ? "Select EndDate" : authControl.to.toString();
        startBatchYearController.text =  authControl.batchFromString;
        endBatchController.text = authControl.batchToString;
        return authControl.professionList == null || authControl.professionList!.isEmpty ||
            authControl.positionHeldList == null || authControl.positionHeldList!.isEmpty ?
        const Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          child: Form(key: SignUpScreenPartnerExp._formKey5,
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Partner Expectation',
                  style: kManrope25Black,),
                const  SizedBox(height: 30,),
                Align(
                  alignment: Alignment.centerLeft, child: Text("Profession", textAlign: TextAlign.left,
                    style: styleSatoshiBold(size: 16, color: Colors.black),),),
                const SizedBox(height: 5,),
                Wrap(
                  spacing: 8.0, children: authControl.professionList!.map((religion) {
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
                  children: authControl.religionList!.map((religion) {
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
                  children: authControl.motherTongueList!.map((religion) {
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
                  children: authControl.communityList!.map((religion) {
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
                  children: authControl.positionHeldList!.map((religion) {
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
                      child: CustomTextField(
                        controller: minAgeController,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Add Min Age';
                          }
                          return null;
                        },
                        hintText: 'Min Age',showTitle: true,
                        onChanged: (val) {
                          authControl.setPartnerMinAge(val);
                          print(authControl.partnerMinAge);
                        },

                      ),
                    ),
                    sizedBoxW10(),
                     Expanded(
                      child: CustomTextField(
                        controller:maxAgeController ,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Add Max Age';
                          }
                          return null;
                        },
                        hintText: 'Max Age',showTitle: true,
                        onChanged: (val) {
                         authControl.setPartnerMaxAge(val);
                         print(authControl.partnerMaxAge);
                      },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                     Expanded(
                      child: CustomTextField(
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
                        hintText: 'Min Height',showTitle: true,
                      ),
                    ),
                    sizedBoxW10(),
                     Expanded(
                      child: CustomTextField(
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
                        hintText: 'Max Height',showTitle: true,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Align(
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
                ),

              ],
            ),
          ),
        );
      }),
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
