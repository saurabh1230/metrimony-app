import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/filter_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_button%20_widget.dart';
import 'package:bureau_couple/getx/utils/colors.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterCategoryScreen extends StatelessWidget {
  final String filterType;

  FilterCategoryScreen({super.key, required this.filterType});

  final stateController = TextEditingController();
  final districtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getReligionsList();
      Get.find<AuthController>().getCommunityList();
      Get.find<AuthController>().getMotherTongueList();
      Get.find<AuthController>().getProfessionList();
    });

    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
        isBackButtonExist: true,
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: CustomButtonWidget(
            buttonText: 'Save',
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: GetBuilder<AuthController>(builder: (authControl) {
        return GetBuilder<FilterController>(builder: (filterController) {
          if (authControl.partReligionList == null ||
              authControl.partReligionList!.isEmpty ||
              authControl.partCommunityList == null ||
              authControl.partCommunityList!.isEmpty ||
              authControl.partProfessionList == null ||
              authControl.partProfessionList!.isEmpty ||
              authControl.partMotherTongueList == null ||
              authControl.partMotherTongueList!.isEmpty) {
            return Container(
              height: Get.size.height * 0.8,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              ),
              child: const Center(child: CircularProgressIndicator()),
            );
          } else {
            if (filterType.contains('Religions')) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: authControl.partReligionList!.length,
                      itemBuilder: (context, index) {
                        final religion = authControl.partReligionList![index];
                        final isSelected = filterController.filterReligion
                            .contains(religion.name);
                        return CheckboxListTile(
                          title: Text(
                            religion.name!,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? color4B164C
                                  : color4B164C.withOpacity(0.80),
                            ),
                          ),
                          value: isSelected,
                          onChanged: (bool? selected) {
                            filterController.setFilterReligion(religion.name!);
                            print(
                                filterController.filterReligion); // Debug print
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Selected Religions: ${filterController.filterReligion.join(', ')}',
                    textAlign: TextAlign.center,
                    style: kManrope16MediumBlack,
                  ),
                ],
              );
            } else if (filterType.contains('Caste')) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: authControl.partCommunityList!.length,
                      itemBuilder: (context, index) {
                        final community = authControl.partCommunityList![index];
                        final isSelected = filterController.filterCommunity
                            .contains(community.name);
                        return CheckboxListTile(
                          title: Text(
                            community.name!,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? color4B164C
                                  : color4B164C.withOpacity(0.80),
                            ),
                          ),
                          value: isSelected,
                          onChanged: (bool? selected) {
                            filterController
                                .setFilterCommunity(community.name!);
                            print(filterController
                                .filterCommunity); // Debug print
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSize8),
                    child: Text(
                      'Selected Caste: ${filterController.filterCommunity.join(', ')}',
                      style: TextStyle(fontSize: 16, color: color4B164C),
                    ),
                  ),
                ],
              );
            } else if (filterType.contains('MotherTongue')) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: authControl.partMotherTongueList!.length,
                      itemBuilder: (context, index) {
                        final motherTongue =
                            authControl.partMotherTongueList![index];
                        final isSelected = filterController.filterMotherTongue
                            .contains(motherTongue.name);

                        return CheckboxListTile(
                          title: Text(
                            motherTongue.name!,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? color4B164C
                                  : color4B164C.withOpacity(0.80),
                            ),
                          ),
                          value: isSelected,
                          onChanged: (bool? selected) {
                            filterController
                                .setFilterMotherTongue(motherTongue.name!);
                            print(filterController
                                .filterMotherTongue); // Debug print
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Selected Mother Tongues: ${filterController.filterMotherTongue.join(', ')}',
                    style: TextStyle(fontSize: 16, color: color4B164C),
                  ),
                ],
              );
            } else if (filterType.contains('Profession')) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: authControl.partProfessionList!.length,
                      itemBuilder: (context, index) {
                        final profession =
                            authControl.partProfessionList![index];
                        final isSelected = filterController.filterProfession
                            .contains(profession.name);

                        return CheckboxListTile(
                          title: Text(
                            profession.name!,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? color4B164C
                                  : color4B164C.withOpacity(0.80),
                            ),
                          ),
                          value: isSelected,
                          onChanged: (bool? selected) {
                            filterController
                                .setFilterProfession(profession.name!);
                            print(filterController
                                .filterProfession); // Debug print
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Selected Professions: ${filterController.filterProfession.join(', ')}',
                    style: TextStyle(fontSize: 16, color: color4B164C),
                  ),
                ],
              );
            } else if (filterType.contains('State')) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: authControl.posstates.length,
                      itemBuilder: (context, index) {
                        final state = authControl.posstates[index];
                        final isSelected = authControl.filterPostingState.contains(state);

                        return CheckboxListTile(
                          title: Text(
                            state,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? color4B164C : color4B164C.withOpacity(0.80),
                            ),
                          ),
                          value: isSelected,
                          onChanged: (bool? selected) {
                            authControl.setFilterPostingState(state);
                            print(authControl.filterPostingState); // Debug print
                          },
                        );
                      },
                    ),
                  ),
                  sizedBox16(),
                  Text(
                    'Selected Posting States: ${authControl.filterPostingState.join(', ')}',
                    style: TextStyle(fontSize: 16, color: color4B164C),
                  ),
                ],
              );
            }

            else {
              return const SizedBox();
            }
          }
        });
      }),
    );
  }
}
