
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_dropdown_button_field.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
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

class SignUpScreenEducation extends StatefulWidget {

  const SignUpScreenEducation({super.key,});

  @override
  State<SignUpScreenEducation> createState() => _SignUpScreenEducationState();
  static final GlobalKey<FormState> _formKey6 = GlobalKey<FormState>();
  bool validate() {
    return _formKey6.currentState?.validate() ?? false;
  }
}

class _SignUpScreenEducationState extends State<SignUpScreenEducation> {

  final highestDegreeController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final instituteController = TextEditingController();

  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  @override
  void initState() {
    fields();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<AuthController>().getReligionsList();
    //   Get.find<AuthController>().getCommunityList();
    //   print("checlk sttaus");
    //   Get.find<AuthController>().getMarriedStatusList();
    //   print( Get.find<AuthController>().marriedStatusList!.length);
    // });
  }


  void fields() {
    highestDegreeController.text = Get.find<AuthController>().highestDegree ?? '' ;
    fieldOfStudyController.text = Get.find<AuthController>().fieldOfStudy ?? '' ;
    instituteController.text = Get.find<AuthController>().institute ?? '' ;

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
          return authControl.religionList == null || authControl.religionList!.isEmpty ||
              authControl.communityList == null || authControl.communityList!.isEmpty ||
              authControl.marriedStatusList == null || authControl.marriedStatusList!.isEmpty
              ?
          const Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            child: Form(key: SignUpScreenEducation._formKey6,
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
                          icDegreeRegister,
                        ),
                      ),
                    ),  sizedBox20(),
                    Center(
                      child: Text(
                        'Few More Steps Please Add \nYour Education Details',
                        textAlign: TextAlign.center,
                        style: kManrope14Medium626262.copyWith(color: Colors.black),
                      ),
                    ),
                    sizedBox20(),

                    Text(
                      'Highest Degress',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomDropdownButtonFormField<String>(
                      value: authControl.highestDegree ,
                      items: authControl.highestDegreeList,
                      hintText: "Select Highest Degree",
                      onChanged: (value) {
                        authControl.setHighestDegree(value!);
                        print(authControl.highestDegree);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value == 'Select highest Degree') {
                          return 'Please Select highest Degree';
                        }
                        return null;
                      },
                    ),
                    // CustomStyledDropdownButton(
                    //   title: "Select State/UT",
                    //   items: authControl.highestDegreeList,
                    //   selectedValue: authControl.highestDegree ?? authControl.highestDegreeList.first,
                    //   onChanged: (value) {
                    //     authControl.setHighestDegree(value ?? authControl.highestDegreeList.first);
                    //     print(authControl.highestDegree);
                    //   },
                    sizedBox20(),
                    Text(
                      'Field of Study',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomTextField(hintText: "Field of Study",
                      controller: fieldOfStudyController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Field of Study';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        authControl.setFieldOfStudy(fieldOfStudyController.text);
                        print(authControl.fieldOfStudy);
                      },
                      showTitle: false,),
                    sizedBox20(),
                    Text(
                      'University / College',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomTextField(hintText: "University / College ",
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your University / College';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        authControl.setInstitute(instituteController.text);
                      },
                      controller: instituteController,
                      showTitle: false,),
                    sizedBox20(),
                    Text(
                      'Year of Passing',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomDropdownButtonFormField<String>(
                      value: authControl.batchYear ,
                      items: authControl.yearList,
                      hintText: "Select Year of Passing",
                      onChanged: (value) {
                        // authControl.setHighestDegree(value!);
                        authControl.setBatchYear(value!);
                        print(authControl.batchYear);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value == 'Select Year of Passing') {
                          return 'Please Select Year of Passing';
                        }
                        return null;
                      },
                    ),

                    // Text(
                    //   'Year of Passing',
                    //   style: kManrope25Black.copyWith(fontSize: 16),
                    // ),
                    // sizedBox12(),
                    // CustomTextField(
                    //   maximumInput: 4,
                    //   isAmount: true,
                    //   controller: _yearController,
                    //   hintText: 'Year',
                    //   validation: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please Enter Batch Year';
                    //     }
                    //     final month = int.tryParse(value);
                    //     if (month == null || month < 1 || month > 2023) {
                    //       return 'Invalid Year';
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (value) {
                    //
                    //     print(authControl.batchYear);
                    //
                    //   },
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
