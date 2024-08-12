
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_dropdown_button_field.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/widgets/dropdown_buttons.dart';

class SignUpScreenProfessionLocationScreen extends StatefulWidget {

  const SignUpScreenProfessionLocationScreen({super.key,});

  @override
  State<SignUpScreenProfessionLocationScreen> createState() => _SignUpScreenProfessionLocationScreenState();
  static final GlobalKey<FormState> _formKeyprofessionLocation = GlobalKey<FormState>();
  bool validate() {
    return _formKeyprofessionLocation.currentState?.validate() ?? false;
  }
}

class _SignUpScreenProfessionLocationScreenState extends State<SignUpScreenProfessionLocationScreen> {

  final highestDegreeController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final instituteController = TextEditingController();
  final startDateController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void initState() {
    fields();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getProfessionList();
      Get.find<AuthController>().getPositionHeldList();
      // Get.find<AuthController>().clearStateDistrict();

      // Get.find<AuthController>().getMotherTongueList();

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
          return authControl.professionList == null || authControl.professionList!.isEmpty ||
              authControl.positionHeldList == null || authControl.positionHeldList!.isEmpty ?
          const Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            child: Form(key: SignUpScreenProfessionLocationScreen._formKeyprofessionLocation,
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
                          icProfessionRegister,
                        ),
                      ),
                    ),
                    sizedBox20(),
                    Center(
                      child: Text("Now Let's Add Professional Posting Details",
                        textAlign: TextAlign.center,
                        style: kManrope14Medium626262.copyWith(color: Colors.black),
                      ),
                    ),
                    // sizedBox20(),
                    // Text(
                    //   'Cadre',
                    //   style: kManrope25Black.copyWith(fontSize: 16),
                    // ),
                    // sizedBox12(),
                    // CustomDropdownButtonFormField<String>(
                    //   value:  authControl.cadar ?? authControl.cadarList.first,
                    //   items: authControl.cadarList,
                    //   hintText: "Select Highest Degree",
                    //   onChanged: (value) {
                    //     authControl.setCadar(value ?? authControl.cadarList.first);
                    //     print('cadre =========== >${authControl.cadar}');
                    //   },
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty || value == 'Select Cadre') {
                    //       return 'Please Select Select Cadre';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // CustomStyledDropdownButton(
                    //   title: "Select Cadre",
                    //   items: authControl.cadarList,
                    //   selectedValue: authControl.cadar ?? authControl.cadarList.first,
                    //   onChanged: (value) {
                    //     authControl.setCadar(value ?? authControl.cadarList.first);
                    //     print('cadre =========== >${authControl.cadar}');
                    //   },
                    // ),
                    /* sizedBox20(),
                    Text(
                      'Batch Year',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomStyledDropdownButton(
                      title: "Batch Year",
                      items: authControl.batchYearList,
                      selectedValue: authControl.batchYear ?? authControl.batchYearList.first,
                      onChanged: (value) {
                        authControl.setBatchYear(value ?? authControl.batchYearList.first);
                        print(authControl.batchYear);
                      },
                    ),*/
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

                    // CustomStyledDropdownButton(
                    //   title: "Select State/UT",
                    //   items: authControl.posstates,
                    //   selectedValue: authControl.posselectedState,
                    //   onChanged: (value) {
                    //     authControl.possetState(value ?? authControl.posstates.first);
                    //   },
                    //   validator: (val) {
                    //     if (val == null || val.isEmpty || val == 'Select State') {
                    //       return 'Please Select State';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    // sizedBox20(),
                    // Text(
                    //   'Posting District',
                    //   style: kManrope25Black.copyWith(fontSize: 16),
                    // ),
                    // sizedBox12(),
                    // CustomDropdownButtonFormField<String>(
                    //   value:  authControl.posselectedDistrict,
                    //   items: authControl.posdistricts,
                    //   hintText: "Please Select district",
                    //   onChanged: (value) {
                    //     authControl.possetDistrict(value ?? authControl.posdistricts.first);
                    //   },
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty || value == 'Please Select Posting District') {
                    //       return 'Please Select Posting District';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // CustomStyledDropdownButton(
                    //   title: "Select District",
                    //   items: authControl.posdistricts,
                    //   selectedValue: authControl.posselectedDistrict,
                    //   onChanged: (value) {
                    //     authControl.possetDistrict(value ?? authControl.posdistricts.first);
                    //   },
                    //   validator: (val) {
                    //     if (val == null || val.isEmpty || val == 'Select District') {
                    //       return 'Please Select district';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    sizedBox20(),
                    Text(
                      'Cadre',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomDropdownButtonFormField<String>(
                      value:authControl.cadar ?? authControl.cadarList.first,
                      items: authControl.cadarList,
                      hintText: "Select Highest Degree",
                      onChanged: (value) {
                        authControl.setCadar(value ?? authControl.cadarList.first);
                        print('cadre =========== >${authControl.cadar}');
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value == 'Select Cadre') {
                          return 'Please Select Select Cadre';
                        }
                        return null;
                      },
                    ),
                    sizedBox20(),

                    Text(
                      'Posting Year',
                      style: kManrope25Black.copyWith(fontSize: 16),
                    ),
                    sizedBox12(),
                    CustomDropdownButtonFormField<String>(
                      value: authControl.postingYear ,
                      items: authControl.yearList,
                      hintText: "Posting Year",
                      onChanged: (value) {
                        // authControl.setHighestDegree(value!);
                        authControl.setPostingYear(value!);
                        print(authControl.postingYear);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value == 'Select Posting Year') {
                          return 'Please Select Posting Year';
                        }
                        return null;
                      },
                    ),

                    // CustomTextField(
                    //   maximumInput: 4,
                    //   isAmount: true,
                    //   controller: _yearController,
                    //   hintText: 'Year',
                    //   validation: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please Enter Posting Year';
                    //     }
                    //     final month = int.tryParse(value);
                    //     if (month == null || month < 1 || month > 2023) {
                    //       return 'Invalid Year';
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (value) {
                    //     authControl.setPostingYear(_yearController.text);
                    //     print(authControl.postingYear);
                    //
                    //   },
                    // ),


                    // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Expanded(
                    //       child: CustomTextField(
                    //         maximumInput: 2,
                    //         isAmount: true,
                    //         controller: _dayController,
                    //         hintText: 'Date',
                    //         validation: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return 'Please Enter Posting Date';
                    //           }
                    //           final month = int.tryParse(value);
                    //           if (month == null || month < 1 || month > 31) {
                    //             return 'Invalid Date';
                    //           }
                    //           return null;
                    //         },
                    //         onChanged: (value) {
                    //           authControl.setPostingDay(_dayController.text);
                    //           print(authControl.postingDay);
                    //         },
                    //       ),
                    //     ),
                    //     const SizedBox(width: 15,),
                    //     Expanded(
                    //       child: CustomTextField(
                    //         maximumInput: 2,
                    //         isAmount: true,
                    //         controller: _monthController,
                    //         hintText: 'Month',
                    //         validation: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return 'Please Enter Posting Month';
                    //           }
                    //           final month = int.tryParse(value);
                    //           if (month == null || month < 1 || month > 12) {
                    //             return 'Invalid Month';
                    //           }
                    //           return null;
                    //         },
                    //         onChanged: (value) {
                    //           authControl.setPostingMonth(_monthController.text);
                    //           print(authControl.postingMonth);
                    //         },
                    //       ),
                    //     ),
                    //     const SizedBox(width: 15,),
                    //     Expanded(
                    //       child: CustomTextField(
                    //         maximumInput: 4,
                    //         isAmount: true,
                    //         controller: _yearController,
                    //         hintText: 'Year',
                    //         validation: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return 'Please Enter Posting Year';
                    //           }
                    //           final month = int.tryParse(value);
                    //           if (month == null || month < 1 || month > 2023) {
                    //             return 'Invalid Year';
                    //           }
                    //           return null;
                    //         },
                    //         onChanged: (value) {
                    //           authControl.setPostingYear(_yearController.text);
                    //           print(authControl.postingYear);
                    //
                    //         },
                    //       ),
                    //     ),
                    //
                    //   ],
                    // ),

                    // CustomTextField(
                    //   showTitle: false,
                    //   // validation: (value) {
                    //   //   if (value == null || value.isEmpty) {
                    //   //     return 'Please Enter your Starting Date';
                    //   //   }
                    //   //   return null;
                    //   // },
                    //   onTap: () { Get.find<AuthController>().showDatePicker(context); },
                    //   onChanged: (value) {
                    //     authControl.setPostingStartDate(authControl.from.toString());
                    //
                    //   },
                    //   readOnly:  true,
                    //   hintText:"Posting Start date",
                    //   controller: startDateController,
                    // ),
                    // CustomStyledDropdownButton(
                    //   title: "Posting Year",
                    //   items: authControl.batchYearList,
                    //   selectedValue: authControl.postingYear ?? authControl.batchYearList.first,
                    //   onChanged: (value) {
                    //     authControl.setPostingYear(value ?? authControl.batchYearList.first);
                    //     print(authControl.postingYear);
                    //   },
                    // ),


                  ],
                )

















              ///##################################################################




              /*  Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 5),
                  TypeAheadFormField<String>(
                    textFieldConfiguration:  TextFieldConfiguration(
                      controller: cadreController,
                      decoration: authDecoration(
                          context, "Select Cadre"
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return authControl.indianStatesAndUTs.where((state) => state.toLowerCase().contains(pattern.toLowerCase())).toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion), ); },
                    onSuggestionSelected: (String? suggestion) {
                      if (suggestion != null) {
                        authControl.setIndianStates(suggestion);
                        cadreController.text = suggestion;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select State';
                      }
                      return null;
                    },
                    onSaved: (value) => authControl.setIndianStates(value!),
                  ),
                  // SizedBox(
                  //   width: 1.sw,
                  //   child: CustomStyledDropdownButton(
                  //     items: const  [
                  //       "Cadres",
                  //
                  //     ],
                  //     selectedValue: cadarValue,
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Please enter Cadres';
                  //       }
                  //       return null;
                  //     },
                  //     onChanged: (String? value) {
                  //       // setState(() {
                  //       //   cadarValue = value;
                  //       //   cadarFilter = cadarValue ?? '';
                  //       //   SharedPrefs().setMotherTongue(cadarFilter);
                  //       //
                  //       // });
                  //       // print(userTypeFilter);
                  //       // print('Check ======> Usetype${userTypeFilter}');
                  //     },
                  //     title: 'Cadres',
                  //   ),
                  // ),
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
              ),*/
            ),
          );
        }),
      ),
    );
  }
}

