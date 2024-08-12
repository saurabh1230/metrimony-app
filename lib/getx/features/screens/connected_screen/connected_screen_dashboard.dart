import 'package:bureau_couple/getx/controllers/filter_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_empty_match_widget.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ConnectDashboard extends StatefulWidget {
  final int initialIndex;
  ConnectDashboard({super.key, required this.initialIndex});

  @override
  State<ConnectDashboard> createState() => _ConnectDashboardState();
}

class _ConnectDashboardState extends State<ConnectDashboard> {
  late final PageController _pageController;
  int _pageIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _pageIndex);
    Get.find<MatchesController>().getMatches(
        '1',
        Get.find<ProfileController>().profile!.basicInfo!.gender!.contains('Male')
            ? "Female"
            : Get.find<ProfileController>().profile!.basicInfo!.gender!.contains('Female')
            ? "Male"
            : "Others",
        '', '', '',
        '',
        '',
        '',
        '');
  }

  Widget buildMatchesList(BuildContext context, MatchesController matchesControl) {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 0),
      child: Center(
        child: CustomEmptyMatchScreen(
          title: 'No Request Yet',
          isBackButton: true,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchesController>(builder: (matchesControl) {
      return GetBuilder<FilterController>(builder: (filterControl) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    controller: _scrollController, // ScrollController for smooth scrolling
                    padding: const EdgeInsets.only(
                      top: Dimensions.paddingSize10,
                      right: Dimensions.paddingSizeDefault, // Padding on the right to avoid cutting
                    ),
                    itemCount: filterControl.connectedFilterTopList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      final isSelected = i == _pageIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageIndex = i;
                            _pageController.jumpToPage(i);
                          });

                          // Ensure the selected item is fully visible
                          _scrollController.animateTo(
                            i * (Dimensions.paddingSizeDefault + 100), // Adjust the multiplier based on item width
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: isSelected
                                ? Border(
                              bottom: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                                width: 2.0,
                              ),
                            )
                                : null,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          child: Text(
                            filterControl.connectedFilterTopList[i],
                            style: satoshiBold.copyWith(fontSize: Dimensions.fontSize18),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Divider(color: Theme.of(context).disabledColor),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _pageIndex = index;
                      });
                      _scrollController.animateTo(
                        index * (Dimensions.paddingSizeDefault + 100), // Adjust the multiplier based on item width
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      // _loadMatchesForFilter(index);
                    },
                    itemCount: filterControl.connectedFilterTopList.length,
                    itemBuilder: (context, index) {
                      return GetBuilder<MatchesController>(
                        builder: (matchesControl) {
                          return buildMatchesList(context, matchesControl);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }

  // void _loadMatchesForFilter(int index) {
  //   final gender = Get.find<ProfileController>().profile!.basicInfo!.gender!;
  //   final genderFilter = gender.contains('Male') ? "Female" : (gender.contains('Female') ? "Male" : "Others");
  //
  //   switch (index) {
  //     case 0:
  //       print('case 0');
  //       Get.find<MatchesController>().getMatches(
  //           '1', genderFilter, '2', '', '', '', '', '', '');
  //       break;
  //     case 1:
  //       print('case 1');
  //       Get.find<MatchesController>().getMatches(
  //           '1', genderFilter, 'Muslim', '', '', '', '', '', '');
  //       break;
  //     case 2:
  //       print('case 2');
  //       Get.find<MatchesController>().getMatches(
  //           '1', genderFilter, '', '', '', '', '', '', '');
  //       break;
  //     case 3:
  //       print('case 3');
  //       Get.find<MatchesController>().getMatches(
  //           '1', genderFilter, '', '', '', '', '', '', '');
  //       break;
  //     default:
  //       break;
  //   }
  // }
}
