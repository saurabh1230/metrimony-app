
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
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

  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();

  final List<String> elements = ['My Self', 'My Son', 'My Sister', 'My Daughter', 'My Brother','My Friend','My Relative'];
  final List<String> gender = ["Male","Female","Other"];
  final List<String> religion = ["Hindu","Muslim","Jain",'Buddhist','Sikh','Christian'];
  final List<String> married = ["Unmarried","Widowed","Divorced"];
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
  final _communityController = TextEditingController();
  bool picked = false;
  String selectedCountryName = '';
  String? selectedValue;

  String? motherTongueValue;
  String motherTongueFilter = '';

  String? communityValue ;
  String communityFilter = '';

  String? userTypeValue;
  String userTypeFilter = '';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getReligionsList();
      Get.find<AuthController>().getCommunityList();
      Get.find<AuthController>().getMotherTongueList();

    });
    String? selectedSuggestion;


    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authControl) {
        print(authControl.religionList);
        return (authControl.communityList == null || authControl.communityList!.isEmpty ||
            authControl.religionList == null || authControl.religionList!.isEmpty ||
            authControl.motherTongueList == null || authControl.motherTongueList!.isEmpty) ?
        const Center(child: CircularProgressIndicator()) :
         SingleChildScrollView(
          child: Form(
            key: SignUpScreenTwo._formKey2,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 50,),
                Text('Personal Info',
                  style: kManrope25Black,),
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Gender",
                    textAlign: TextAlign.left,
                    style: styleSatoshiBold(size: 16, color: Colors.black),),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ChipList(
                      elements: gender,
                      onChipSelected: (selectedGender) {
                        setState(() {
                          authControl.setGender(
                              selectedGender == "Male" ? "M" : selectedGender == "Female" ? "F" : "O"
                          );
                          // SharedPrefs().setGender(selectedGender);
                          // SharedPrefs().getGender();
                        });
                      },
                      defaultSelected: "Male",
                    ),),
                ),
                const SizedBox(height: 20,),
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
                      color: authControl.religionMainIndex == religion.id
                          ? Colors.white
                          : Colors.black.withOpacity(0.80),
                    ),
                  ),
                  selected: authControl.religionMainIndex == religion.id,
                  onSelected: (selected) {
                    if (selected) {
                      authControl.setReligionMainIndex(religion.id, true);
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

                      label: Text(religion.name! ,style: TextStyle(color: authControl.communityMainIndex == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                      selected: authControl.communityMainIndex == religion.id,
                      onSelected: (selected) {
                        if (selected) {
                          authControl.setCommunityMainListIndex(religion.id, true);
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

                      label: Text(religion.name! ,style: TextStyle(color: authControl.motherTongueIndex == religion.id ? Colors.white : Colors.black.withOpacity(0.80),),), // Adjust to match your ReligionModel structure
                      selected: authControl.motherTongueIndex == religion.id,
                      onSelected: (selected) {
                        if (selected) {
                          authControl.setMotherTongueIndex(religion.id, true);
                        }
                      },
                    );
                  }).toList(),
                ),


                const SizedBox(height: 20,),


              /*  Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Community",
                    textAlign: TextAlign.left,
                    style: styleSatoshiBold(size: 16, color: Colors.black),),
                ),
                const SizedBox(height: 12,), // P
                // TypeAheadField<String>(
                //   textFieldConfiguration: TextFieldConfiguration(
                //     onTap: () {_communityController.clear();},
                //     controller: _communityController,
                //     enabled: authControl.isLoading ? false : true,
                //     decoration:  InputDecoration(
                //       labelText: authControl.isLoading ? 'Please Wait' : selectedSuggestion == null ? "Select MLA" : "$selectedSuggestion",
                //       border: OutlineInputBorder(),
                //     ),
                //   ),
                //   suggestionsCallback: (pattern) async {
                //     // Map MlaModel objects to their names and filter based on the pattern
                //     final suggestions = authControl.communityList!
                //         .where((element) => element.name!.toLowerCase().contains(pattern.toLowerCase()))
                //         .map((mlaModel) => mlaModel.name!)
                //         .toList();
                //     return suggestions;
                //   },
                //   itemBuilder: (context, String suggestion) {
                //     return ListTile(
                //       title: Text(suggestion),
                //     );
                //   },
                //   onSuggestionSelected: (String suggestion) {
                //     final selectedItem = authControl.communityList!.firstWhere(
                //             (element) => element.name == suggestion);
                //     final selectedIndex = authControl.communityList!.indexOf(selectedItem) + 1;
                //     authControl.setCommunityMainListIndex(selectedIndex, true);
                //     selectedSuggestion = suggestion;
                //     _communityController.text = suggestion;
                //   },
                //
                // ),

                SizedBox(
                  width: 1.sw,
                  child: CustomStyledDropdownButton(
                    items: const  [
                      "Brahmin",
                      "Rajput",
                      'Kamma',
                      "Yadav",
                      'Gupta',
                      'Sikh',
                      'Punjabi',
                      'Aggarwal',
                      'Muslim',
                      "Marathi"
                    ],
                    selectedValue: communityValue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Community';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        communityValue = value;
                        communityFilter = communityValue ?? '';
                        SharedPrefs().setCommunity( StringUtils.capitalize(communityFilter));

                      });

                    },
                    title: 'Community',
                  ),
                ),
                sizedBox12(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Mother Tongue",
                    textAlign: TextAlign.left,
                    style: styleSatoshiBold(size: 16, color: Colors.black),),
                ),
                const SizedBox(height: 12,), // P
                SizedBox(
                  width: 1.sw,
                  child: CustomStyledDropdownButton(
                    items: const  [
                      "Hindi",
                      "Bhojpuri",
                      'Marathi',
                      "Bengali",
                      'Odia',
                      'Gujarati',
                      'Urdu',
                      "Punjabi",
                    ],
                    selectedValue: motherTongueValue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Mother Tongue';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        motherTongueValue = value;
                        motherTongueFilter = motherTongueValue ?? '';
                        SharedPrefs().setMotherTongue(motherTongueFilter);

                      });
                    },
                    title: 'Mother Tongue',
                  ),
                ),*/
                // adding

                sizedBox12(),
              ],
            ),
          ),
        );
    } )

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
