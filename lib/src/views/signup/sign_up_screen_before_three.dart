
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
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

class SignUpScreenProfessional extends StatefulWidget {

  const SignUpScreenProfessional({super.key,});

  @override
  State<SignUpScreenProfessional> createState() => _SignUpScreenProfessionalState();
  static final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
  bool validate() {
    return _formKey4.currentState?.validate() ?? false;
  }
}

class _SignUpScreenProfessionalState extends State<SignUpScreenProfessional> {

  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();

  final List<String> elements = ['My Self', 'My Son', 'My Sister', 'My Daughter', 'My Brother','My Friend','My Relative'];
  final List<String> gender = ["Male","Female","Other"];
  final List<String> religion = ["Hindu","Muslim","Jain",'Buddhist','Sikh','Christian'];
  final List<String> married = ["Unmarried","Widowed","Divorced"];




  final stateController = TextEditingController();
  final districtController = TextEditingController();



  final startBatchYearController = TextEditingController();
  final endBatchController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  final highestDegreeController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final instituteController = TextEditingController();

  @override
  void initState() {
    fields();
    super.initState();
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getProfessionList();
      Get.find<AuthController>().getPositionHeldList();
      // Get.find<AuthController>().clearStateDistrict();

      // Get.find<AuthController>().getMotherTongueList();

    });

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (authControl) {
          startDateController.text =  authControl.from == null ? "" : authControl.from.toString();
          endDateController.text =  authControl.to == null ? "" : authControl.to.toString();
          startBatchYearController.text =  authControl.batchFromString;
          endBatchController.text = authControl.batchToString;
          return authControl.professionList == null || authControl.professionList!.isEmpty ||
          authControl.positionHeldList == null || authControl.positionHeldList!.isEmpty ?
          const Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            child: Form(key: SignUpScreenProfessional._formKey4,
              child:
              Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Professional Info',
                    style: kManrope25Black,),
                  const  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Profession",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 5,),
                  Wrap(
                    spacing: 8.0,
                    children: authControl.professionList!.map((religion) {
                      return ChoiceChip(
                        selectedColor: color4B164C.withOpacity(0.80),
                        backgroundColor: Colors.white,
                        label: Text(
                          religion.name!,
                          style: TextStyle(
                            color: authControl.professionIndex == religion.id
                                ? Colors.white
                                : Colors.black.withOpacity(0.80),
                          ),
                        ),
                        selected: authControl.professionIndex == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            authControl.setProfessionIndex(religion.id, true);
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
                            color: authControl.positionHeldIndex == religion.id
                                ? Colors.white
                                : Colors.black.withOpacity(0.80),
                          ),
                        ),
                        selected: authControl.positionHeldIndex == religion.id,
                        onSelected: (selected) {
                          if (selected) {
                            authControl.setPositionIndex(religion.id, true);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20,),
                  Text("Cadres", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 1.sw,
                    child: CustomStyledDropdownButton(
                      items: const  [
                        "Cadres",

                      ],
                      selectedValue: cadarValue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Cadres';
                        }
                        return null;
                      },
                      onChanged: (String? value) {
                        // setState(() {
                        //   cadarValue = value;
                        //   cadarFilter = cadarValue ?? '';
                        //   SharedPrefs().setMotherTongue(cadarFilter);
                        //
                        // });
                        // print(userTypeFilter);
                        // print('Check ======> Usetype${userTypeFilter}');
                      },
                      title: 'Cadres',
                    ),
                  ),
                  const SizedBox(height: 20,),
                Text("Batch Year", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter your Starting Year';
                            }
                            return null;
                          },
                          onTap: () {authControl.showStartingYearPickerDialog();},
                          onChanged: (value) {
                            authControl.setBatchStartYear(startBatchYearController.text);
                          },
                          readOnly:  true,
                          hintText:"Starting year",
                          controller: startBatchYearController,
                        ),
                      ),
                      // sizedBoxW10(),
                      // Expanded(
                      //   child: CustomTextField(hintText:"Ending year",
                      //     validation: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'Please Enter your Ending Year';
                      //       }
                      //       return null;
                      //     },
                      //     onChanged: (value) {
                      //     authControl.setBatchStartYear(endBatchController.text);
                      //     },
                      //     onTap: () {
                      //     authControl.showEndingYearPickerDialog();
                      //     },
                      //     readOnly: true,
                      //     controller: endBatchController,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Posting State", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                      const SizedBox(height: 5),
                      TypeAheadFormField<String>(
                        textFieldConfiguration:  TextFieldConfiguration(
                          controller: stateController,
                          decoration: authDecoration(
                              context, "Select Posting State"
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return authControl.posStates.where((state) => state.toLowerCase().contains(pattern.toLowerCase())).toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (String? suggestion) {
                          if (suggestion != null) {
                            authControl.setPosState(suggestion);
                            stateController.text = suggestion;
                            authControl.setPosstate(stateController.text);
                            print(authControl.posState);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Select Posting State';
                          }
                          return null;
                        },
                        onSaved: (value) => authControl.setPosState(value!),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Posting District", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                      const SizedBox(height: 5),
                      TypeAheadFormField<String>(
                        textFieldConfiguration:  TextFieldConfiguration(
                          controller: districtController,
                          decoration: const InputDecoration(
                            // labelText: 'Select Posting District',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return authControl.posDistricts.where((state) => state.toLowerCase().contains(pattern.toLowerCase())).toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (String? suggestion) {
                          if (suggestion != null) {
                            // authControl.setDistrict(suggestion);
                            districtController.text = suggestion;
                            authControl.setPosDist(suggestion);
                            print(authControl.posDistrict);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Select Posting District';
                          }
                          return null;
                        },
                        onSaved: (value) => authControl.setPosDistrict(value!),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),
                  Text("Date of Posting", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                  const SizedBox(height: 5), //
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          showTitle: false,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter your Starting Date';
                            }
                            return null;
                          },
                          onTap: () { Get.find<AuthController>().showDatePicker(context); },
                          onChanged: (value) {
                            authControl.setPostingStartDate(authControl.from.toString());

                          },
                          readOnly:  true,
                          hintText:"Posting Start date",
                          controller: startDateController,
                        ),
                      ),
                      // sizedBoxW10(),
                      // Expanded(
                      //   child: CustomTextField(
                      //     showTitle: true, validation: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'Please Enter your Ending Date';
                      //        }
                      //       return null;
                      //     },
                      //     onChanged: (value) {
                      //       authControl.setPostingEndDate(endDateController.text);
                      //     },
                      //     hintText:"Ending date",
                      //     controller: endDateController,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Text('Education Info', style: kManrope25Black,),
                  const SizedBox(height: 20,),
                  Text("Highest Degree", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                  const SizedBox(height: 5), //
                  CustomTextField(hintText: "Highest Degree",
                  controller: highestDegreeController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Highest Degree';
                      }
                      return null;
                    },
                    onChanged: (value) {
                    authControl.setHighestDegree(highestDegreeController.text);
                    },
                  showTitle: false,),
                  const SizedBox(height: 20,),
                  Text("Field of Study", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                  const SizedBox(height: 5), //
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
                    },
                    showTitle: false,),
                  const SizedBox(height: 20,),
                  Text("University / Institute", style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                  const SizedBox(height: 5), //
                  CustomTextField(hintText: "University / Institute",
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your University / Institute';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      authControl.setInstitute(instituteController.text);
                    },
                    controller: instituteController,
                    showTitle: false,),
                  const SizedBox(height: 20,),
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
