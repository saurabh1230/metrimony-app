
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../constants/string.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/dropdown_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
class SignUpScreenTwo extends StatefulWidget {

  const SignUpScreenTwo({super.key,});

  @override
  State<SignUpScreenTwo> createState() => _SignUpScreenTwoState();
  static final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  bool validate() {
    return _formKey2.currentState?.validate() ?? false;
  }
}

class _SignUpScreenTwoState extends State<SignUpScreenTwo> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getReligionsList();
      Get.find<AuthController>().getCommunityList();
      // Get.find<AuthController>().getMotherTongueList();
      fields();
    });

    super.initState();
  }

  void fields() {
    firstNameController.text = Get.find<AuthController>().firstName ?? '';
    lastNameController.text = Get.find<AuthController>().lastName ?? '';
    middleNameController.text = Get.find<AuthController>().middleName ?? '';

    _dayController.text = Get.find<AuthController>().day ?? '';
    _monthController.text = Get.find<AuthController>().month ?? '';
    _yearController.text = Get.find<AuthController>().year ?? '';

  }
  @override
  Widget build(BuildContext context) {

    String? selectedSuggestion;




    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (authControl) {
          print(authControl.religionList);
          return SingleChildScrollView(
            child: Form(
              key: SignUpScreenTwo._formKey2,
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        icNameRegister,
                      ),
                    ),
                  ),
                  sizedBox20(),
                  Center(
                    child: Text("Let's Start With First Step",
                      textAlign: TextAlign.center,
                      style: kManrope14Medium626262.copyWith(color: Colors.black),
                    ),
                  ),
                  sizedBox20(),
                  Text(
                    'Your Name',
                    style: kManrope25Black,
                  ),
                  sizedBox12(),
                  CustomTextField(
                    showTitle: true,
                    controller: firstNameController,
                    capitalization: TextCapitalization.words,
                    hintText: 'First Name',
                    onChanged: (value) {
                      authControl.setFirstName(firstNameController.text);
                    },
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter First name';
                      }
                      // Regular expression to allow only letters and spaces
                      final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
                      if (!nameRegExp.hasMatch(value)) {
                        return 'Please enter a valid name without special characters';
                      }
                      return null;
                    },
                  ),

                  sizedBox20(),
                  CustomTextField(
                    showTitle: true,
                    controller: middleNameController,
                    capitalization: TextCapitalization.words,
                    hintText: 'Middle Name (Optional)',
                    onChanged: (value) {
                      authControl.setMiddleName(middleNameController.text);
                      print(authControl.middleName);
                    },
                  ),
                  sizedBox20(),
                  CustomTextField(
                    showTitle: true,
                    controller: lastNameController,
                    capitalization: TextCapitalization.words,
                    hintText: 'Last Name',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter First name';
                      }
                      // Regular expression to allow only letters and spaces
                      final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
                      if (!nameRegExp.hasMatch(value)) {
                        return 'Please enter a valid name without special characters';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      authControl.setLastName(lastNameController.text);
                    },
                  ),
                  sizedBox20(),
                  Text(
                    'Date of Birth',
                    style: kManrope25Black,
                  ),
                  sizedBox12(),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          maximumInput: 2,
                          isAmount: true,
                          controller: _dayController,
                          hintText: 'Date',
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Invalid Date';
                            }
                            final month = int.tryParse(value);
                            if (month == null || month < 1 || month > 31) {
                              return 'Enter Date';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            authControl.setDay(_dayController.text);
                            print(authControl.day);
                          },
                        ),
                      ),
                      sizedBoxWidth15(),
                      Expanded(
                        child: CustomTextField(
                          maximumInput: 2,
                          isAmount: true,
                          controller: _monthController,
                          hintText: 'Month',
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Month';
                            }
                            final month = int.tryParse(value);
                            if (month == null || month < 1 || month > 12) {
                              return 'Invalid Month';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            authControl.setMonth(_monthController.text);
                            print(authControl.month);
                          },
                        ),
                      ),
                      // sizedBoxWidth15(),
                      // Expanded(
                      //   child: CustomTextField(
                      //     maximumInput: 4,
                      //     isAmount: true,
                      //     controller: _yearController,
                      //     hintText: 'Year',
                      //     validation: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'Invalid Year';
                      //       }
                      //       final year = int.tryParse(value);
                      //       if (year == null || year < 1970 || year > 2006) {
                      //         return 'Year must be between 1970 and 2006';
                      //       }
                      //       return null;
                      //     },
                      //     onChanged: (value) {
                      //       authControl.setYear(_yearController.text);
                      //       print(authControl.year);
                      //
                      //     },
                      //   ),
                      // ),

                    ],
                  ),
                  sizedBox20(),
                  CustomTextField(
                    maximumInput: 4,
                    isAmount: true,
                    controller: _yearController,
                    hintText: 'Year',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Year';
                      }
                      final year = int.tryParse(value);
                      if (year == null || year < 1954 || year > 2006) {
                        return 'The Maximum Registration Age is 70';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      authControl.setYear(_yearController.text);
                      print(authControl.year);

                    },
                  ),












                  /// /////////// ///////// //////// ////// Old Design ///////////
                  // Column(
                  //   children: [
                  //     Text('Your Name',
                  //       style: kManrope25Black,),
                  //     const SizedBox(height: 20,),
                  //     Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Text("Gender",
                  //         textAlign: TextAlign.left,
                  //         style: styleSatoshiBold(size: 16, color: Colors.black),),
                  //     ),
                  //     const SizedBox(height: 12,),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //       child: Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: ChipList(
                  //           elements: gender,
                  //           onChipSelected: (selectedGender) {
                  //             authControl.setGender(selectedGender == "Male" ? "M" : selectedGender == "Female" ? "F" : "O");
                  //             // setState(() {
                  //             //
                  //             //   // SharedPrefs().setGender(selectedGender);
                  //             //   // SharedPrefs().getGender();
                  //             // });
                  //           },
                  //           defaultSelected: "Male",
                  //         ),),
                  //     ),
                  //     const SizedBox(height: 20,),
                  //     Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Text("Religion",
                  //         textAlign: TextAlign.left,
                  //         style: styleSatoshiBold(size: 16, color: Colors.black),),
                  //     ),
                  //     const SizedBox(height: 12,),
                  //                   Wrap(
                  //                     spacing: 8.0,
                  //                     children: authControl.religionList!.map((religion) {
                  //     return ChoiceChip(selectedColor: color4B164C.withOpacity(0.80),
                  //       backgroundColor: Colors.white, label: Text(
                  //         religion.name!,
                  //         style: TextStyle(
                  //           color: authControl.religionMainIndex == religion.id
                  //               ? Colors.white
                  //               : Colors.black.withOpacity(0.80),
                  //         ),
                  //       ),
                  //       selected: authControl.religionMainIndex == religion.id,
                  //       onSelected: (selected) {
                  //         if (selected) {
                  //           authControl.setReligionMainIndex(religion.id, true);
                  //         }
                  //       },
                  //     );
                  //                     }).toList(),
                  //                   ),
                  //
                  //
                  //     const SizedBox(height: 20,),
                  //
                  //     Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Text("Caste",
                  //         textAlign: TextAlign.left,
                  //         style: styleSatoshiBold(size: 16, color: Colors.black),),
                  //     ),
                  //     const SizedBox(height: 12,),
                  //
                  //     Wrap(
                  //       spacing: 8.0, // Adjust spacing as needed
                  //       children: authControl.communityList!.map((religion) {
                  //         return ChoiceChip(
                  //           selectedColor: color4B164C.withOpacity(0.80),
                  //           backgroundColor: Colors.white,
                  //
                  //           label: Text(religion.name! ,style: TextStyle(color: authControl.communityMainIndex == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                  //           selected: authControl.communityMainIndex == religion.id,
                  //           onSelected: (selected) {
                  //             if (selected) {
                  //               authControl.setCommunityMainListIndex(religion.id, true);
                  //             }
                  //           },
                  //         );
                  //       }).toList(),
                  //     ),
                  //     const SizedBox(height: 20,),
                  //
                  //     Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Text("Mother Tongue",
                  //         textAlign: TextAlign.left,
                  //         style: styleSatoshiBold(size: 16, color: Colors.black),),
                  //     ),
                  //     const SizedBox(height: 12,),
                  //     Wrap(
                  //       spacing: 8.0, // Adjust spacing as needed
                  //       children: authControl.motherTongueList!.map((religion) {
                  //         return ChoiceChip(
                  //           selectedColor: color4B164C.withOpacity(0.80),
                  //           backgroundColor: Colors.white,
                  //
                  //           label: Text(religion.name! ,style: TextStyle(color: authControl.motherTongueIndex == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                  //           selected: authControl.motherTongueIndex == religion.id,
                  //           onSelected: (selected) {
                  //             if (selected) {
                  //               authControl.setMotherTongueIndex(religion.id, true);
                  //             }
                  //           },
                  //         );
                  //       }).toList(),
                  //     ),
                  //
                  //
                  //     const SizedBox(height: 20,),
                  //   ],
                  // ),



                  // adding

                  sizedBox12(),
                ],
              ),
            ),
          );
      } )

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
