
import 'package:bureau_couple/getx/repository/repo/matches_repo.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

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


  List<MatchesModel>? _matchesList;
  List<MatchesModel>? get matchesList => _matchesList;

  // int? _matchesIndex = 0;
  // int? get matches => _matchesIndex;

  void setOffset(int offset) {
    _offset= offset;
  }

  void showBottomLoader () {
    _isLoading = true;
    update();
  }




  Future<void> getMatchesList( String page,
      String gender,
      String religion,
      String state,
      String minHeight,
      String maxHeight,
      String maxWeight,
      String motherTongue) async {
    _isLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        // _type = type;
        _matchesList = null;
        // _matchesList = []; // Reset product list for first page
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page);

        Response response = await matchesRepo.getMatchesList(page, gender, religion, state, minHeight, maxHeight, maxWeight, motherTongue);

        if (response.statusCode == 200) {
          List<dynamic> responseData = response.body['data']['members']['data'];
          List<MatchesModel> newDataList = responseData.map((json) => MatchesModel.fromJson(json)).toList();

          if (page == '1') {
            // Reset product list for first page
            _matchesList = newDataList;
          } else {
            // Append data for subsequent pages
            _matchesList!.addAll(newDataList);
          }

          _pageSize = response.body['data']['members']['per_page'];
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
      print('Error fetching food list: $e');
      _isLoading = false;
      update();
    }
  }

  // Future<void> getEventList(String page) async {
  //   // _isLoading = true;
  //   // update();
  //
  //   try {
  //     if (page == '1') {
  //       _pageList = [];
  //       _offset = 1;
  //       _eventList = []; // Reset product list for first page
  //       update();
  //     }
  //
  //     if (!_pageList.contains(page)) {
  //       _pageList.add(page);
  //       Response response = await newsRepo.getNewsList(page);
  //       if (response.statusCode == 200) {
  //         List<dynamic> responseData = response.body['data']['newslist']['data'];
  //         List<EventListModel> newDataList = [];
  //         for (var addon in responseData) {
  //           if (addon['category'] == "2") {
  //             newDataList.add(EventListModel.fromJson(addon));
  //           }
  //         }
  //
  //         if (page == '1') {
  //           _eventList = newDataList;
  //         } else {
  //           // _isLoading = true;
  //           _eventList!.addAll(newDataList);
  //         }
  //
  //         _pageSize = response.body['data']['newslist']['per_page'];
  //         _isLoading = false;
  //         print("===========>  print page size${_pageSize}");
  //         update();
  //       } else {
  //         ApiChecker.checkApi(response);
  //       }
  //     } else {
  //       // Page already loaded or in process, handle loading state
  //       if (_isLoading) {
  //         _isLoading = false;
  //         update();
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching food list: $e');
  //     _isLoading = false;
  //     update();
  //   }
  // }

  // Future<List<int?>> getEventList() async {
  //   _isLoading = true;
  //   update();
  //   Response response = await newsRepo.getNewsList("1");
  //   List<int?> eventId = [];
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseBody = response.body;
  //     if (responseBody.containsKey('data')) {
  //       List<dynamic>? newsListData = responseBody['data']['newslist']['data'];
  //       if (newsListData != null) {
  //         _eventList = [];
  //         for (var addon in newsListData) {
  //           if(addon['category'] == "2") {
  //             _eventList!.add(EventListModel.fromJson(addon));
  //           }
  //         }
  //       }
  //     }
  //   } else {
  //     // Handle other status codes
  //   }
  //   _isLoading = false;
  //   update();
  //   return eventId;
  // }

  Future<void> bookMarkSaveApi(String? profileId,) async {
    _isLoading = true;
    update();

    Response response = await matchesRepo.bookMarkSave(profileId);
    if(response.statusCode == 200) {
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

    Response response = await matchesRepo.bookMarkUnSave(profileId);
    if(response.statusCode == 200) {
      // Get.offAllNamed(RouteHelper.getSignInRoute());
      // showCustomSnackBar('Password Changed Successful', isError: false);
    }else {
      // ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
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

