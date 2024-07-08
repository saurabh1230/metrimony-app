import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/features/widgets/custom_typeahead_field.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:flutter/material.dart';
import '../../../getx/controllers/auth_controller.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authControl) {
        return SingleChildScrollView(
          child: Form(
            key: SignUpScreenOne._formKey1,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: kManrope25Black,
                    ),
                    sizedBox8(),
                    Text(
                      "Start your journey towards everlasting love. Create an account and discover meaningful connections",
                      style: kManrope14Medium626262,
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    sizedBox6(),
                    CustomTextField(
                      showTitle: true,
                      controller: usernameController,
                      hintText: 'Username',
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Username';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        authControl.setUserName(usernameController.text);
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    sizedBox6(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
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
                              return null;
                            },
                          ),
                        ),
                        sizedBoxW10(),
                        Expanded(
                          child: CustomTextField(
                            showTitle: true,
                            capitalization: TextCapitalization.words,
                            controller: middleNameController,
                            hintText: 'Middle Name (optional)',
                            onChanged: (value) {
                              authControl.setMiddleName(middleNameController.text);

                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      showTitle: true,
                      controller: lastNameController,
                      capitalization: TextCapitalization.words,
                      hintText: 'Last Name',
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Last Name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        authControl.setLastName(lastNameController.text);

                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      showTitle: true,
                      controller: emailController,
                      hintText: 'Email',
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        authControl.setEmail(emailController.text);

                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      isNumber: true,
                      isAmount: true,
                      showTitle: true,
                      controller: phNoController,
                      hintText: 'Phone',
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Phone No';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        authControl.setPhone(phNoController.text);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                 /*   CustomTextField(
                      readOnly: true,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Country';
                        }
                        return null;
                      },
                      onChanged: (value) {

                      },
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.blueGrey),
                            bottomSheetHeight: 500,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country) {
                            setState(() {
                              String selectedCountryName =
                                  country.displayName.split(' ')[0] ?? '';
                              countryController.text = selectedCountryName;
                              authControl.setCountry(countryController.text);

                            });
                            setState(() {
                              // SharedPrefs().setCountry(selectedCountryName);
                              // SharedPrefs().setCountryCode(country.countryCode);
                            });
                          },


                        );

                      },
                      showTitle: true,
                      controller: countryController,
                      hintText: 'Country',
                    ),
                    const SizedBox(
                      height: 20,
                    ),*/

                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select State", style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12,)),
                        const SizedBox(height: 5),
                        TypeAheadFormField<String>(
                          textFieldConfiguration:  TextFieldConfiguration(
                            controller: stateController,
                            decoration: authDecoration(
                                context, "Select State"
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return authControl.states.where((state) => state.toLowerCase().contains(pattern.toLowerCase())).toList();
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (String? suggestion) {
                            if (suggestion != null) {
                              authControl.setState(suggestion);
                              stateController.text = suggestion;
                              authControl.setstate(stateController.text);


                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Select State';
                            }
                            return null;
                          },
                          onSaved: (value) => authControl.setState(value!),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select District", style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12,)),
                        const SizedBox(height: 5),
                        TypeAheadFormField<String>(
                          textFieldConfiguration:  TextFieldConfiguration(
                            controller: districtController,
                            decoration: const InputDecoration(
                              labelText: 'Select District',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return authControl.districts.where((state) => state.toLowerCase().contains(pattern.toLowerCase())).toList();
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
                              authControl.setDist(suggestion);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please District';
                            }
                            return null;
                          },
                          onSaved: (value) => authControl.setDistrict(value!),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      showTitle: true,
                      isPassword: true,
                      controller: passwordController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        authControl.setPassword(passwordController.text);
                      },
                      hintText: 'Password',),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
            // child: Column(
            //   children: [
            //   Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text('Sign Up',
            //             style: kManrope25Black,),
            //             sizedBox8(),
            //             Text("Start your journey towards everlasting love. Create an account and discover meaningful connections",
            //             style: kManrope14Medium626262,),
            //             const SizedBox(height: 23,),
            //             Text("Username",
            //               style: kManrope14Medium626262,),
            //             sizedBox6(),
            //             textBox(
            //               context: context,
            //               label: '',
            //               controller: usernameController,
            //               hint: '',
            //               length: 20,
            //               onChanged: (value) {
            //                 setState(() {
            //                   SharedPrefs().setUserName(usernameController.text);
            //                 });
            //
            //               },
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'Please enter a username';
            //                 } else if (value.length < 6) {
            //                   return 'username must be at least 6 characters long';
            //                 }
            //                 return null;
            //               },
            //             ),
            //
            //             const SizedBox(height: 20,),
            //             Text("First Name",
            //               style: kManrope14Medium626262,),
            //             sizedBox6(),
            //             textBox(
            //               capital: TextCapitalization.words,
            //                 context: context,
            //                 label: '',
            //                 controller: firstNameController,
            //
            //                 hint: '',
            //                 length: 20,
            //                 onChanged: (value) {
            //                   setState(() {
            //                     SharedPrefs().setName(firstNameController.text);
            //                   });
            //
            //                 },
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'Please enter your first name';
            //                 }
            //                 return null;
            //               },
            //                 ),
            //             const SizedBox(height: 20,),
            //
            //             Text("Last Name",
            //               style: kManrope14Medium626262,),
            //             sizedBox6(),
            //             textBox(
            //               capital: TextCapitalization.words,
            //                 context: context,
            //                 label: '',
            //                 controller: lastNameController,
            //                 hint: '',
            //                 length: 20,
            //                 onChanged: (value) {
            //                   setState(() {
            //                     SharedPrefs().setLastName(lastNameController.text);
            //                   });
            //                 },
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'Please enter your Last name';
            //                 }
            //                 return null;
            //               },),
            //             const SizedBox(height: 20,),
            //             Text("Email",
            //               style: kManrope14Medium626262,),
            //             sizedBox6(),
            //             textBox(
            //                 context: context,
            //                 label: '',
            //                 controller: emailController,
            //                 hint: '',
            //                 length: 30,
            //                 onChanged: (value) {
            //                   SharedPrefs().setEmail(emailController.text);
            //                 },
            //                 validator: (value) {
            //                   if (value == null || value.isEmpty) {
            //                     return 'Please enter your email';
            //                   } else if (!value.contains('@') || !value.contains('.com')) {
            //                     return 'enter Valid email';
            //                   }
            //                   return null;
            //                 },),
            //             const SizedBox(height: 20,),
            //             Text("Phone",
            //               style: kManrope14Medium626262,),
            //             sizedBox6(),
            //             textBoxPrefixIcon(
            //                 context: context,
            //                 label: '',
            //                 controller: phNoController,
            //                 hint: '',
            //                 validator: (value) {
            //                   if (value == null || value.isEmpty) {
            //                     return 'Please enter your Phone no';
            //                   }
            //                   return null;
            //                 }, onChanged: (value) {
            //                   setState(() {
            //                     SharedPrefs().setPhone(phNoController.text);
            //                   });
            //             }, length: 10),
            //             const SizedBox(height: 20,),
            //
            //             Text("Password",
            //               style: kManrope14Medium626262,),
            //             sizedBox6(),
            //             textBoxSuffixIcon(
            //                 suffixOnTap: () {
            //                   setState(() {
            //                     _passwordVisible = !_passwordVisible;
            //                   });
            //                 },
            //                 context: context,
            //                 label: '',
            //                 controller: passwordController,
            //                 hint: '',
            //                 length: null,
            //                 suffixIcon: _passwordVisible
            //                     ? const Icon(Icons.visibility)
            //                     : const Icon(Icons.visibility_off),
            //                 validator: (value) {
            //                   if (value == null || value.isEmpty) {
            //                     return 'Please set a password';
            //                   } else if (value.length < 6) {
            //                     return 'Password must be at least 6 characters long';
            //                   }
            //                   return null;
            //                 }, bool: _passwordVisible,
            //                 onChanged: (value) {
            //                   SharedPrefs().setPassword(passwordController.text);
            //                 }),
            //           ],
            //         ),
            //     const SizedBox(height: 24,),
            //   ],
            // ),
          ),
        );
      }),
    );
  }
}
