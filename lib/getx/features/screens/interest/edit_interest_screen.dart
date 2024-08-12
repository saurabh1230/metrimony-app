import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/utils/colors.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditInterestScreen extends StatefulWidget {
  const EditInterestScreen({
    super.key,
  });

  @override
  State<EditInterestScreen> createState() => _EditInterestScreenState();


}

class _EditInterestScreenState extends State<EditInterestScreen> {
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
      Get.find<AuthController>().initList();
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
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Interest',isBackButtonExist: true,),
      body: GetBuilder<AuthController>(builder: (authControl) {
        final visibleChips = authControl.isExpanded
            ? authControl.creativeList
            : authControl.creativeList.take(6).toList();
        final visibleFunChips = authControl.isFunExpanded
            ? authControl.funList
            : authControl.funList.take(6).toList();
        final visibleFitnessChips = authControl.isFitnessExpanded
            ? authControl.fitnessList
            : authControl.fitnessList.take(6).toList();

        final visibleOtherChips = authControl.isOtherInterestExpanded
            ? authControl.otherInterestList
            : authControl.otherInterestList.take(6).toList();
        final visibleHobbieChips = authControl.isHobbiesExpanded
            ? authControl.hobbiesList
            : authControl.hobbiesList.take(6).toList();


        return
        SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Creatives',
                  style: kManrope25Black.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 12,),
                Container(padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5,color: Colors.black),
                      borderRadius: BorderRadius.circular(12),color: Theme.of(context).cardColor
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: visibleChips.map((creative) {
                          final isSelected = authControl.selectedCreatives.contains(creative);
                          return ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor: color4B164C.withOpacity(0.80),
                            label: Text(creative,
                              style: TextStyle(fontSize: 16,
                                color: isSelected ? Colors.white : color4B164C.withOpacity(0.80),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              authControl.selectCreative(creative);
                              print(authControl.selectedCreatives);
                            },
                          );
                        }).toList(),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: authControl.toggleExpanded,
                          child: SizedBox(
                            width: 180,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(authControl.isExpanded ? 'View Less' : 'View More',
                                  style:  kManrope14Medium626262.copyWith(color: Colors.black),),
                                const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBox20(),
                Text(
                  'Fun',
                  style: kManrope25Black.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 12,),
                Container(padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5,color: Colors.black),
                      borderRadius: BorderRadius.circular(12),color: Theme.of(context).cardColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: visibleFunChips.map((creative) {
                          final isSelected = authControl.fun.contains(creative);
                          return ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor: color4B164C.withOpacity(0.80),
                            label: Text(creative,
                              style: TextStyle(fontSize: 16,
                                color: isSelected ? Colors.white : color4B164C.withOpacity(0.80),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              authControl.selectFun(creative);
                              print(authControl.fun);
                            },
                          );
                        }).toList(),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: authControl.toggleFunExpanded,
                          child: SizedBox(
                            width: 180,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(authControl.isFunExpanded ? 'View Less' : 'View More',
                                  style:  kManrope14Medium626262.copyWith(color: Colors.black),),
                                const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBox20(),
                Text(
                  'Fitness',
                  style: kManrope25Black.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 12,),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5,color: Colors.black),
                      borderRadius: BorderRadius.circular(12),color: Theme.of(context).cardColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: visibleFitnessChips.map((creative) {
                          final isSelected = authControl.fitness.contains(creative);
                          return ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor: color4B164C.withOpacity(0.80),
                            label: Text(creative,
                              style: TextStyle(fontSize: 16,
                                color: isSelected ? Colors.white : color4B164C.withOpacity(0.80),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              authControl.selectFitness(creative);
                              print(authControl.fitness);
                            },
                          );
                        }).toList(),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: authControl.toggleFitnessExpanded,
                          child: SizedBox(
                            width: 180,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(authControl.isFitnessExpanded ? 'View Less' : 'View More',
                                  style:  kManrope14Medium626262.copyWith(color: Colors.black),),
                                const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBox20(),
                Text(
                  'Other Interest',
                  style: kManrope25Black.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 12,),
                Container(padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5,color: Colors.black),
                      borderRadius: BorderRadius.circular(12),color: Theme.of(context).cardColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: visibleOtherChips.map((creative) {
                          final isSelected = authControl.otherInterests.contains(creative);
                          return ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor: color4B164C.withOpacity(0.80),
                            label: Text(creative,
                              style: TextStyle(fontSize: 16,
                                color: isSelected ? Colors.white : color4B164C.withOpacity(0.80),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              authControl.selectOtherInterest(creative);
                              print(authControl.fitness);
                            },
                          );
                        }).toList(),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: authControl.toggleOtherInterestExpanded,
                          child: SizedBox(
                            width: 180,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(authControl.isOtherInterestExpanded ? 'View Less' : 'View More',
                                  style:  kManrope14Medium626262.copyWith(color: Colors.black),),
                                const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,)
                              ],
                            ),
                          ),
                        ),
                      ),],),),
                sizedBox20(),
                Text(
                  'Hobbies',
                  style: kManrope25Black.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 12,),
                Container(padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5,color: Colors.black),
                      borderRadius: BorderRadius.circular(12),color: Theme.of(context).cardColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: visibleHobbieChips.map((creative) {
                          final isSelected = authControl.hobbies.contains(creative);
                          return ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor: color4B164C.withOpacity(0.80),
                            label: Text(creative,
                              style: TextStyle(fontSize: 16,
                                color: isSelected ? Colors.white : color4B164C.withOpacity(0.80),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              authControl.selectHobby(creative);
                              print(authControl.hobbies);
                            },
                          );
                        }).toList(),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: authControl.toggleHobbiesExpanded,
                          child: SizedBox(
                            width: 180,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(authControl.isHobbiesExpanded ? 'View Less' : 'View More',
                                  style:  kManrope14Medium626262.copyWith(color: Colors.black),),
                                const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),);
      }),
    );
  }
}
