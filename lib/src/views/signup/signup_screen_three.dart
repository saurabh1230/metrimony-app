//
// import 'package:bureau_couple/src/constants/colors.dart';
// import 'package:bureau_couple/src/constants/shared_prefs.dart';
// import 'package:bureau_couple/src/constants/sizedboxe.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:country_picker/country_picker.dart';
// import '../../constants/string.dart';
// import '../../constants/textfield.dart';
// import '../../constants/textstyles.dart';
// import '../../utils/widgets/dropdown_buttons.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class SignUpScreenThree extends StatefulWidget {
//
//   const SignUpScreenThree({super.key,});
//
//   @override
//   State<SignUpScreenThree> createState() => _SignUpScreenThreeState();
//   static final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
//   bool validate() {
//     return _formKey2.currentState?.validate() ?? false;
//   }
// }
//
// class _SignUpScreenThreeState extends State<SignUpScreenThree> {
//
//   File pickedImage = File("");
//   final ImagePicker _imgPicker = ImagePicker();
//
//   final List<String> elements = ['My Self', 'My Son', 'My Sister', 'My Daughter', 'My Brother','My Friend','My Relative'];
//   final List<String> gender = ["Male","Female","Other"];
//   final List<String> religion = ["Hindu","Muslim","Jain",'Buddhist','Sikh','Christian'];
//   final List<String> married = ["Unmarried","Widowed","Divorced"];
//
//   final countryController = TextEditingController();
//   final profileController = TextEditingController();
//   final countyController = TextEditingController();
//   final stateController = TextEditingController();
//   final districtController = TextEditingController();
//   final genderController = TextEditingController();
//   final motherTongue = TextEditingController();
//   final professionController = TextEditingController();
//   final ageController = TextEditingController();
//   bool picked = false;
//   String selectedCountryName = '';
//   String? selectedValue;
//
//   String? motherTongueValue;
//   String motherTongueFilter = '';
//
//   String? communityValue ;
//   String communityFilter = '';
//
//   String? userTypeValue;
//   String userTypeFilter = '';
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: SignUpScreenTwo._formKey2,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // SizedBox(height: 50,),
//
//               /* Center(
//                 child: pickedImage.path.isEmpty
//                     ? GestureDetector(
//                   onTap:  () async {
//                     XFile? v = await _imgPicker.pickImage(
//                         source: ImageSource.gallery);
//                     if (v != null) {
//                       setState(
//                             () {
//                           pickedImage = File(v.path);
//                         },
//                       );
//                     }
//
//                   },
//                       child: Image.asset(
//                                       icProfilePlaceHolder,
//                                       fit: BoxFit.cover,
//                                       height: 130,
//                                     ),
//                     )
//                     : Image.file(
//                   pickedImage,
//                   height: 130,
//                   fit: BoxFit.cover,
//                 ),
//               ),*/
//               const  SizedBox(height: 30,),
//               /*Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("This profile is for",
//                 textAlign: TextAlign.left,
//                 style: styleSatoshiBold(size: 16, color: Colors.black),),
//               ),
//               const SizedBox(height: 12,),
//               Align(
//                   alignment: Alignment.centerLeft,
//                   child: ChipList(
//                     elements: elements,
//                     onChipSelected: (selectedProfile) {
//                       // Handle selected profile
//                       print(selectedProfile);
//                       setState(() {
//                         SharedPrefs().setProfileFor(selectedProfile);
//                       });
//                     },
//                     defaultSelected: 'My Self',
//                   ),),*/
//               const SizedBox(height: 12,),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Religion",
//                   textAlign: TextAlign.left,
//                   style: styleSatoshiBold(size: 16, color: Colors.black),),
//               ),
//               const SizedBox(height: 12,),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: ChipList(
//                   elements: religion,
//                   onChipSelected: (selectReligion) {
//                     // Handle selected profile
//                     setState(() {
//                       SharedPrefs().setReligion(selectReligion);
//                     });
//                   },
//                   defaultSelected: 'Hindu',
//                 ),),
//               const SizedBox(height: 12,),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Gender",
//                   textAlign: TextAlign.left,
//                   style: styleSatoshiBold(size: 16, color: Colors.black),),
//               ),
//               const SizedBox(height: 12,),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: ChipList(
//                   elements: gender,
//                   onChipSelected: (selectedGender) {
//                     setState(() {
//                       SharedPrefs().setGender(selectedGender);
//                       SharedPrefs().getGender();
//                     });
//                   },
//                   defaultSelected: "Male",
//                 ),),
//               /* GestureDetector(
//              onTap: () {
//                print(SharedPrefs().getGender());
//                print(SharedPrefs().getReligion());
//              },
//                child: Text("data")),*/
//               /*   const SizedBox(height: 12,),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Married Status",
//                   textAlign: TextAlign.left,
//                   style: styleSatoshiBold(size: 16, color: Colors.black),),
//               ),
//               const SizedBox(height: 12,),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: ChipList(
//                   elements: married,
//                   onChipSelected: (marriedStatus) {
//                     // Handle selected gender
//
//                     setState(() {
//                       SharedPrefs().setMaritalStatus(marriedStatus);
//                     });
//                   },
//                   defaultSelected: "Unmarried",
//                 ),),*/
//               // const SizedBox(height: 12,),
//               // Align(
//               //   alignment: Alignment.centerLeft,
//               //   child: Text("Age",
//               //     textAlign: TextAlign.left,
//               //     style: styleSatoshiBold(size: 16, color: Colors.black),),
//               // ),
//               // const SizedBox(height: 12,),
//               //
//               // textBox(  capital: TextCapitalization.words,
//               //   context: context,
//               //   label: '',
//               //   controller: ageController,
//               //   hint: '',
//               //   length: null,
//               //   validator: (value) {
//               //     if (value == null || value.isEmpty) {
//               //       return 'Please enter your Age';
//               //     }
//               //     return null;
//               //   },
//               //   onChanged: (value) {
//               //     SharedPrefs().setAge( StringUtils.capitalize(ageController.text));
//               //   },),
//               const SizedBox(height: 12,),
//               sizedBox12(),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Country",
//                   textAlign: TextAlign.left,
//                   style: styleSatoshiBold(size: 16, color: Colors.black),),
//               ),
//               const SizedBox(height: 12,),
//               textBoxPickerField(
//                 onTap: () {
//                   showCountryPicker(
//                     context: context,
//                     countryListTheme: CountryListThemeData(
//                       flagSize: 25,
//                       backgroundColor: Colors.white,
//                       textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
//                       bottomSheetHeight: 500,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20.0),
//                         topRight: Radius.circular(20.0),
//                       ),
//                       inputDecoration: InputDecoration(
//                         labelText: 'Search',
//                         hintText: 'Start typing to search',
//                         prefixIcon: const Icon(Icons.search),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: const Color(0xFF8C98A8).withOpacity(0.2),
//                           ),
//                         ),
//                       ),
//                     ),
//                     onSelect: (Country country) {
//                       setState(() {
//                         selectedCountryName = country.displayName.split(' ')[0] ?? '';
//                         countyController.text = selectedCountryName;
//                       });
//                       setState(() {
//                         SharedPrefs().setCountry(selectedCountryName);
//                         SharedPrefs().setCountryCode(country.countryCode);
//                       });
//                     },
//                   );
//                   setState(() {});
//                 },
//                 context: context,
//                 label: '',
//                 controller: countyController,
//                 hint: '',
//                 length: null,
//                 suffixIcon: const  Icon(Icons.visibility_off),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your Country';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                 }, icon: Icons.flag,),
//               sizedBox12(),
//
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("State",
//                   textAlign: TextAlign.left,
//                   style: styleSatoshiBold(size: 16, color: Colors.black),),
//               ),
//               const SizedBox(height: 12,),
//
//               textBox(  capital: TextCapitalization.words,
//                 context: context,
//                 label: '',
//                 controller: stateController,
//                 hint: '',
//                 length: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your State';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   SharedPrefs().setState( StringUtils.capitalize(stateController.text));
//                 },),
//               sizedBox12(),
//
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("District",
//                   textAlign: TextAlign.left,
//                   style: styleSatoshiBold(size: 16, color: Colors.black),),
//               ),
//               const SizedBox(height: 12,),
//
//               textBox(  capital: TextCapitalization.words,
//                 context: context,
//                 label: '',
//                 controller: districtController,
//                 hint: '',
//                 length: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your District';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   SharedPrefs().setState( StringUtils.capitalize(districtController.text));
//                 },),
//
//               const SizedBox(height: 12,),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Community",
//                   textAlign: TextAlign.left,
//                   style: styleSatoshiBold(size: 16, color: Colors.black),),
//               ),
//               const SizedBox(height: 12,), // P
//               SizedBox(
//                 width: 1.sw,
//                 child: CustomStyledDropdownButton(
//                   items: const  [
//                     "Brahmin",
//                     "Rajput",
//                     'Kamma',
//                     "Yadav",
//                     'Gupta',
//                     'Sikh',
//                     'Punjabi',
//                     'Aggarwal',
//                     'Muslim',
//                     "Marathi"
//                   ],
//                   selectedValue: communityValue,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Community';
//                     }
//                     return null;
//                   },
//                   onChanged: (String? value) {
//                     setState(() {
//                       communityValue = value;
//                       communityFilter = communityValue ?? '';
//                       SharedPrefs().setCommunity( StringUtils.capitalize(communityFilter));
//
//                     });
//
//                   },
//                   title: 'Community',
//                 ),
//               ),
//               sizedBox12(),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Mother Tongue",
//                   textAlign: TextAlign.left,
//                   style: styleSatoshiBold(size: 16, color: Colors.black),),
//               ),
//               const SizedBox(height: 12,), // P
//               SizedBox(
//                 width: 1.sw,
//                 child: CustomStyledDropdownButton(
//                   items: const  [
//                     "Hindi",
//                     "Bhojpuri",
//                     'Marathi',
//                     "Bengali",
//                     'Odia',
//                     'Gujarati',
//                     'Urdu',
//                     "Punjabi",
//                   ],
//                   selectedValue: motherTongueValue,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Mother Tongue';
//                     }
//                     return null;
//                   },
//                   onChanged: (String? value) {
//                     setState(() {
//                       motherTongueValue = value;
//                       motherTongueFilter = motherTongueValue ?? '';
//                       SharedPrefs().setMotherTongue(motherTongueFilter);
//
//                     });
//                     // print(userTypeFilter);
//                     // print('Check ======> Usetype${userTypeFilter}');
//                   },
//                   title: 'Mother Tongue',
//                 ),
//               ),
//               // adding(
//               /*          SizedBox(
//                   width: 1.sw,
//                   child: CustomStyledDropdownButton(
//                     items: const  [
//                       "Hindi"
//                       "Bhojpuri",
//                       'Marathi',
//                       "Bengali",
//                       'Odia',
//                       'Gujarati',
//                     ],
//                     selectedValue: motherTongueValue,
//                     onChanged: (String? value) {
//                       setState(() {
//                         motherTongueValue = value;
//                         motherTongueFilter = motherTongueValue ?? '';
//                         SharedPrefs().setMotherTongue( StringUtils.capitalize(motherTongueFilter));
//
//                       });
//                     },
//                     title: 'Mother Tongue',
//                   ),
//                 ),*/
//
//
//               /* textBox(  capital: TextCapitalization.words,
//                 context: context,
//                 label: '',
//                 controller: motherTongue,
//                 hint: '',
//                 length: null,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your Mother Tongue';
//                     }
//                     return null;
//                   },
//                 onChanged: (value) {
//                   SharedPrefs().setMotherTongue( StringUtils.capitalize(motherTongue.text));
//                   // SharedPrefs().setMotherTongue(motherTongue.text);
//                 },),*/
//
//
//               sizedBox12(),
//               // Align(
//               //   alignment: Alignment.centerLeft,
//               //   child: Text("User Type",
//               //     textAlign: TextAlign.left,
//               //     style: styleSatoshiBold(size: 16, color: Colors.black),),
//               // ),
//               // const SizedBox(height: 12,),
//               // SizedBox(
//               //   width: 1.sw,
//               //   child: CustomStyledDropdownButton(
//               //     items: const  [
//               //       "Exclusive",
//               //       'Normal',
//               //       "Premium",
//               //     ],
//               //     selectedValue: userTypeValue,
//               //     validator: (value) {
//               //       if (value == null || value.isEmpty) {
//               //         return 'Please enter usertype';
//               //       }
//               //       return null;
//               //     },
//               //     onChanged: (String? value) {
//               //       setState(() {
//               //         userTypeValue = value;
//               //         userTypeFilter = userTypeValue ?? '';
//               //         SharedPrefs().setUserType(userTypeFilter == "Exclusive" ? "1" :userTypeFilter == "Normal" ? "2" :"1");
//               //
//               //       });
//               //       // print(userTypeFilter);
//               //       // print('Check ======> Usetype${userTypeFilter}');
//               //     },
//               //     title: 'User Type',
//               //   ),
//               // ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class ChipList extends StatefulWidget {
//   final List<dynamic> elements;
//   final Function(dynamic) onChipSelected;
//   final dynamic? defaultSelected;
//
//   const ChipList({
//     Key? key,
//     required this.elements,
//     required this.onChipSelected,
//     this.defaultSelected,
//   }) : super(key: key);
//
//   @override
//   _ChipListState createState() => _ChipListState();
// }
//
// class _ChipListState extends State<ChipList> {
//   late dynamic selectedChip;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     selectedChip = widget.defaultSelected ?? '';
//     // selectedChip = widget.defaultSelected ?? widget.elements.first; // Set the default selected chip
//     errorMessage = '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 8.0,
//           runSpacing: 8.0,
//           children: widget.elements.map((e) => ChipBox(value: e)).toList(),
//         ),
//         if (errorMessage.isNotEmpty)
//           Text(
//             errorMessage,
//             style: const TextStyle(color: Colors.red),
//           ),
//       ],
//     );
//   }
//
//   void handleChipSelected(dynamic chipValue) {
//     if (validateChip(chipValue)) {
//       setState(() {
//         selectedChip = chipValue;
//         widget.onChipSelected(selectedChip);
//         errorMessage = '';
//       });
//     } else {
//       setState(() {
//         errorMessage = 'Invalid chip selected';
//       });
//     }
//   }
//
//   bool validateChip(dynamic chipValue) {
//     return chipValue != null; // Simple validation: Check if the chipValue is not null
//   }
// }
//
// class ChipBox extends StatelessWidget {
//   final dynamic value;
//
//   const ChipBox({Key? key, required this.value}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final _ChipListState chipListState =
//     context.findAncestorStateOfType<_ChipListState>()!;
//
//     return ActionChip(
//       onPressed: () {
//         chipListState.handleChipSelected(value);
//       },
//       backgroundColor:
//       value == chipListState.selectedChip ? color4B164C.withOpacity(0.80) : Colors.white,
//       label: Text(
//         value.toString(),
//         style:
//         TextStyle(
//           fontSize: 16,
//           color: value == chipListState.selectedChip ? Colors.white : color4B164C.withOpacity(0.80),
//         ),
//       ),
//     );
//   }
// }
