import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_dropdown_button_field.dart';
import 'package:bureau_couple/getx/features/widgets/edit_details_textfield.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../apis/profile_apis/physical_attributes_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/attributes_model.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';
import 'package:fluttertoast/fluttertoast.dart';
class EditPhysicalAttributesScreen extends StatefulWidget {
  const EditPhysicalAttributesScreen({super.key});

  @override
  State<EditPhysicalAttributesScreen> createState() => _EditPhysicalAttributesScreenState();
}

class _EditPhysicalAttributesScreenState extends State<EditPhysicalAttributesScreen> {
  final complexionController = TextEditingController();
  final heightController = TextEditingController();
  final heightControllerFeet = TextEditingController();
  final weightController = TextEditingController();
  final weightControllerKgs = TextEditingController();
  final bloodGroupController = TextEditingController();
  final eyeColorController = TextEditingController();
  final hairColorController = TextEditingController();
  final disablityController = TextEditingController();

  bool loading = false;
  bool isLoading = false;

  @override
  void initState() {
    careerInfo();
    super.initState();
  }


  PhysicalAttributes physicalData = PhysicalAttributes();

  careerInfo() {
    isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
      // physicalData.clear();
      if (value['status'] == true) {
        setState(() {
          var physicalAttributesData = value['data']['user']['physical_attributes'];
          if (physicalAttributesData != null) {
            setState(() {
              physicalData = PhysicalAttributes.fromJson(physicalAttributesData);
              fields();
            });
          }
          // print(career.length);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void fields() {
    complexionController.text = physicalData.complexion.toString() ?? '';
    // heightController.text = physicalData.height.toString() ?? '';
    heightController.text = physicalData.height.toString() ?? '';
    heightControllerFeet.text = Get.find<ProfileController>().convertHeightToFeetInches(physicalData.height.toString() ) ?? "";
    weightController.text =physicalData.weight.toString() ?? '';
    weightControllerKgs.text = '${physicalData.weight.toString()} Kgs' ?? '';
    bloodGroupController.text = physicalData.bloodGroup.toString()?? '';
    eyeColorController.text =physicalData.eyeColor.toString() ?? '';
    hairColorController.text = physicalData.hairColor.toString() ?? '';
    disablityController.text =physicalData.disability.toString() ?? '';

  }

  DateTime _selectedTime = DateTime.now();
  String time = "-";

  int _feet = 5;
  int _inches = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Edit Physical Attributes",isBackButtonExist: true,),
      // appBar: buildAppBar(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
          loading ?
          loadingButton(context: context) :button(context: context, onTap: () {
            setState(() {
              loading = true;
            });
            physicalAppearanceUpdateApi(
                height: heightController.text,
                weight: weightController.text,
                bloodGroup: bloodGroupController.text,
                eyeColor: eyeColorController.text,
                hairColor: hairColorController.text,
                complexion: complexionController.text,
                disability: disablityController.text).then((value) {
              setState(() {
              });
              if (value['status'] == true) {
                setState(() {
                  loading = false;
                });
                Navigator.pop(context);
                dynamic message = value['message']['original']['message'];
                List<String> errors = [];

                if (message != null && message is Map) {
                  // If the message is not null and is a Map, extract the error messages
                  message.forEach((key, value) {
                    errors.addAll(value);
                  });
                }

                String errorMessage = errors.isNotEmpty ? errors.join(", ") : "Update succesfully.";
                Fluttertoast.showToast(msg: errorMessage);

              } else {
                setState(() {
                  loading = false;
                });
                Fluttertoast.showToast(msg: "Add All Details");
              }
            });
          },  title: "Save"),
        ),
      ),
      body: isLoading ? const AttributesShimmerWidget() : CustomRefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          return careerInfo();
        },
        child: GetBuilder<ProfileController>(builder: (profileController) {
          return GetBuilder<AuthController>(builder: (authControl) {
            return SingleChildScrollView(
              physics: const  AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                child: Column(
                  children: [
                    EditDetailsTextField(title: 'Height', controller: heightControllerFeet,readOnly: true,
                      onTap: () {
                        Get.bottomSheet(
                            SingleChildScrollView(
                              child: Container(color: Theme.of(context).cardColor,
                                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Select Height',
                                      style: kManrope25Black.copyWith(fontSize: 16),
                                    ),
                                    sizedBox12(),
                                    Row(
                                      children: [
                                        Text('Height  ',style: satoshiLight.copyWith(fontSize: Dimensions.fontSize12),),
                                        Obx(() => Text(
                                          '${authControl.attributeHeightValue.value.toStringAsFixed(1)} ft',
                                          style:satoshiBold.copyWith(fontSize: Dimensions.fontSize12,
                                              color: Theme.of(context).primaryColor),),),
                                      ],
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Obx(() => Slider(
                                        min: 5.0,
                                        max: 7.0,
                                        divisions: 20, // Number of divisions for finer granularity
                                        label: authControl.attributeHeightValue.value.toStringAsFixed(1), // Format to 1 decimal place
                                        value: authControl.attributeHeightValue.value, // Single value
                                        onChanged: (value) {
                                          authControl.setAttributeHeightValue(value);
                                          print(authControl.attributeHeightValue);
                                          heightController.text = authControl.attributeHeightValue.toString();
                                          heightControllerFeet.text = Get.find<ProfileController>().convertHeightToFeetInches(authControl.attributeHeightValue.toString() );
                                        },
                                      )),
                                    ),
                                  ],),
                              ),)
                        );

                      },),
                    sizedBox6(),
                    EditDetailsTextField(title: 'Weight', controller: weightControllerKgs,readOnly: true,
                      onTap: () {
                        Get.bottomSheet(SingleChildScrollView(child: Container(
                          color: Theme.of(context).cardColor,
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            Text(
                              'Select Weight',
                              style: kManrope25Black.copyWith(fontSize: 16),
                            ),
                            sizedBox12(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('Weight  ',style: satoshiLight.copyWith(fontSize: Dimensions.fontSize12),),
                                    Obx(() => Text('${authControl.attributeWeightValue.value.toString()} Kg',
                                      style:satoshiBold.copyWith(fontSize: Dimensions.fontSize12,
                                          color: Theme.of(context).primaryColor),),),

                                  ],
                                ),
                                // Text('Max Weight',style: satoshiLight.copyWith(fontSize: Dimensions.fontSize12),),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Obx(() => Slider(
                                min: 45.0,
                                max: 120.0,
                                divisions: 75, // Number of divisions for finer granularity
                                label: authControl.attributeWeightValue.value.toString(),
                                value: authControl.attributeWeightValue.value.toDouble(),
                                onChanged: (value) {
                                  authControl.setAttributeWeightValue(value.toInt());
                                  print(authControl.attributeWeightValue);
                                  weightController.text = authControl.attributeWeightValue.toString();
                                  weightControllerKgs.text =
                                  '${authControl.attributeWeightValue.value} yrs';
                                },
                              )),
                            ),
                          ],),
                        ) ,));

                      },),
                    sizedBox6(),
                    EditDetailsTextField(title: 'Eye Color', controller: eyeColorController,readOnly: true,
                      onTap: () {
                            Get.bottomSheet(SingleChildScrollView(child: Container(
                              color: Theme.of(context).cardColor,
                              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Eye Color',
                                    style: kManrope25Black.copyWith(fontSize: 16),
                                  ),
                                  sizedBox12(),
                                  CustomDropdownButtonFormField<String>(
                                    value:  authControl.eyeColor ?? authControl.eyeColorsList.first,// Assuming you have a selectedPosition variable
                                    items: authControl.eyeColorsList,
                                    hintText: "Select Eye Color",
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        authControl.setEyeColor(value);
                                        print(authControl.eyeColor);
                                        eyeColorController.text = value;
                                      }
                                    },
                                    // itemLabelBuilder: (String item) => item,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Select Eye Color';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),));

                      },),
                    sizedBox6(),
                    EditDetailsTextField(title: 'Blood Group', controller: bloodGroupController,readOnly: true,
                      onTap: () {
                        Get.bottomSheet(SingleChildScrollView(child: Container(
                          color: Theme.of(context).cardColor,
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Blood Group',
                                style: kManrope25Black.copyWith(fontSize: 16),
                              ),
                              sizedBox12(),
                              CustomDropdownButtonFormField<String>(
                                value:  authControl.bloodGroup ?? authControl.bloodGroupsList.first,// Assuming you have a selectedPosition variable
                                items: authControl.bloodGroupsList,
                                hintText: "Select Blood Group",
                                onChanged: (String? value) {
                                  if (value != null) {
                                    authControl.setBloodGroup(value);
                                    print(authControl.bloodGroup);
                                    bloodGroupController.text = value;
                                    print(bloodGroupController.text);
                                  }
                                },
                                // itemLabelBuilder: (String item) => item,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Select Annual Income';
                                  }
                                  return null;
                                },
                              ),

                            ],
                          ),
                        ),));

                      },),
                    sizedBox6(),
                    EditDetailsTextField(title: 'Hair Color', controller: hairColorController,readOnly: true,
                      onTap: () {
                        Get.bottomSheet(SingleChildScrollView(
                          child: Container(color: Theme.of(context).cardColor,
                            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hair Color',
                                  style: kManrope25Black.copyWith(fontSize: 16),
                                ),
                                sizedBox12(),
                                CustomDropdownButtonFormField<String>(
                                  value:  authControl.hairColor ?? authControl.hairColorList.first,// Assuming you have a selectedPosition variable
                                  items: authControl.hairColorList,
                                  hintText: "Hair Color",
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      authControl.setHairColor(value);
                                      print(authControl.hairColor);
                                      hairColorController.text = value;
                                    }
                                  },
                                ),
                              ],
                            ),),
                        ));

                      },),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.bottomSheet(
                    //         SingleChildScrollView(
                    //           child: Container(color: Theme.of(context).cardColor,
                    //             padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    //             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 'Select Height',
                    //                 style: kManrope25Black.copyWith(fontSize: 16),
                    //               ),
                    //               sizedBox12(),
                    //               Row(
                    //                 children: [
                    //                   Text('Height  ',style: satoshiLight.copyWith(fontSize: Dimensions.fontSize12),),
                    //                   Obx(() => Text(
                    //                     '${authControl.attributeHeightValue.value.toStringAsFixed(1)} ft',
                    //                     style:satoshiBold.copyWith(fontSize: Dimensions.fontSize12,
                    //                         color: Theme.of(context).primaryColor),),),
                    //                 ],
                    //               ),
                    //               SizedBox(
                    //                 width: double.infinity,
                    //                 child: Obx(() => Slider(
                    //                   min: 5.0,
                    //                   max: 7.0,
                    //                   divisions: 20, // Number of divisions for finer granularity
                    //                   label: authControl.attributeHeightValue.value.toStringAsFixed(1), // Format to 1 decimal place
                    //                   value: authControl.attributeHeightValue.value, // Single value
                    //                   onChanged: (value) {
                    //                     authControl.setAttributeHeightValue(value);
                    //                     print(authControl.attributeHeightValue);
                    //                     heightController.text = authControl.attributeHeightValue.toString();
                    //                   },
                    //                 )),
                    //               ),
                    //             ],),
                    //           ),)
                    //     );
                    //
                    //   },
                    //   child: buildDataAddRow(title: 'Height',
                    //       data1: heightController.text.isEmpty
                    //           ? (physicalData.id == null || physicalData.height == null || physicalData.height!.isEmpty
                    //           ? 'Not Added'
                    //           : physicalData.height.toString())
                    //           : heightController.text,
                    //       data2: profileController.convertHeightToFeetInches(heightController.text),
                    //       isControllerTextEmpty: heightController.text.isEmpty),
                    //   // child: CarRowWidget(favourites: favourites!,)
                    // ),
                    // sizedBox6(),
                    // const Divider(),
                    // sizedBox6(),
                    // GestureDetector(
                    //   onTap: () {
                    //   Get.bottomSheet(SingleChildScrollView(child: Container(
                    //     color: Theme.of(context).cardColor,
                    //     padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    //     child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    //       Text(
                    //         'Select Weight',
                    //         style: kManrope25Black.copyWith(fontSize: 16),
                    //       ),
                    //       sizedBox12(),
                    //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               Text('Weight  ',style: satoshiLight.copyWith(fontSize: Dimensions.fontSize12),),
                    //               Obx(() => Text('${authControl.attributeWeightValue.value.toString()} Kg',
                    //                 style:satoshiBold.copyWith(fontSize: Dimensions.fontSize12,
                    //                     color: Theme.of(context).primaryColor),),),
                    //
                    //             ],
                    //           ),
                    //           // Text('Max Weight',style: satoshiLight.copyWith(fontSize: Dimensions.fontSize12),),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         width: double.infinity,
                    //         child: Obx(() => Slider(
                    //           min: 45.0,
                    //           max: 120.0,
                    //           divisions: 75, // Number of divisions for finer granularity
                    //           label: authControl.attributeWeightValue.value.toString(),
                    //           value: authControl.attributeWeightValue.value.toDouble(),
                    //           onChanged: (value) {
                    //             authControl.setAttributeWeightValue(value.toInt());
                    //             print(authControl.attributeWeightValue);
                    //             weightController.text = authControl.attributeWeightValue.toString();
                    //           },
                    //         )),
                    //       ),
                    //     ],),
                    //   ) ,));
                    //   },
                    //   child: buildDataAddRow(title: 'Weight',
                    //     data1: weightController.text.isEmpty
                    //         ? (physicalData.id == null || physicalData.weight == null || physicalData.weight!.isEmpty
                    //         ? 'Not Added'
                    //         : physicalData.weight.toString())
                    //         : weightController.text,
                    //     data2:'${weightController.text.split('.')[0]} Kg',
                    //     isControllerTextEmpty: weightController.text.isEmpty,),
                    //   // child: CarRowWidget(favourites: favourites!,)
                    // ),
                    // sizedBox6(),
                    // const Divider(),
                    // sizedBox6(),
                    // GestureDetector(
                    //   onTap: () {
                    //    Get.bottomSheet(SingleChildScrollView(child: Container(
                    //      color: Theme.of(context).cardColor,
                    //      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    //      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //        children: [
                    //          Text(
                    //            'Blood Group',
                    //            style: kManrope25Black.copyWith(fontSize: 16),
                    //          ),
                    //          sizedBox12(),
                    //          CustomDropdownButtonFormField<String>(
                    //            value:  authControl.bloodGroup ?? authControl.bloodGroupsList.first,// Assuming you have a selectedPosition variable
                    //            items: authControl.bloodGroupsList,
                    //            hintText: "Select Blood Group",
                    //            onChanged: (String? value) {
                    //              if (value != null) {
                    //                authControl.setBloodGroup(value);
                    //                print(authControl.bloodGroup);
                    //                bloodGroupController.text = value;
                    //                print(bloodGroupController.text);
                    //              }
                    //            },
                    //            // itemLabelBuilder: (String item) => item,
                    //            validator: (value) {
                    //              if (value == null || value.isEmpty) {
                    //                return 'Please Select Annual Income';
                    //              }
                    //              return null;
                    //            },
                    //          ),
                    //
                    //        ],
                    //      ),
                    //    ),));
                    //   },
                    //   child: buildDataAddRow(title: 'Blood Group',
                    //     data1: bloodGroupController.text.isEmpty
                    //         ? (physicalData.id == null || physicalData.bloodGroup == null || physicalData.bloodGroup!.isEmpty
                    //         ? 'Not Added'
                    //         : physicalData.bloodGroup.toString())
                    //         : bloodGroupController.text,
                    //     data2: StringUtils.capitalize(bloodGroupController.text),
                    //     isControllerTextEmpty: bloodGroupController.text.isEmpty,),
                    //   // child: CarRowWidget(favourites: favourites!,)
                    // ),
                    // sizedBox6(),
                    // const Divider(),
                    // sizedBox6(),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.bottomSheet(SingleChildScrollView(child: Container(
                    //       color: Theme.of(context).cardColor,
                    //       padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    //       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'Eye Color',
                    //             style: kManrope25Black.copyWith(fontSize: 16),
                    //           ),
                    //           sizedBox12(),
                    //           CustomDropdownButtonFormField<String>(
                    //             value:  authControl.eyeColor ?? authControl.eyeColorsList.first,// Assuming you have a selectedPosition variable
                    //             items: authControl.eyeColorsList,
                    //             hintText: "Select Eye Color",
                    //             onChanged: (String? value) {
                    //               if (value != null) {
                    //                 authControl.setEyeColor(value);
                    //                 print(authControl.eyeColor);
                    //                 eyeColorController.text = value;
                    //               }
                    //             },
                    //             // itemLabelBuilder: (String item) => item,
                    //             validator: (value) {
                    //               if (value == null || value.isEmpty) {
                    //                 return 'Please Select Eye Color';
                    //               }
                    //               return null;
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     ),));
                    //   },
                    //   child: buildDataAddRow(title: 'EyeColor',
                    //     data1: eyeColorController.text.isEmpty
                    //         ? (physicalData.id == null || physicalData.eyeColor == null || physicalData.eyeColor!.isEmpty
                    //         ? 'Not Added'
                    //         : physicalData.eyeColor.toString())
                    //         : eyeColorController.text,
                    //     data2: StringUtils.capitalize(eyeColorController.text),
                    //     isControllerTextEmpty: eyeColorController.text.isEmpty,),
                    //   // child: CarRowWidget(favourites: favourites!,)
                    // ),
                    // sizedBox6(),
                    // const Divider(),
                    // sizedBox6(),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.bottomSheet(SingleChildScrollView(
                    //       child: Container(color: Theme.of(context).cardColor,
                    //         padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    //         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'Hair Color',
                    //             style: kManrope25Black.copyWith(fontSize: 16),
                    //           ),
                    //           sizedBox12(),
                    //           CustomDropdownButtonFormField<String>(
                    //             value:  authControl.hairColor ?? authControl.hairColorList.first,// Assuming you have a selectedPosition variable
                    //             items: authControl.hairColorList,
                    //             hintText: "Hair Color",
                    //             onChanged: (String? value) {
                    //               if (value != null) {
                    //                 authControl.setHairColor(value);
                    //                 print(authControl.hairColor);
                    //                 hairColorController.text = value;
                    //               }
                    //             },
                    //             // itemLabelBuilder: (String item) => item,
                    //             validator: (value) {
                    //               if (value == null || value.isEmpty) {
                    //                 return 'Please Select Hair Color';
                    //               }
                    //               return null;
                    //             },
                    //           ),
                    //         ],
                    //       ),),
                    //     ));
                    //   },
                    //   child: buildDataAddRow(title: 'Hair Color',
                    //     data1: hairColorController.text.isEmpty
                    //         ? (physicalData.id == null || physicalData.hairColor == null || physicalData.hairColor!.isEmpty
                    //         ? 'Not Added'
                    //         : physicalData.weight.toString())
                    //         : hairColorController.text,
                    //     data2: StringUtils.capitalize(hairColorController.text),
                    //     isControllerTextEmpty: hairColorController.text.isEmpty,),
                    //   // child: CarRowWidget(favourites: favourites!,)
                    // ),
                    // sizedBox6(),
                    // const Divider(),
                    // sizedBox6(),
                    // GestureDetector(
                    //   onTap: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return NameEditDialogWidget(
                    //           title: 'Disability',
                    //           addTextField: TextFormField(
                    //             maxLength: 40,
                    //             onChanged: (v) {
                    //               setState(() {
                    //               });
                    //             },
                    //             onEditingComplete: () {
                    //               Navigator.pop(context); // Close the dialog
                    //             },
                    //             controller: disablityController,
                    //             decoration: AppTFDecoration(
                    //                 hint: 'Disability').decoration(),
                    //             //keyboardType: TextInputType.phone,
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    //   child: buildDataAddRow(title: 'Disability',
                    //     data1: disablityController.text.isEmpty
                    //         ? (physicalData.id == null || physicalData.disability == null || physicalData.disability!.isEmpty
                    //         ? 'Not Added'
                    //         : physicalData.disability.toString())
                    //         : disablityController.text,
                    //     data2: StringUtils.capitalize(disablityController.text),
                    //     isControllerTextEmpty: disablityController.text.isEmpty,),
                    //   // child: CarRowWidget(favourites: favourites!,)
                    // ),

                  ],
                ),
              ),
            );
          });
        }),
      ),
    );
  }

  Row buildDataAddRow({
    required String title,
    required String data1,
    required String data2,
    required bool isControllerTextEmpty,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                '${title}  ', style: styleSatoshiRegular(size: 14, color: color5E5E5E),
              ),
              Icon(Icons.edit,size: 12,)
            ],
          ),
        ),
        isControllerTextEmpty ?
        Expanded(
          // flex: 3,
          child: SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data1,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ) :
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(data2,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }


  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: backButton(
            context: context,
            image: icArrowLeft,
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      title: Text("Physical Attributes",
        style: styleSatoshiBold(size: 18, color: Colors.black),
      ),
    );
  }
}


class AttributesShimmerWidget extends StatelessWidget {
  const AttributesShimmerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          children: [
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),


          ],
        ),
      ),
    );
  }
}
