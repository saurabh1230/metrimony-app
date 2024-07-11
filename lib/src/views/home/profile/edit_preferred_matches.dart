import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/models/profie_model.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/views/signup/sign_up_screen_before_three.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import '../../../apis/partner_expectation_api.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../apis/profile_apis/physical_attributes_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import '../../../models/attributes_model.dart';
import '../../../models/preference_model.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/customAppbar.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'edit_basic_info.dart';
class EditPreferenceScreen extends StatefulWidget {
  const EditPreferenceScreen({super.key});

  @override
  State<EditPreferenceScreen> createState() => _EditPreferenceScreenState();
}

class _EditPreferenceScreenState extends State<EditPreferenceScreen> {
  final generalInfo = TextEditingController();
  final countryController = TextEditingController();
  final heightController = TextEditingController();
  final maxHeightController = TextEditingController();
  // final weightController = TextEditingController();
  final preferredReligionController = TextEditingController();
  final minAgeController = TextEditingController();
  final maxAgeController = TextEditingController();
  final preferredProfession = TextEditingController();
  final financialCondition = TextEditingController();
  final motherTongueController = TextEditingController();
  final communityController = TextEditingController();
  final minimumDegreeController = TextEditingController();
  final smokingController = TextEditingController();
  final drinkingController = TextEditingController();
  final languageController = TextEditingController();

  bool loading = false;
  bool isLoading = false;

