import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/assets.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/views/signup/sign_up_screen_partner_expectation.dart';
import 'package:flutter/material.dart';
import '../../../getx/controllers/auth_controller.dart';
import '../../../getx/utils/colors.dart';
import '../../constants/fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SignUpScreenOne extends StatefulWidget {
  const SignUpScreenOne({
    super.key,
  });

  @override
  State<SignUpScreenOne> createState() => _SignUpScreenOneState();
  static final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  bool validate() {
    return _formKey1.currentState?.validate() ?? false;
  }
}

class _SignUpScreenOneState extends State<SignUpScreenOne> {
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phNoController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();

  final passwordController = TextEditingController();
  bool _passwordVisible = false;

  // final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fields();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getmarriedStatusList();
      fields();
    });

    super.initState();
  }

  void fields() {
    usernameController.text = Get.find<AuthController>().userName ?? '';
    firstNameController.text = Get.find<AuthController>().firstName ?? '';
    middleNameController.text = Get.find<AuthController>().middleName ?? '';
    lastNameController.text = Get.find<AuthController>().lastName ?? '';
    emailController.text = Get.find<AuthController>().email ?? '';
    phNoController.text = Get.find<AuthController>().phone ?? '';
    countryController.text = Get.find<AuthController>().country ?? '';
    stateController.text = Get.find<AuthController>().state ?? '';
    districtController.text = Get.find<AuthController>().district ?? '';
    passwordController.text = Get.find<AuthController>().email ?? '';
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (authControl) {
          return authControl.marriedStatusList == null || authControl.marriedStatusList!.isEmpty
              ?
          const Center(child: CircularProgressIndicator()) :
            SingleChildScrollView(

            child: Form(
              key: SignUpScreenOne._formKey1,
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
                        icProfileRegister,
                      ),
                    ),
                  ),
                  sizedBox20(),
                  Center(
                    child: Text(
                      'Welcome To Bureau Couple',
                      textAlign: TextAlign.center,
                      style: kManrope25Black.copyWith(fontSize: Dimensions.fontSize18),
                    ),
                  ),
                  Center(
                    child: Text("Let's Start Building Your Profile",
                      textAlign: TextAlign.center,
                      style: kManrope14Medium626262.copyWith(color: Colors.black),
                    ),
                  ),
                  sizedBox20(),
                  // sizedBox20(),
                  // Text(
                  //   'This Profile is for',
                  //   style: kManrope25Black,
                  // ),
                  // const SizedBox(height: 12,),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: ChipList(
                  //       elements: authControl.lookingForList,
                  //       onChipSelected: (value) {
                  //         authControl.setLookingFor(value);
                  //         print(authControl.lookingFor);
                  //       },
                  //       defaultSelected: "MySelf",
                  //     ),
                  //   ),
                  // ),
                  sizedBox20(),
                  Text(
                    'Your Gender',
                    style: kManrope25Black,
                  ),
                  const SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ChipList(
                        elements: authControl.genderList,
                        onChipSelected: (selectedGender) {
                          authControl.setGender(selectedGender);
                          print(authControl.gender);
                        },
                        defaultSelected: "Male",
                      ),),
                  ),
                  sizedBox20(),


                  Text(
                    'Marital Status',
                    style: kManrope25Black,
                  ),
                  sizedBox12(),

                  Wrap(
                    spacing: 8.0,
                    children: authControl.marriedStatusList!.map((religion) {
                    return ChoiceChip(
                      selectedColor: color4B164C.withOpacity(0.80),
                      backgroundColor: Colors.white,
                      label: Text(
                        religion.title!,
                        style: TextStyle(
                          color: authControl.marriedStatusIndex == religion.id
                              ? Colors.white
                              : Colors.black.withOpacity(0.80),
                        ),
                      ),
                      selected: authControl.marriedStatusIndex == religion.id,
                      onSelected: (selected) {
                        if (selected) {
                          authControl.setmarriedStatusIndex(religion.id!,true);
                          print(authControl.marriedStatusIndex);
                        }
                      },
                    );
                  }).toList(),
                  ),
                ],
              ),

              ///##### Old Signup Logic

              // Column(
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Sign Up',
              //           style: kManrope25Black,
              //         ),
              //         sizedBox8(),
              //         Text(
              //           "Start your journey towards everlasting love. Create an account and discover meaningful connections",
              //           style: kManrope14Medium626262,
              //         ),
              //         const SizedBox(
              //           height: 23,
              //         ),
              //         sizedBox6(),
              //         CustomTextField(
              //           showTitle: true,
              //           controller: usernameController,
              //           hintText: 'Username',
              //           validation: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Please enter username';
              //             } else if (value.length < 6) {
              //               return 'Username must be at least 6 characters long';
              //             } else if (!RegExp(r'^[a-z0-9]+$').hasMatch(value)) {
              //               return 'Username must not contain special characters, spaces, or capital letters';
              //             }
              //             return null;
              //           },
              //           onChanged: (value) {
              //             authControl.setUserName(usernameController.text);
              //           },
              //         ),
              //
              //         // CustomTextField(
              //         //   showTitle: true,
              //         //   controller: usernameController,
              //         //   hintText: 'Username',
              //         //   validation: (value) {
              //         //     if (value == null || value.isEmpty) {
              //         //       return 'Please enter username';
              //         //     } else if (!RegExp(r'^[a-z0-9]+$').hasMatch(value)) {
              //         //       return 'Username must not contain special characters, spaces, or capital letters';
              //         //     }
              //         //     return null;
              //         //   },
              //         //   onChanged: (value) {
              //         //     authControl.setUserName(usernameController.text);
              //         //   },
              //         // ),
              //
              //         // CustomTextField(
              //         //   capitalization: TextCapitalization.none,
              //         //   showTitle: true,
              //         //   controller: usernameController,
              //         //   hintText: 'Username',
              //         //   validation: (value) {
              //         //     if (value == null || value.isEmpty) {
              //         //       return 'Please Enter Username';
              //         //     }
              //         //     return null;
              //         //   },
              //         //   onChanged: (value) {
              //         //     authControl.setUserName(usernameController.text);
              //         //   },
              //         // ),
              //
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         sizedBox6(),
              //         Row(
              //           children: [
              //             Expanded(
              //               child: CustomTextField(
              //                 showTitle: true,
              //                 controller: firstNameController,
              //                 capitalization: TextCapitalization.words,
              //                 hintText: 'First Name',
              //                 onChanged: (value) {
              //                   authControl
              //                       .setFirstName(firstNameController.text);
              //                 },
              //                 validation: (value) {
              //                   if (value == null || value.isEmpty) {
              //                     return 'Please Enter First name';
              //                   }
              //                   return null;
              //                 },
              //               ),
              //             ),
              //             sizedBoxW10(),
              //             Expanded(
              //               child: CustomTextField(
              //                 showTitle: true,
              //                 capitalization: TextCapitalization.words,
              //                 controller: middleNameController,
              //                 hintText: 'Middle Name (optional)',
              //                 onChanged: (value) {
              //                   authControl
              //                       .setMiddleName(middleNameController.text);
              //                 },
              //               ),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 20),
              //         CustomTextField(
              //           showTitle: true,
              //           controller: lastNameController,
              //           capitalization: TextCapitalization.words,
              //           hintText: 'Last Name',
              //           validation: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Please Enter Last Name';
              //             }
              //             return null;
              //           },
              //           onChanged: (value) {
              //             authControl.setLastName(lastNameController.text);
              //           },
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         // CustomTextField(
              //         //   showTitle: true,
              //         //   controller: emailController,
              //         //   hintText: 'Email',
              //         //   validation: (value) {
              //         //     if (value == null || value.isEmpty) {
              //         //       return 'Please Enter your Email';
              //         //     }
              //         //     return null;
              //         //   },
              //         //   onChanged: (value) {
              //         //     authControl.setEmail(emailController.text);
              //         //   },
              //         // ),
              //         CustomTextField(
              //           showTitle: true,
              //           controller: emailController,
              //           hintText: 'Email',
              //           validation: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Please enter your email';
              //             } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
              //                 .hasMatch(value)) {
              //               return 'Please enter a valid email address';
              //             }
              //             return null;
              //           },
              //           onChanged: (value) {
              //             authControl.setEmail(emailController.text);
              //           },
              //         ),
              //
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         CustomTextField( showTitle: true,
              //           isNumber: true,
              //           controller: phNoController,
              //           hintText: 'Phone',
              //           validation: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Please Enter your Phone No';
              //             }
              //             return null;
              //           },
              //           onChanged: (value) {
              //             authControl.setPhone(phNoController.text);
              //           },
              //         ),
              //         const SizedBox(height: 20),
              //         /*   CustomTextField(
              //           readOnly: true,
              //           validation: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Please Enter your Country';
              //             }
              //             return null;
              //           },
              //           onChanged: (value) {
              //
              //           },
              //           onTap: () {
              //             showCountryPicker(
              //               context: context,
              //               countryListTheme: CountryListThemeData(
              //                 flagSize: 25,
              //                 backgroundColor: Colors.white,
              //                 textStyle: const TextStyle(
              //                     fontSize: 16, color: Colors.blueGrey),
              //                 bottomSheetHeight: 500,
              //                 borderRadius: const BorderRadius.only(
              //                   topLeft: Radius.circular(20.0),
              //                   topRight: Radius.circular(20.0),
              //                 ),
              //                 inputDecoration: InputDecoration(
              //                   labelText: 'Search',
              //                   hintText: 'Start typing to search',
              //                   prefixIcon: const Icon(Icons.search),
              //                   border: OutlineInputBorder(
              //                     borderSide: BorderSide(
              //                       color:
              //                           const Color(0xFF8C98A8).withOpacity(0.2),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               onSelect: (Country country) {
              //                 setState(() {
              //                   String selectedCountryName =
              //                       country.displayName.split(' ')[0] ?? '';
              //                   countryController.text = selectedCountryName;
              //                   authControl.setCountry(countryController.text);
              //
              //                 });
              //                 setState(() {
              //                   // SharedPrefs().setCountry(selectedCountryName);
              //                   // SharedPrefs().setCountryCode(country.countryCode);
              //                 });
              //               },
              //
              //
              //             );
              //
              //           },
              //           showTitle: true,
              //           controller: countryController,
              //           hintText: 'Country',
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),*/
              //
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text("Select State",
              //                 style: satoshiRegular.copyWith(
              //                   fontSize: Dimensions.fontSize12,
              //                 )),
              //             const SizedBox(height: 5),
              //             TypeAheadFormField<String>(
              //               textFieldConfiguration: TextFieldConfiguration(
              //                 controller: stateController,
              //                 decoration:
              //                     authDecoration(context, "Select State"),
              //               ),
              //               suggestionsCallback: (pattern) async {
              //                 return authControl.states
              //                     .where((state) => state
              //                         .toLowerCase()
              //                         .contains(pattern.toLowerCase()))
              //                     .toList();
              //               },
              //               itemBuilder: (context, suggestion) {
              //                 return ListTile(
              //                   title: Text(suggestion),
              //                 );
              //               },
              //               onSuggestionSelected: (String? suggestion) {
              //                 if (suggestion != null) {
              //                   authControl.setState(suggestion);
              //                   stateController.text = suggestion;
              //                   authControl.setstate(stateController.text);
              //                 }
              //               },
              //               validator: (value) {
              //                 if (value == null || value.isEmpty) {
              //                   return 'Please Select State';
              //                 }
              //                 return null;
              //               },
              //               onSaved: (value) => authControl.setState(value!),
              //             ),
              //           ],
              //         ),
              //
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text("Select District",
              //                 style: satoshiRegular.copyWith(
              //                   fontSize: Dimensions.fontSize12,
              //                 )),
              //             const SizedBox(height: 5),
              //             TypeAheadFormField<String>(
              //               textFieldConfiguration: TextFieldConfiguration(
              //                 controller: districtController,
              //                 decoration: const InputDecoration(
              //                   labelText: 'Select District',
              //                   border: OutlineInputBorder(),
              //                 ),
              //               ),
              //               suggestionsCallback: (pattern) async {
              //                 return authControl.districts
              //                     .where((state) => state
              //                         .toLowerCase()
              //                         .contains(pattern.toLowerCase()))
              //                     .toList();
              //               },
              //               itemBuilder: (context, suggestion) {
              //                 return ListTile(
              //                   title: Text(suggestion),
              //                 );
              //               },
              //               onSuggestionSelected: (String? suggestion) {
              //                 if (suggestion != null) {
              //                   // authControl.setDistrict(suggestion);
              //                   districtController.text = suggestion;
              //                   authControl.setDist(suggestion);
              //                 }
              //               },
              //               validator: (value) {
              //                 if (value == null || value.isEmpty) {
              //                   return 'Please District';
              //                 }
              //                 return null;
              //               },
              //               onSaved: (value) => authControl.setDistrict(value!),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         CustomTextField(
              //           showTitle: true,
              //           isPassword: true,
              //           controller: passwordController,
              //           validation: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Please Enter your Password';
              //             }
              //             return null;
              //           },
              //           onChanged: (value) {
              //             authControl.setPassword(passwordController.text);
              //           },
              //           hintText: 'Password',
              //         ),
              //       ],
              //     ),
              //     const SizedBox(
              //       height: 24,
              //     ),
              //   ],
              // ),
            ),
          );
        }),
      ),
    );
  }
}
