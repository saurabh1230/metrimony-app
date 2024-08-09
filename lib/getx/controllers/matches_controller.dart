
import 'package:bureau_couple/getx/data/response/single_match_model.dart';
import 'package:bureau_couple/getx/repository/repo/matches_repo.dart';
import 'package:bureau_couple/getx/utils/app_constants.dart';
import 'package:bureau_couple/src/models/other_person_details_models.dart';
import 'package:bureau_couple/src/models/saved_matches_model.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

import '../../src/apis/members_api.dart';
import '../../src/models/matches_model.dart';




class MatchesController extends GetxController implements GetxService {
  final MatchesRepo matchesRepo;

  MatchesController({required this.matchesRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _offset = 1;
  int get offset => _offset;
  List<String> _pageList = [];
  int? _pageSize;
  int? get pageSize => _pageSize;


  // List<SingleMatchModel>? _matchesList;
  // List<SingleMatchModel>? get matchesList => _matchesList;

  // Future<void> getMatchesList(
  //     String page,
  //     String gender,
  //     String religion,
  //     String state,
  //     String minHeight,
  //     String maxHeight,
  //     String maxWeight,
  //     String motherTongue,
  //     String community) async {
  //   _isLoading = true;
  //   update(); // Notify listeners that loading has started
  //
  //   try {
  //     Response response = await matchesRepo.getMatchesList(
  //         page, gender, religion, state, minHeight, maxHeight, maxWeight, motherTongue, community
  //     );
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> responseData = response.body['data']['members'];
  //       List<SingleMatchModel> newDataList = responseData.map((json) => SingleMatchModel.fromJson(json)).toList();
  //
  //       // Update matches list with the new data
  //       _matchesList = newDataList;
  //
  //       _isLoading = false;
  //       update(); // Notify listeners that loading has completed
  //     } else {
  //       // Handle error case if needed
  //       print('Failed to fetch matches list: ${response.statusCode}');
  //       _isLoading = false;
  //       update();
  //     }
  //   } catch (e) {
  //     print('Error fetching matches list: $e');
  //     _isLoading = false;
  //     update();
  //   }
  // }


  // Future>> getMatchesList(
  //     String page,
  //         String gender,
  //         String religion,
  //         String state,
  //         String minHeight,
  //         String maxHeight,
  //         String maxWeight,
  //         String motherTongue,
  //         String community
  //     ) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await matchesRepo.getMatchesList(
  //               page, gender, religion, state, minHeight, maxHeight, maxWeight, motherTongue, community
  //           );
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseBody = response.body; // Assuming response body is a Map
  //     _matchesList!.add(SingleMatchModel.fromJson(responseBody));
  //
  //   }
  //   _isLoading = false;
  //   update();
  // }

  void setOffset(int offset) {
    _offset= offset;
  }

  void showBottomLoader () {
    _isLoading = true;
    update();
  }


  // Future<void> getMatchesList(
  //     String page,
  //     String gender,
  //     String religion,
  //     String state,
  //     String minHeight,
  //     String maxHeight,
  //     String maxWeight,
  //     String motherTongue,
  //     String community) async {
  //   _isLoading = true;
  //   try {
  //     if (page == '1') {
  //       _pageList = []; // Reset page list for new search
  //       _offset = 1;
  //       // _type = type;
  //       _matchesList = []; // Reset product list for first page
  //       update();
  //     }
  //
  //     if (!_pageList.contains(page)) {
  //       _pageList.add(page)
  //       ;
  //
  //       Response response = await matchesRepo.getMatchesList(
  //           page, gender, religion, state, minHeight, maxHeight, maxWeight, motherTongue, community
  //       );
  //
  //       if (response.statusCode == 200) {
  //         List<dynamic> responseData = response.body['data']['members'];
  //         List<SingleMatchModel> newDataList = responseData.map((json) => SingleMatchModel.fromJson(json)).toList();
  //
  //         if (page == '1') {
  //           // Reset product list for first page
  //           _matchesList = newDataList;
  //         } else {
  //           // Append data for subsequent pages
  //           _matchesList!.addAll(newDataList);
  //         }
  //
  //         // _pageSize = response.body['data']['newslist']['per_page'];
  //         _isLoading = false;
  //         update();
  //       } else {
  //         // ApiChecker.checkApi(response);
  //       }
  //     } else {
  //       // Page already loaded or in process, handle loading state
  //       if (_isLoading) {
  //         _isLoading = false;
  //         update();
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching MATCHES list: $e');
  //     _isLoading = false;
  //     update();
  //   }
  // }

  // Future<void> getMatchesList(
  //     String page,
  //     String gender,
  //     String religion,
  //     String state,
  //     String minHeight,
  //     String maxHeight,
  //     String maxWeight,
  //     String motherTongue,
  //     String community
  //     ) async {
  //   _isLoading = true;
  //   try {
  //     if (page == '1') {
  //       _pageList = []; // Reset page list for new search
  //       _offset = 1;
  //       _matchesList = []; // Reset matches list for first page
  //       update();
  //     }
  //
  //     if (!_pageList.contains(page)) {
  //       _pageList.add(page);
  //
  //       Response response = await matchesRepo.getMatchesList(
  //           page, gender, religion, state, minHeight, maxHeight, maxWeight, motherTongue, community
  //       );
  //
  //       if (response.statusCode == 200) {
  //         var responseBody = response.body;
  //         if (responseBody is Map<String, dynamic>) {
  //           var data = responseBody['data'];
  //           if (data is Map<String, dynamic>) {
  //             var members = data['members'];
  //             if (members is Map<String, dynamic>) {
  //               var membersData = members['data'];
  //               if (membersData is List<dynamic>) {
  //                 List<SingleMatchModel> newDataList = membersData.map((json) => SingleMatchModel.fromJson(json)).toList();
  //
  //                 if (page == '1') {
  //                   _matchesList = newDataList;
  //                 } else {
  //                   _matchesList!.addAll(newDataList);
  //                 }
  //
  //                 _pageSize = members['per_page'] is int ? members['per_page'] : int.tryParse(members['per_page'].toString()) ?? 0;
  //                 _isLoading = false;
  //                 update();
  //               } else {
  //                 print('Expected a List for members data, but got ${membersData.runtimeType}');
  //               }
  //             } else {
  //               print('Expected a Map for members, but got ${members.runtimeType}');
  //             }
  //           } else {
  //             print('Expected a Map for data, but got ${data.runtimeType}');
  //           }
  //         } else {
  //           print('Expected a Map for response body, but got ${responseBody.runtimeType}');
  //         }
  //       } else {
  //         // Handle API error response
  //         print('API error: ${response.statusCode}');
  //       }
  //     } else {
  //       if (_isLoading) {
  //         _isLoading = false;
  //         update();
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching matches list: $e');
  //     _isLoading = false;
  //     update();
  //   }
  // }



  List<SavedMatchesModel>? _savedMatchesList;
  List<SavedMatchesModel>? get savedMatchesList => _savedMatchesList;

  Future<void> getSavedMatchesList( String page,
     ) async {
    _isLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        // _type = type;
        _savedMatchesList = null;
        // _matchesList = []; // Reset product list for first page
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await matchesRepo.getSavedMatchesList(page,);

        if (response.statusCode == 200) {
          List<dynamic> responseData = response.body['data']['shortlists']['data'];
          List<SavedMatchesModel> newDataList = responseData.map((json) => SavedMatchesModel.fromJson(json)).toList();

          if (page == '1') {
            _savedMatchesList = newDataList;
          } else {
            _savedMatchesList!.addAll(newDataList);
          }

          _pageSize = response.body['data']['shortlists']['per_page'];
          _isLoading = false;
          update();
        } else {
          // ApiChecker.checkApi(response);
        }
      } else {
        // Page already loaded or in process, handle loading state
        if (_isLoading) {
          _isLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching shortlists list: $e');
      _isLoading = false;
      update();
    }
  }


  OtherProfileModel? _otherUserDetails;
  OtherProfileModel? get otherUserDetails => _otherUserDetails;

  // Future<OtherProfileModel?> getOtherUserDetailsApi(otherUserId) async {
  //   _isLoading = true;
  //   _otherUserDetails = null;
  //   update();
  //   Response response = await profileRepo.getOtherUserProfile(otherUserId);
  //   var responseData = response.body;
  //   if(responseData['status'] == true) {
  //     _otherUserDetails = OtherProfileModel.fromJson(responseData);
  //     _isLoading = false;
  //     update();
  //   } else {
  //     print("Api Error ===================== >>");
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return _otherUserDetails;
  // }

  List<int?> _isBookmarkList = [];
  List<int?> get isBookmarkList => _isBookmarkList;


  Future<void> bookMarkSaveApi(String? profileId,) async {
    _isLoading = true;
    update();

    Response response = await matchesRepo.bookMarkSave(profileId,"");
    if(response.statusCode == 200) {
      _isBookmarkList.add(int.parse(profileId!));
      // Get.offAllNamed(RouteHelper.getSignInRoute());
      // showCustomSnackBar('Password Changed Successful', isError: false);
    }else {
      // ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> unSaveBookmarkApi(String? profileId,) async {
    _isLoading = true;
    update();

    Response response = await matchesRepo.bookMarkUnSave(profileId,);
    if(response.statusCode == 200) {
      // Get.offAllNamed(RouteHelper.getSignInRoute());
      // showCustomSnackBar('Password Changed Successful', isError: false);
    }else {
      // ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  // List<MatchesModel> _matches = [];
  // List<MatchesModel> get matches => _matches;
  // fetchMatches() {
  //   matches.clear();
  //   _isLoading = true;
  //   update();
  //   getNewMatchesApi(page: '',
  //     gender: "", religion: '',).then((value) {
  //         if (value['status'] == true) {
  //           for (var v in value['data']['members']['data']) {
  //             matches.add(MatchesModel.fromJson(v));
  //           }
  //           _isLoading = false;
  //           update();
  //         } else {
  //           _isLoading = false;
  //           update();
  //         }
  //         _isLoading = false;
  //         update();
  //
  //   });
  // }

  List<MatchesModel> _matchesList = [];
  List<MatchesModel> get matchesList => _matchesList;

  void getMatches(
      String page,
      String gender,
      String religion,
      String profession,
      String state,
      String height,
      String country,
      String motherTongue,
      String community
      ) async {
    _matchesList = [];
    _matchesList.clear();
    print('check Api======>');
    try {
      _isLoading = true;
    update();
      final result = await matchesRepo.getMatchesApi(
          page: page,
          gender: gender,
          religion: religion,
          profession: profession,
          state: state,
          height: height,
          country: country,
          montherTongue: motherTongue,
          community: community);

      if (result['status'] == true) {
        final newMatches = (result['data']['members'] as List)
            .map((v) => MatchesModel.fromJson(v))
            .toList();
        _matchesList.addAll(newMatches);
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      update();
    }
  }

  final List<String> images = [
    "assets/images/latestnews1.png",
    "assets/images/latestnews1.png",
    "assets/images/latestnews1.png",
    "assets/images/latestnews1.png",
  ];

  int _categoryIndex = 0;
  int get categoryIndex => _categoryIndex;
  void setCategoryIndex(int index) {
    _categoryIndex = index;
    update();
  }
  int _bannerIndex = 0;
  int get bannerIndex => _bannerIndex;
  void setBannerIndex(int index) {
    _bannerIndex = index;
    update();
  }
  final CarouselController _carouselController = CarouselController();
  final List<String> bannerImages = [
    "assets/images/bannerdemo.jpg",
    "assets/images/bannerdemo.jpg",
    "assets/images/bannerdemo.jpg",
  ];

}