  @override
  void initState() {
    careerInfo();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getReligionsList();
      Get.find<AuthController>().getCommunityList();
      Get.find<AuthController>().getMotherTongueList();
      Get.find<AuthController>().getProfessionList();

    });
  }


  PartnerExpectationInfoMdl preferenceModel = PartnerExpectationInfoMdl();

  careerInfo() {
    isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
      // physicalData.clear();
      if (value['status'] == true) {
        setState(() {
          var physicalAttributesData = value['data']['user']['partner_expectation'];
          if (physicalAttributesData != null) {
            setState(() {
              preferenceModel = PartnerExpectationInfoMdl.fromJson(physicalAttributesData);
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
   generalInfo.text = preferenceModel.generalRequirement.toString() ?? '';
   countryController.text= preferenceModel.country.toString() ?? '';
    minAgeController.text= preferenceModel.minAge.toString() ?? '';
     maxAgeController.text= preferenceModel.maxAge.toString() ?? '';
     heightController.text= preferenceModel.minHeight.toString() ?? '';
   maxHeightController.text= preferenceModel.maxHeight.toString() ?? '';
   // weightController.text= preferenceModel.maxWeight.toString() ?? '';
    preferredReligionController.text= preferenceModel.religion!.name.toString() ?? '';
    communityController.text= preferenceModel.community!.name.toString() ?? '';
    smokingController.text= preferenceModel.smokingStatus.toString() ?? '';
   drinkingController.text= preferenceModel.drinkingStatus.toString() ?? '';
     preferredProfession.text= preferenceModel.profession!.name.toString() ?? '';
    minimumDegreeController.text= preferenceModel.minDegree.toString() ?? '';
    financialCondition.text= preferenceModel.financialCondition.toString() ?? '';
    // languageController.text= preferenceModel.language.toString() ?? '';
  }

  DateTime _selectedTime = DateTime.now();
  String time = "-";

  int _feet = 5;
  int _inches = 0;

  int _feet2 = 5;
  int _inches2 = 0;



  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControl) {
      return  Scaffold(
        appBar: const CustomAppBar(title: "Partner Expectation",),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child:
            loading ?
            loadingButton(context: context) :button(context: context, onTap: () {
              setState(() {
                loading = true;
              });
              partnerExpectationUpdateApi(
                  generalRequirement: generalInfo.text,
                  country: countryController.text,
                  minAge: minAgeController.text,
                  maxAge: maxAgeController.text,
                  minHeight: heightController.text,
                  maxWeight: '',
                  religion: authControl.religionMainIndex.toString(),
                  community: authControl.communityMainIndex.toString(),
                  smokingStatus: smokingController.text,
                  drinkingStatus: drinkingController.text,
                  profession: authControl.professionIndex.toString(),
                  minDegree: minimumDegreeController.text,
                  financialCondition: financialCondition.text,
                  language: languageController.text,
                  maxHeight: maxHeightController.text).then((value) {
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
          child: SingleChildScrollView(
            physics: const  AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Partner Expectations",style:styleSatoshiMedium(size: 16, color: primaryColor)),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'General Introduction',
                            addTextField: TextFormField(
                              maxLength: 200,
                              onChanged: (v) {
                                setState(() {});
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: generalInfo,
                              decoration: AppTFDecoration(hint: 'General Introduction')
                                  .decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );

                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "General Information",style: styleSatoshiRegular(size: 14, color: color5E5E5E),
                            ),
                            const SizedBox(width: 3,),
                            const Icon(
                              Icons.edit,
                              size: 12,
                            ),
                          ],
                        ),
                        generalInfo.text.isEmpty?
                        const SizedBox() :
                        Column(
                          children: [
                            sizedBox16(),

                            Text(
                              generalInfo.text.isEmpty
                                  ? (preferenceModel.id == null ||
                                  preferenceModel.generalRequirement == null ||
                                  preferenceModel.generalRequirement!.isEmpty
                                  ? ''
                                  : preferenceModel.generalRequirement!)
                                  : generalInfo.text,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),

                          ],
                        )


                      ],
                    ),
                  ),

                  // sizedBox16(),
                  // GestureDetector(
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return NameEditDialogWidget(
                  //           title: 'Country',
                  //           addTextField: TextFormField(
                  //             maxLength: 40,
                  //             onChanged: (v) {
                  //               setState(() {
                  //               });
                  //             },
                  //             onEditingComplete: () {
                  //               Navigator.pop(context); // Close the dialog
                  //             },
                  //             controller: countryController,
                  //             decoration: AppTFDecoration(
                  //                 hint: 'Country').decoration(),
                  //             //keyboardType: TextInputType.phone,
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  //   child: buildDataAddRow(title: 'Country',
                  //     data1: countryController.text.isEmpty
                  //         ? (preferenceModel.id == null || preferenceModel.country == null || preferenceModel.country!.isEmpty
                  //         ? 'Not Added'
                  //         : preferenceModel.country!)
                  //         : countryController.text,
                  //     data2: StringUtils.capitalize(countryController.text),
                  //     isControllerTextEmpty: countryController.text.isEmpty, widget: SizedBox(),),
                  // ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Min Age',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: minAgeController,
                              decoration: AppTFDecoration(
                                  hint: 'Min Age').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Min Age',
                      data1: minAgeController.text.isEmpty
                          ? (preferenceModel.id == null || preferenceModel.minAge == null
                          ? 'Not Added'
                          : preferenceModel.minAge.toString())
                          : minAgeController.text,
                      data2: StringUtils.capitalize(minAgeController.text),
                      isControllerTextEmpty: minAgeController.text.isEmpty, widget: const SizedBox(),),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Max Age',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: maxAgeController,
                              decoration: AppTFDecoration(
                                  hint: 'Max Age').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Max Age',
                      data1: maxAgeController.text.isEmpty
                          ? (preferenceModel.id == null || preferenceModel.maxAge == null
                          ? 'Not Added'
                          : preferenceModel.maxAge.toString())
                          : maxAgeController.text,
                      data2: StringUtils.capitalize(maxAgeController.text),
                      isControllerTextEmpty: maxAgeController.text.isEmpty, widget: const SizedBox(),),
                  ),

                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {

                          // Create the modal bottom sheet widget containing the time picker and close button
                          return SizedBox(
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: Column(
                              children: [

                                WillPopScope(
                                  onWillPop: () async {

                                    return false;
                                  },
                                  child: SizedBox(
                                    height:200,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CupertinoPicker(
                                            scrollController: FixedExtentScrollController(
                                              initialItem: _feet - 5,
                                            ),
                                            itemExtent: 32,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                _feet = index + 5;
                                              });
                                            },
                                            children: List.generate(
                                              7, // 7 feet in the range from 5 to 11
                                                  (index) => Center(child: Text('${index + 5}\'')),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                            scrollController: FixedExtentScrollController(
                                              initialItem: _inches,
                                            ),
                                            itemExtent: 32,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                _inches = index;
                                              });
                                              print(' $_feet-${_inches.toString().padLeft(2, '0')}');
                                            },
                                            children: List.generate(
                                              12, // 12 inches in a foot
                                                  (index) => Center(child: Text('$index\"')),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),



                                // Close button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Flexible(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent, // Change the background color to red
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Close',
                                          style: styleSatoshiMedium(
                                              size: 13,
                                              color: Colors.white),),
                                      ),
                                    ),
                                    const SizedBox(width: 8,),
                                    Flexible(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            heightController.text = '$_feet.${_inches.toString().padLeft(1, '0')}';
                                            print('$_feet.${_inches.toString().padLeft(1, '0')}');
                                          });
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Save',
                                          style: styleSatoshiMedium(
                                              size: 13,
                                              color: Colors.black),),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      );

                    },
                    child: buildDataAddRow(title: 'Min Height ',
                        data1: heightController.text.isEmpty
                            ? (preferenceModel.id == null || preferenceModel.minHeight == null || preferenceModel.minHeight!.isEmpty
                            ? 'Not Added'
                            : preferenceModel.minHeight.toString())
                            : heightController.text,
                        data2: heightController.text,
                        isControllerTextEmpty: heightController.text.isEmpty, widget: SizedBox()),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {

                          // Create the modal bottom sheet widget containing the time picker and close button
                          return SizedBox(
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: Column(
                              children: [

                                WillPopScope(
                                  onWillPop: () async {

                                    return false;
                                  },
                                  child: SizedBox(
                                    height:200,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CupertinoPicker(
                                            scrollController: FixedExtentScrollController(
                                              initialItem: _feet2 - 5,
                                            ),
                                            itemExtent: 32,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                _feet2 = index + 5;
                                              });
                                            },
                                            children: List.generate(
                                              7, // 7 feet in the range from 5 to 11
                                                  (index) => Center(child: Text('${index + 5}\'')),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                            scrollController: FixedExtentScrollController(
                                              initialItem: _inches2,
                                            ),
                                            itemExtent: 32,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                _inches2 = index;
                                              });
                                              print(' $_feet2-${_inches2.toString().padLeft(2, '0')}');
                                            },
                                            children: List.generate(
                                              12, // 12 inches in a foot
                                                  (index) => Center(child: Text('$index\"')),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Flexible(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent, // Change the background color to red
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Close',
                                          style: styleSatoshiMedium(
                                              size: 13,
                                              color: Colors.white),),
                                      ),
                                    ),
                                    const SizedBox(width: 8,),
                                    Flexible(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            maxHeightController.text = '$_feet2.${_inches2.toString().padLeft(1, '0')}';
                                            // maxHeightController.text = '$_feet2-${_inches2.toString()}';
                                            print('$_feet2.${_inches2.toString().padLeft(1, '0')}');
                                          });
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Save',
                                          style: styleSatoshiMedium(
                                              size: 13,
                                              color: Colors.black),),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      );

                    },
                    child: buildDataAddRow(title: 'Max Height ',
                        data1: maxHeightController.text.isEmpty
                            ? (preferenceModel.id == null || preferenceModel.minHeight == null || preferenceModel.minHeight!.isEmpty
                            ? 'Not Added'
                            : preferenceModel.minHeight.toString())
                            : maxHeightController.text,
                        data2: maxHeightController.text,
                        isControllerTextEmpty: maxHeightController.text.isEmpty, widget: const SizedBox()),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),

                  /*  sizedBox16(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NameEditDialogWidget(
                          title: 'Max Weight',
                          addTextField: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 40,
                            onChanged: (v) {
                              setState(() {
                              });
                            },
                            onEditingComplete: () {
                              Navigator.pop(context);
                            },
                            controller: weightController,
                            decoration: AppTFDecoration(
                                hint: 'Max Weight').decoration(),
                            //keyboardType: TextInputType.phone,
                          ),
                        );
                      },
                    );
                  },
                  child: buildDataAddRow(title: 'Max Weight',
                    data1: weightController.text.isEmpty
                        ? (preferenceModel.id == null || preferenceModel.maxWeight == null || preferenceModel.maxWeight!.isEmpty
                        ? 'Not Added'
                        : preferenceModel.maxWeight.toString())
                        : weightController.text,
                    data2: weightController.text,
                    isControllerTextEmpty: weightController.text.isEmpty, widget: SizedBox(),),
                  // child: CarRowWidget(favourites: favourites!,)
                ),*/
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ReligionSheet(
                            privacyStatus: '',
                            onPop: (val) {
                              preferredReligionController.text = val;
                              print(preferredReligionController.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Preferred Religion',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: preferredReligionController.text.isEmpty
                          ? (preferenceModel.id == null ||
                          preferenceModel.religion == null
                          ? 'Not Added'
                          : preferenceModel.religion!.name.toString())
                          : preferredReligionController.text,
                      data2: preferredReligionController.text,
                      isControllerTextEmpty: preferredReligionController.text.isEmpty,
                    ),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                         ProfessionBottomSheet(onPop: (val ) {
                          preferredProfession.text = val;
                        },),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Preferred Profession',
                      data1: preferredProfession.text.isEmpty
                          ? (preferenceModel.id == null || preferenceModel.profession == null || preferenceModel.profession!.name!.isEmpty
                          ? 'Not Added'
                          : preferenceModel.profession!.name.toString())
                          : preferredProfession.text,
                      data2: StringUtils.capitalize(preferredProfession.text),
                      isControllerTextEmpty: preferredProfession.text.isEmpty,
                      widget: const SizedBox(),
                    ),),
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return FinancialBottomSheet(
                            privacyStatus: '',
                            onPop: (val) {
                              financialCondition.text = val;
                              print( '===>${financialCondition.text}');
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Financial Condition',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: financialCondition.text.isEmpty
                          ? (preferenceModel.id == null ||
                          preferenceModel.financialCondition == null
                          ? 'Not Added'
                          : preferenceModel.financialCondition.toString())
                          : financialCondition.text,
                      data2: financialCondition.text,
                      isControllerTextEmpty: financialCondition.text.isEmpty,
                    ),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.bottomSheet(
                         MotherTongueBottomSheet(onPop: (val ) {
                           motherTongueController.text = val;
                         },),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Mother Tongue',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: motherTongueController.text.isEmpty
                          ? (preferenceModel.id == null ||
                          preferenceModel.motherTongue == null
                          ? 'Not Added'
                          : preferenceModel.motherTongue!.name.toString())
                          : motherTongueController.text,
                      data2: motherTongueController.text,
                      isControllerTextEmpty: motherTongueController.text.isEmpty,
                    ),
                  ),
                /*  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CommuitySheet(
                            privacyStatus: '',
                            onPop: (val) {
                              communityController.text = val;
                              print(communityController.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Community',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: communityController.text.isEmpty
                          ? (preferenceModel.id == null ||
                          preferenceModel.community == null
                          ? 'Not Added'
                          : preferenceModel.community)
                          : communityController.text,
                      data2: communityController.text,
                      isControllerTextEmpty: communityController.text.isEmpty,
                    ),
                  ),*/
                  sizedBox16(),
                  // GestureDetector(
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return NameEditDialogWidget(
                  //           title: 'Minimum Degree',
                  //           addTextField: TextFormField(
                  //             maxLength: 40,
                  //             onChanged: (v) {
                  //               setState(() {
                  //               });
                  //             },
                  //             onEditingComplete: () {
                  //               Navigator.pop(context); // Close the dialog
                  //             },
                  //             controller: minimumDegreeController,
                  //             decoration: AppTFDecoration(
                  //                 hint: 'Minimum Degree').decoration(),
                  //             //keyboardType: TextInputType.phone,
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  //   child: buildDataAddRow(title: 'Minimum Degree',
                  //     data1: minimumDegreeController.text.isEmpty
                  //         ? (preferenceModel.id == null || preferenceModel.minDegree == null || preferenceModel.minDegree!.isEmpty
                  //         ? 'Not Added'
                  //         : preferenceModel.minDegree!)
                  //         : minimumDegreeController.text,
                  //     data2: StringUtils.capitalize(minimumDegreeController.text),
                  //     isControllerTextEmpty: minimumDegreeController.text.isEmpty, widget: SizedBox(),),
                  //   // child: CarRowWidget(favourites: favourites!,)
                  // ),
                  // sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return PrivacyStatusBottomSheet(
                            privacyStatus: '',
                            onPop: (val) {
                              smokingController.text = val;
                              print(smokingController.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Smoking status',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: smokingController.text.isEmpty
                          ? (preferenceModel.id == null ||
                          preferenceModel.smokingStatus == null
                          ? 'Not Added'
                          : preferenceModel.smokingStatus.toString())
                          : smokingController.text,
                      data2: smokingController.text,
                      isControllerTextEmpty: smokingController.text.isEmpty,
                    ),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return DrinkingStatusBottomSheet(
                            privacyStatus: '',
                            onPop: (val) {
                              drinkingController.text = val;
                              // print(smokingController.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Drinking status',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: drinkingController.text.isEmpty
                          ? (preferenceModel.id == null ||
                          preferenceModel.drinkingStatus == null
                          ? 'Not Added'
                          : preferenceModel.drinkingStatus.toString())
                          : drinkingController.text,
                      data2: drinkingController.text,
                      isControllerTextEmpty: drinkingController.text.isEmpty,
                    ),
                    // child: CarRowWidget(drinkingController)
                  ),
                  // sizedBox16(),
                  // GestureDetector(
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return NameEditDialogWidget(
                  //           title: 'Language',
                  //           addTextField: TextFormField(
                  //             maxLength: 40,
                  //             onChanged: (v) {
                  //               setState(() {
                  //               });
                  //             },
                  //             onEditingComplete: () {
                  //               Navigator.pop(context); // Close the dialog
                  //             },
                  //             controller: languageController,
                  //             decoration: AppTFDecoration(
                  //                 hint: 'Language').decoration(),
                  //             //keyboardType: TextInputType.phone,
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  //   child: buildDataAddRow(title: 'Language',
                  //     data1: languageController.text.isEmpty
                  //         ? (preferenceModel.id == null || preferenceModel.language == null || preferenceModel.language!.isEmpty
                  //         ? 'Not Added'
                  //         : preferenceModel.language.toString())
                  //         : languageController.text,
                  //     data2: StringUtils.capitalize(removeBrackets(languageController.text)),
                  //     isControllerTextEmpty: languageController.text.isEmpty, widget: SizedBox(),),
                  //   // child: CarRowWidget(favourites: favourites!,)
                  // ),





                ],
              ),
            ),
          ),
        ),
      );
    } );

  }

  String removeBrackets(String text) {
    return text.replaceAll(RegExp(r'\[|\]'), '');
  }

  Row buildDataAddRow({
    required String title,
    required String data1,
    required String data2,
    required bool isControllerTextEmpty,
    required Widget widget,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
               title, style: styleSatoshiRegular(size: 14, color: color5E5E5E),
              ),
              const SizedBox(
                width: 3,
              ),
              widget,
            ],
          ),
        ),
        isControllerTextEmpty
            ? Expanded(
          // flex: 3,
          child: SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
            : Expanded(
          child: SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data2,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
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
      title: Text("Edit Partner Expectation",
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


class FinancialBottomSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const FinancialBottomSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<FinancialBottomSheet> createState() => _FinancialBottomSheet();
}

class _FinancialBottomSheet extends State<FinancialBottomSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: GetBuilder<AuthController>(builder: (authControl) {
          return  Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Financial Condition",
                      textAlign: TextAlign.left,
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                  ),
                  const SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ChipList(
                        elements: authControl.financialConditionList,
                        onChipSelected: (selectedFinancialCondition) {
                          print(selectedFinancialCondition);
                          widget.onPop(selectedFinancialCondition);
                          // authControl.setFinancialCondition(
                          //     selectedGender == "Male" ? "M" : selectedGender == "Female" ? "F" : "O"
                          // );
                          // setState(() {
                          //
                          //   // SharedPrefs().setGender(selectedGender);
                          //   // SharedPrefs().getGender();
                          // });
                        },
                        defaultSelected: "Male",
                      ),),
                  ),
                ],
              ),
            ),
          );
    }



      ),
    ),);
  }

  @override
  void initState() {
    if (widget.privacyStatus == "Below 3 lacs") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "4-8 lacs") {
      _gIndex = 1;
    }
    else if (widget.privacyStatus == "Above 8 lacs") {
      _gIndex = 2;
    }
    super.initState();
  }
}


class ReligionSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const ReligionSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<ReligionSheet> createState() => _ReligionSheet();
}

class _ReligionSheet extends State<ReligionSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: GetBuilder<AuthController>(builder: (authControl) {
          return Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                            widget.onPop(religion.name!); // Call the callback with the selected religion name
                            Navigator.pop(context); // Close the sheet
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        } )



      ),
    );
  }

}




class MotherTongueSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const MotherTongueSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<MotherTongueSheet> createState() => _MotherTongueSheet();
}

class _MotherTongueSheet extends State<MotherTongueSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Mother Tongue",
                  style: styleSatoshiMedium(size: 16, color: Colors.black),
                ),
                sizedBox16(),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 0;
                    Navigator.of(context).pop();
                    widget.onPop("Hindi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 0 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Hindi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 0 ? Colors.white : Colors.black),
                          // style: _gIndex == 0
                          //     ? textColorF7E64114w400
                          //     : ColorSelect.colorF7E641
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 1;
                    Navigator.of(context).pop();
                    widget.onPop("Bhojpuri");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 1 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Bhojpuri',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 1 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 2;
                    Navigator.of(context).pop();
                    widget.onPop("Marathi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 2 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Marathi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 2 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 3;
                    Navigator.of(context).pop();
                    widget.onPop("Bengali");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 3 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Bengali',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 3 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 4;
                    Navigator.of(context).pop();
                    widget.onPop("Odia");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 4 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Odia',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 4 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 5;
                    Navigator.of(context).pop();
                    widget.onPop("Gujarati");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 5 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Gujarati',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 5 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 6;
                    Navigator.of(context).pop();
                    widget.onPop("Punjabi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 6 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Punjabi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 6 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 7;
                    Navigator.of(context).pop();
                    widget.onPop("Urdu");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 7 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Urdu',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 7 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.privacyStatus == "Hindi") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "Bhojpuri") {
      _gIndex = 1;
    }
    else if (widget.privacyStatus == "Marathi") {
      _gIndex = 2;
    } else if (widget.privacyStatus == "Bengali") {
      _gIndex = 3;
    }  else if (widget.privacyStatus == "Odia") {
      _gIndex = 4;
    } else if (widget.privacyStatus == "Gujarati") {
      _gIndex = 5;
    } else if (widget.privacyStatus == "Punjabi") {
      _gIndex = 6;
    }  else if (widget.privacyStatus == "Urdu") {
      _gIndex = 7;
    }
    super.initState();
  }
}

class CommuitySheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const CommuitySheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<CommuitySheet> createState() => _CommuitySheet();
}

class _CommuitySheet extends State<CommuitySheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: GetBuilder<AuthController>(builder: (authControl) {
          return  Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                            widget.onPop(religion.name!); // Call the callback with the selected religion name
                            Navigator.pop(context);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  // Text(
                  //   "Select Community",
                  //   style: styleSatoshiMedium(size: 16, color: Colors.black),
                  // ),
                  // sizedBox16(),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 0;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Brahmin");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 0 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Brahmin',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 0 ? Colors.white : Colors.black),
                  //           // style: _gIndex == 0
                  //           //     ? textColorF7E64114w400
                  //           //     : ColorSelect.colorF7E641
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 1;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Rajput");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 1 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Rajput',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 1 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 2;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Kamma");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 2 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Kamma',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 2 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 3;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Yadav");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 3 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Yadav',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 3 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 4;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Gupta");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 4 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Gupta',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 4 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 5;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Muslim");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 5 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Muslim',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 5 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 6;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Sikh");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 6 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Sikh',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 6 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 7;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Punjabi");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 7 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Punjabi',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 7 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 8;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Aggarwal");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 8 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Aggarwal',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 8 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 9;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Muslim");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 9 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Muslim',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 9 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: () => setState(() {
                  //     _gIndex = 10;
                  //     Navigator.of(context).pop();
                  //     widget.onPop("Marathi");
                  //   }),
                  //   child: Container(
                  //     height: 44,
                  //     // width: 78,
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //       color: _gIndex == 10 ? primaryColor : Colors.transparent,
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //           'Marathi',
                  //           style: styleSatoshiLight(
                  //               size: 14,
                  //               color: _gIndex == 10 ? Colors.white : Colors.black),
                  //           // style
                  //           // : _gIndex == 1
                  //           //     ? kManRope_500_16_white
                  //           //     : kManRope_500_16_626A6A,
                  //         )),
                  //   ),
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

class ProfessionBottomSheet extends StatelessWidget {
  final Function(String) onPop;
  const ProfessionBottomSheet({super.key, required this.onPop});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControl) {
      return SingleChildScrollView(
        child: Container(color: Theme.of(context).cardColor,
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(children: [
              sizedBox20(),
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
                        onPop(religion.name!); // Call the callback with the selected religion name
                        Navigator.pop(context);
                      }
                    },
                  );
                }).toList(),
              ),
        
        
              ],
            ),
          ),
      );
    });
  }
}

class MotherTongueBottomSheet extends StatelessWidget {
  final Function(String) onPop;
  const MotherTongueBottomSheet({super.key, required this.onPop});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControl) {
      return SingleChildScrollView(
        child: Container(color: Theme.of(context).cardColor,
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(children: [
            sizedBox20(),
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
                      onPop(religion.name!); // Call the callback with the selected religion name
                      Navigator.pop(context);
                    }
                  },
                );
              }).toList(),
            ),


          ],
          ),
        ),
      );
    });
  }
}