import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_picker/country_picker.dart';
import '../../constants/textfield.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/buttons.dart';
import '../../utils/widgets/dropdown_buttons.dart';

class SignUpScreenTwo extends StatefulWidget {

  const SignUpScreenTwo({super.key,});

  @override
  State<SignUpScreenTwo> createState() => _SignUpScreenTwoState();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validate() {
    return _formKey.currentState?.validate() ?? false;
  }
}

class _SignUpScreenTwoState extends State<SignUpScreenTwo> {

  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();

  final List<String> elements = ['My Self', 'My Son', 'My Sister', 'My Daughter', 'My Brother','My Friend','My Relative'];
  final List<String> gender = ["M","F"];
  final List<String> religion = ["Hindu","Muslim","Jain",'Buddhist','Sikh','Marathi'];
  final List<String> married = ["Unmarried","Married","Widowed","Divorced"];

  final countryController = TextEditingController();
  final profileController = TextEditingController();
  final countyController = TextEditingController();
  final genderController = TextEditingController();
  final motherTongue = TextEditingController();
  final professionController = TextEditingController();
  bool picked = false;
  String selectedCountryName = '';
  String? selectedValue;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: SignUpScreenTwo._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 50,),

             /* Center(
                child: pickedImage.path.isEmpty
                    ? GestureDetector(
                  onTap:  () async {
                    XFile? v = await _imgPicker.pickImage(
                        source: ImageSource.gallery);
                    if (v != null) {
                      setState(
                            () {
                          pickedImage = File(v.path);
                        },
                      );
                    }

                  },
                      child: Image.asset(
                                      icProfilePlaceHolder,
                                      fit: BoxFit.cover,
                                      height: 130,
                                    ),
                    )
                    : Image.file(
                  pickedImage,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),*/
              SizedBox(height: 30,),
              /*Align(
                alignment: Alignment.centerLeft,
                child: Text("This profile is for",
                textAlign: TextAlign.left,
                style: styleSatoshiBold(size: 16, color: Colors.black),),
              ),
              const SizedBox(height: 12,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ChipList(
                    elements: elements,
                    onChipSelected: (selectedProfile) {
                      // Handle selected profile
                      print(selectedProfile);
                      setState(() {
                        SharedPrefs().setProfileFor(selectedProfile);
                      });
                    },
                    defaultSelected: 'My Self',
                  ),),*/
              const SizedBox(height: 12,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Religion",
                  textAlign: TextAlign.left,
                  style: styleSatoshiBold(size: 16, color: Colors.black),),
              ),
              const SizedBox(height: 12,),
              Align(
                alignment: Alignment.centerLeft,
                child: ChipList(
                  elements: religion,
                  onChipSelected: (selectReligion) {
                    // Handle selected profile
                    print(selectReligion);
                    setState(() {
                      SharedPrefs().setReligion(selectReligion);
                    });
                  },
                  defaultSelected: 'Hindu',
                ),),
              const SizedBox(height: 12,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Gender",
                  textAlign: TextAlign.left,
                  style: styleSatoshiBold(size: 16, color: Colors.black),),
              ),
              const SizedBox(height: 12,),
              Align(
                alignment: Alignment.centerLeft,
                  child: ChipList(
                    elements: gender,
                    onChipSelected: (selectedGender) {
                      // Handle selected gender
                      print(selectedGender);
                      setState(() {
                        SharedPrefs().setGender(selectedGender);


                        // print(SharedPrefs().getGender());
                      });
                    },
                    defaultSelected: "M",
                  ),),
              const SizedBox(height: 12,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Married Status",
                  textAlign: TextAlign.left,
                  style: styleSatoshiBold(size: 16, color: Colors.black),),
              ),
              const SizedBox(height: 12,),
              Align(
                alignment: Alignment.centerLeft,
                child: ChipList(
                  elements: married,
                  onChipSelected: (marriedStatus) {
                    // Handle selected gender
                    print(marriedStatus);
                    setState(() {
                      SharedPrefs().setMaritalStatus(marriedStatus);
                    });
                  },
                  defaultSelected: "Unmarried",
                ),),
              sizedBox12(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Country",
                  textAlign: TextAlign.left,
                  style: styleSatoshiBold(size: 16, color: Colors.black),),
              ),
              const SizedBox(height: 12,),

              textBoxPickerField(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight: 500, // Optional. Country list modal height
                        //Optional. Sets the border radius for the bottomsheet.
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        //Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      onSelect: (Country country) {
                        setState(() {
                          selectedCountryName = country.displayName.split(' ')[0] ?? '';
                          countyController.text = selectedCountryName;
                        });
                        print(countyController.text);
                        print(selectedCountryName);
                        print(country.countryCode);
                        print('Select country: ${country.displayName}');

                        setState(() {
                          SharedPrefs().setCountry(selectedCountryName);
                          SharedPrefs().setCountryCode(country.countryCode);
                        });
                        // Call a function or update the state here
                        // Example: updateSelectedCountry(country);
                      },
                    );
                    setState(() {

                    });
                  },
                  context: context,
                  label: '',
                  controller: countyController,
                  hint: '',
                  length: null,
                  suffixIcon: Icon(Icons.visibility_off),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Country';
                    }
                    return null;
                  },
                onChanged: (value) {
                    // SharedPrefs().setCountry(countyController.text);
                    }, icon: Icons.flag,),
              sizedBox12(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Mother Tongue",
                  textAlign: TextAlign.left,
                  style: styleSatoshiBold(size: 16, color: Colors.black),),
              ),
              const SizedBox(height: 12,),

              textBox(
                context: context,
                label: '',
                controller: motherTongue,
                hint: '',
                length: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Mother Tongue';
                    }
                    return null;
                  },
                onChanged: (value) {
                  SharedPrefs().setMotherTongue(motherTongue.text);
                },),
              sizedBox12(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Profession",
                  textAlign: TextAlign.left,
                  style: styleSatoshiBold(size: 16, color: Colors.black),),
              ),
              const SizedBox(height: 12,),

              textBox(
                context: context,
                label: '',
                controller: professionController,
                hint: '',
                length: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Profession';
                  }
                  return null;
                },
                onChanged: (value) {
                  SharedPrefs().setProfession(professionController.text);
                },),


            ],
          ),
        ),
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
            style: TextStyle(color: Colors.red),
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
