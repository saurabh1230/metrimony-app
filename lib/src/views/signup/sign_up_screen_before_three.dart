
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_decorated_containers.dart';
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
import '../../../getx/data/response/community_list_model.dart';
import '../../constants/string.dart';
import '../../constants/textfield.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/dropdown_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreenProfessional extends StatefulWidget {
  const SignUpScreenProfessional({super.key,});

  @override
  State<SignUpScreenProfessional> createState() => _SignUpScreenProfessionalState();
  static final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  bool validate() {
    return _formKey3.currentState?.validate() ?? false;
  }
}

class _SignUpScreenProfessionalState extends State<SignUpScreenProfessional> {

  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();

  final List<String> elements = ['My Self', 'My Son', 'My Sister', 'My Daughter', 'My Brother','My Friend','My Relative'];
  final List<String> gender = ["Male","Female","Other"];
  final List<String> religion = ["Hindu","Muslim","Jain",'Buddhist','Sikh','Christian'];
  final List<String> married = ["Unmarried","Widowed","Divorced"];



  final cadreController = TextEditingController();
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getReligionsList();
      Get.find<AuthController>().getCommunityList();
      Get.find<AuthController>().getMotherTongueList();
      Get.find<AuthController>().getmarriedStatusList();
      Get.find<AuthController>().getCasteList(Get.find<AuthController>().religionMainIndex);

