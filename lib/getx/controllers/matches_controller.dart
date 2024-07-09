
import 'package:bureau_couple/getx/repository/repo/matches_repo.dart';
import 'package:bureau_couple/src/models/saved_matches_model.dart';
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
      print('Error fetching  list: $e');
      _isLoading = false;
      update();
    }
  }







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

