import 'package:bureau_couple/getx/controllers/favourite_controller.dart';
import 'package:bureau_couple/getx/controllers/filter_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_empty_match_widget.dart';
import 'package:bureau_couple/getx/features/widgets/matches_shimmer_widget.dart';
import 'package:bureau_couple/getx/utils/app_constants.dart';
import 'package:bureau_couple/getx/utils/colors.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/src/constants/string.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/views/home/dashboard_widgets.dart';
import 'package:bureau_couple/src/views/user_profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MatchesDashboard extends StatefulWidget {
  final int initialIndex;
  const MatchesDashboard({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<MatchesDashboard> createState() => _MatchesDashboardState();
}

class _MatchesDashboardState extends State<MatchesDashboard> {
  late final PageController _pageController;
  int _pageIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _pageIndex);
    // Fetch initial matches based on gender and other parameters
    _fetchMatches();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchMatches() {
    final gender = Get.find<ProfileController>().profile?.basicInfo?.gender;
    final genderFilter = gender?.contains('Male') ?? false
        ? 'Female'
        : (gender?.contains('Female') ?? false ? 'Male' : 'Others');
    Get.find<MatchesController>().getMatches(
      '1', genderFilter, '', '', '', '', '', '', '',
    );
  }

  Widget _buildMatchesList(BuildContext context, MatchesController matchesControl) {
    final list = matchesControl.matchesList;
    final isListEmpty = list.isEmpty;
    return
      isListEmpty && !matchesControl.isLoading
          ? const Padding(
          padding: EdgeInsets.only(top: Dimensions.paddingSize100),
          child: Center(
              child: CustomEmptyMatchScreen(
                title: "No Matches Yet",
                isBackButton: true,
              )))
          : matchesControl.isLoading
          ? const ShimmerWidget()
          :
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Stack(
        children: [
          Text(
            "${matchesControl.matchesList.length} Matches Found",
            style: styleSatoshiLight(size: 14, color: Colors.black.withOpacity(0.60)),
          ),
          sizedBox10(),
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: ListView.separated(
              itemCount: matchesControl.matchesList.length,
              itemBuilder: (context, i) {
                final match = matchesControl.matchesList[i];
                final birthDate = match.basicInfo?.birthDate != null
                    ? DateFormat('yyyy-MM-dd').parse(match.basicInfo!.birthDate!)
                    : null;
                final age = birthDate != null ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                return GetBuilder<FavouriteController>(
                  builder: (favControl) {
                    final currentId = match.profileId;
                    final matchId = match.id;
                    final isWished = favControl.isBookmarkList.contains(currentId);
                    final isConnected = favControl.isConnectedIntList.contains(matchId);
                    return otherUserdataHolder(
                      context: context,
                      tap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(userId: match.id.toString()),
                          ),
                        );
                      },
                      imgUrl: '$baseProfilePhotoUrl${match.image ?? ''}',
                      state: match.basicInfo?.presentAddress?.state ?? '',
                      userName: '${StringUtils.capitalize(match.firstname ?? 'User')} ${StringUtils.capitalize(match.lastname ?? 'User')}',
                      atributeReligion: ' ${match.basicInfo?.religionName ?? ''}',
                      profession: 'Software Engineer',
                      Location: '${match.address?.state ?? ''} • ${match.professionName ?? ''} • ${match.communityName ?? ''}',
                      likedColor: Colors.grey,
                      unlikeColor: primaryColor,
                      button: match.interestStatus == 2
                          ? connectButton(
                        fontSize: 14,
                        height: 30,
                        width: 134,
                        context: context,
                        onTap: () {},
                        showIcon: !isWished,
                        title: 'Request Sent',
                      )
                          : connectButton(
                        fontSize: 14,
                        height: 30,
                        width: 134,
                        context: context,
                        onTap: () {
                          favControl.sendRequestApi(
                            Get.find<ProfileController>().userDetails!.id.toString(),
                            match.id.toString(),
                          );
                        },
                        showIcon: !isConnected,
                        title: isConnected ? 'Request Sent' : 'Connect Now',
                      ),
                      bookmark: match.bookmark == 1
                          ? GestureDetector(
                        onTap: () {
                          favControl.unSaveBookmarkApi(match.profileId.toString());
                        },
                        child: Icon(CupertinoIcons.heart_fill,
                            color: Theme.of(context).primaryColor, size: 32),
                      )
                          : GestureDetector(
                        onTap: () {
                          favControl.bookMarkSaveApi(
                            match.profileId.toString(),
                            Get.find<ProfileController>().userDetails!.id.toString(),
                          );
                        },
                        child: Icon(
                          isWished ? CupertinoIcons.heart_fill : Icons.favorite_border,
                          color: isWished ? Theme.of(context).primaryColor : Colors.grey,
                          size: 32,
                        ),
                      ),
                      dob: '$age yrs',
                      text: '',
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchesController>(
      builder: (matchesControl) {
        return GetBuilder<FilterController>(
          builder: (filterControl) {
            return SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          top: Dimensions.paddingSize10,
                          right: Dimensions.paddingSizeDefault, // Add padding to the right
                        ),
                        controller: _scrollController, // Add the scroll controller
                        itemCount: filterControl.matchFilterTopList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, i) {
                          final isSelected = i == _pageIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _pageIndex = i;
                                _pageController.jumpToPage(i);
                              });
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
                                filterControl.matchFilterTopList[i],
                                style: satoshiBold.copyWith(fontSize: Dimensions.fontSize18),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(color: Theme.of(context).disabledColor),
                    Expanded(
                      child: PageStorage(
                        bucket: PageStorageBucket(),
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _pageIndex = index;
                            });
                            _loadMatchesForFilter(index);
                          },
                          itemCount: filterControl.matchFilterTopList.length,
                          itemBuilder: (context, index) {
                            return _buildMatchesList(context, matchesControl);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _loadMatchesForFilter(int index) {
    final gender = Get.find<ProfileController>().profile?.basicInfo?.gender;
    final genderFilter = gender?.contains('Male') ?? false
        ? 'Female'
        : (gender?.contains('Female') ?? false ? 'Male' : 'Others');
    if (index == 0) {
      Get.find<MatchesController>().getMatches(
        '1', genderFilter, '2', '', '', '', '', '', '',
      );
    } else if (index == 1) {
      Get.find<MatchesController>().getMatches(
        '1', genderFilter, 'Muslim', '', '', '', '', '', '',
      );
    } else if (index == 2) {
      Get.find<MatchesController>().getMatches(
        '1', genderFilter, '', '', '', '', '', '', '',
      );
    } else if (index == 3) {
      Get.find<MatchesController>().getMatches(
        '1', genderFilter, '', '', '', '', '', '', '',
      );
    }
  }
}