      print( Get.find<AuthController>().religionMainIndex);
    });
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
    final defaultReligion = CommunityListModel(id: -1, name: 'None');
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
          authControl.marriedStatusList == null || authControl.marriedStatusList!.isEmpty ||
              authControl.motherTongueList == null || authControl.motherTongueList!.isEmpty
              ?
          const Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
            child: Form(key: SignUpScreenProfessional._formKey3,
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
                        icReligionRegister,
                      ),
                    ),
                  ),
                  sizedBox20(),
                  Center(
                    child: Text("Now Pick Your Identity Details",
                      textAlign: TextAlign.center,
                      style: kManrope14Medium626262.copyWith(color: Colors.black),
                    ),
                  ),

                  // sizedBox20(),
                  // Text(
                  //   'Married Status',
                  //   style: kManrope25Black,
                  // ),
                  // sizedBox12(),
                  // CustomStyledDropdownButton(
                  //   items: authControl.marriedStatusList!.map((religion) => religion.name!).toList(),
                  //   onChanged: (value) {
                  //     var selectedReligion = authControl.marriedStatusList!.firstWhere((religion) => religion.name == value);
                  //     authControl.setReligionMainIndex(selectedReligion.id, true);
                  //     print(authControl.religionMainIndex);
                  //   },
                  //   title: "Select Religion",
                  //   selectedValue: authControl.marriedStatusList!.firstWhere((religion) => religion.id == authControl.religionMainIndex).name,
                  // ),

                  sizedBox20(),
                  Text(
                    ' Religion',
                    style: kManrope25Black.copyWith(fontSize: Dimensions.fontSize18),
                  ),
                  sizedBox12(),
                  CustomDropdownButtonFormField<String>(
                    value: authControl.religionList!.firstWhere((religion) => religion.id == authControl.religionMainIndex).name,// Assuming you have a selectedPosition variable
                    items: authControl.religionList!.map((position) => position.name!).toList(),
                    hintText: "Select Religion",
                    onChanged: (String? value) {
                      if (value != null) {
                        var selected = authControl.religionList!.firstWhere((position) => position.name == value);
                         authControl.setReligionMainIndex(selected.id, true);
                        authControl.getCasteList(authControl.religionMainIndex);
                        print(authControl.religionMainIndex);
                      }
                    },
                    // itemLabelBuilder: (String item) => item,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select Religion';
                      }
                      return null;
                    },
                  ),
                  // CustomDecoratedContainers(
                  //   child: DropdownButton<int>(
                  //     value: authControl.religionMainIndex,
                  //     items: authControl.religionList!.map((religion) {
                  //       return DropdownMenuItem<int>(
                  //         value: religion.id,
                  //         child: Text(religion.name!),
                  //       );
                  //     }).toList(),
                  //     onChanged: (int? value) {
                  //       if (value != null) {
                  //         var selectedReligion = authControl.religionList!.firstWhere((religion) => religion.id == value);
                  //         authControl.setReligionMainIndex(selectedReligion.id, true);
                  //         authControl.getCasteList(authControl.religionMainIndex);
                  //         print(authControl.religionMainIndex);
                  //       }
                  //     },
                  //     isExpanded: true,
                  //     underline: const SizedBox(),
                  //   ),
                  // ),
              //     CustomStyledDropdownButton(
              //   items: authControl.religionList!.map((religion) => religion.name!).toList(),
              //   onChanged: (value) {
              //     var selectedReligion = authControl.religionList!.firstWhere((religion) => religion.name == value);
              //     authControl.setReligionMainIndex(selectedReligion.id, true);
              //     authControl.getCasteList(authControl.religionMainIndex);
              //     print(authControl.religionMainIndex);
              //   },
              //   title: "Select Religion",
              //   selectedValue: authControl.religionList!.firstWhere((religion) => religion.id == authControl.religionMainIndex).name,
              // ),
                  sizedBox20(),
                  Text(
                    'Your Caste',
                    style: kManrope25Black.copyWith(fontSize: Dimensions.fontSize18),
                  ),
                  sizedBox12(),
                 authControl.casteList == null || authControl.casteList!.isEmpty ||
                     authControl.religionList == null ||  authControl.religionList!.isEmpty ||
                authControl.isLoading
                     ?
                Container(
                    height: 55,
                    width: Get.size.width,
                    padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5,color: Colors.black.withOpacity(0.50)),
                      color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radius5),
                    ),
                    child: const Center(child: Align(alignment: Alignment.centerLeft,
                        child: Text("Select Religion")))) :
                  CustomDropdownButtonFormField<String>(
                    value: authControl.casteList!.firstWhere((religion) => religion.id == authControl.casteMainIndex).name,// Assuming you have a selectedPosition variable
                    items: authControl.casteList!.map((position) => position.name!).toList(),
                    hintText: "Select Caste",
                    onChanged: (String? value) {
                      if (value != null) {
                        var selected = authControl.casteList!.firstWhere((position) => position.name == value);
                        authControl.setCasteMainIndex(selected.id, true);
                                print(authControl.casteMainIndex);
                      }
                    },
                    // itemLabelBuilder: (String item) => item,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select Caste';
                      }
                      return null;
                    },
                  ),
                  // authControl.casteList == null || authControl.casteList!.isEmpty?
                  // Container(
                  //     height: 50,
                  //     width: Get.size.width,
                  //     padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(width: 0.5,color: Colors.black.withOpacity(0.50)),
                  //       color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radius10),
                  //     ),
                  //     child: const Center(child: Align(alignment: Alignment.centerLeft,
                  //         child: Text("Please No Community For Selected Religion")))) :
                  // CustomDecoratedContainers(
                  //   child: DropdownButton<int>(
                  //     value: authControl.casteMainIndex,
                  //     items: authControl.casteList!.map((religion) {
                  //       return DropdownMenuItem<int>(
                  //         value: religion.id,
                  //         child: Text(religion.name!),
                  //       );
                  //     }).toList(),
                  //     onChanged: (int? value) {
                  //       if (value != null) {
                  //         var selected = authControl.casteList!.firstWhere((religion) => religion.id == value);
                  //         authControl.setCasteMainIndex(selected.id, true);
                  //         print(authControl.casteMainIndex);
                  //       }
                  //     },
                  //     isExpanded: true,
                  //     underline: const SizedBox(),
                  //   ),
                  // ),


                  sizedBox20(),
                  Text(
                    'Mother Tongue',
                    style: kManrope25Black.copyWith(fontSize: Dimensions.fontSize18),
                  ),
                  sizedBox12(),
                  CustomDropdownButtonFormField<String>(
                    value: authControl.motherTongueList!.firstWhere((religion) => religion.id == authControl.motherTongueIndex).name,// Assuming you have a selectedPosition variable
                    items: authControl.motherTongueList!.map((position) => position.name!).toList(),
                    hintText: "Select Mother Tongue",
                    onChanged: (String? value) {
                      if (value != null) {
                        var selected = authControl.motherTongueList!.firstWhere((position) => position.name == value);
                        authControl.setMotherTongueIndex(selected.id, true);
                        print(authControl.motherTongueIndex );
                      }
                    },
                    // itemLabelBuilder: (String item) => item,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Mother Tongue';
                      }
                      return null;
                    },
                  ),
                  sizedBox20(),
                  Text(
                    'Posting State',
                    style: kManrope25Black.copyWith(fontSize: 16),
                  ),
                  sizedBox12(),
                  CustomDropdownButtonFormField<String>(
                    value:  authControl.posselectedState,
                    items: authControl.posstates,
                    hintText: "Select Posting State",
                    onChanged: (value) {
                      authControl.possetState(value ?? authControl.posstates.first);
                      print('cadre =========== >${authControl.posstates}');
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == 'Please Posting State') {
                        return 'Please Posting State';
                      }
                      return null;
                    },
                  ),
                  sizedBox20(),
                  Text(
                    'Diet',
                    style: kManrope25Black.copyWith(fontSize: Dimensions.fontSize18),
                  ),
                  sizedBox12(),
                  CustomDropdownButtonFormField<String>(
                    value: authControl.diet ,
                    items: authControl.dietList,
                    hintText: "Select Diet Type",
                    onChanged: (value) {
                      authControl.setDiet(value!);
                      print(authControl.diet);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == 'Select Diet Type') {
                        return 'Please Select Your Diet Type';
                      }
                      return null;
                    },
                  ),

                  // CustomDecoratedContainers(
                  //   child: DropdownButton<int>(
                  //     value: authControl.motherTongueIndex,
                  //     items: authControl.motherTongueList!.map((religion) {
                  //       return DropdownMenuItem<int>(
                  //         value: religion.id,
                  //         child: Text(religion.name!),
                  //       );
                  //     }).toList(),
                  //     onChanged: (int? value) {
                  //       if (value != null) {
                  //         var selected = authControl.motherTongueList!.firstWhere((religion) => religion.id == value);
                  //         authControl.setMotherTongueIndex(selected.id, true);
                  //             print(authControl.motherTongueIndex );
                  //       }
                  //     },
                  //     isExpanded: true,
                  //     underline: const SizedBox(),
                  //   ),
                  // ),
                  // CustomStyledDropdownButton(
                  //   items: authControl.motherTongueList!.map((religion) => religion.name!).toList(),
                  //   onChanged: (value) {
                  //     var selectedReligion = authControl.motherTongueList!.firstWhere((religion) => religion.name == value);
                  //     authControl.setMotherTongueIndex(selectedReligion.id, true);
                  //
                  //     print(authControl.motherTongueIndex );
                  //   },
                  //   title: "Select Religion",
                  //   selectedValue: authControl.motherTongueList!.firstWhere((religion) => religion.id == authControl.motherTongueIndex ).name,
                  // ),
                  sizedBox20(),

                  // CustomStyledDropdownButton(
                  //   items: authControl.communityList!.map((religion) => religion.name!).toList(),
                  //   onChanged: (value) {
                  //     var selected = authControl.communityList!.firstWhere((religion) => religion.name == value);
                  //     authControl.setCommunityMainListIndex(selected.id, true);
                  //     print(authControl.communityMainIndex);
                  //   },
                  //   title: "Select Caste",
                  //   selectedValue: authControl.communityList!.firstWhere((religion) => religion.id == authControl.communityMainIndex).name,
                  // ),


                ],
              )


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
