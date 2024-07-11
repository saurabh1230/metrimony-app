
import 'package:bureau_couple/getx/repository/repo/matches_repo.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

import '../../src/models/matches_model.dart';




class FavouriteController extends GetxController implements GetxService {
  final MatchesRepo matchesRepo;

  FavouriteController({required this.matchesRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isConnected = false;

  bool get connected => _isConnected;

  void setConnected(bool value) {
    _isConnected = value;
    update();
  }


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





  List<int?> _isBookmarkList = [];
  List<int?> get isBookmarkList => _isBookmarkList;


  Future<void> bookMarkSaveApi(String? profileId,String? userId,) async {
    _isLoading = true;
    update();

    Response response = await matchesRepo.bookMarkSave(profileId,userId);
    if(response.statusCode == 200) {
      _isBookmarkList.add(int.parse(profileId!));
    }else {
      // ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }


  Future<void> unSaveBookmarkApi(String? profileId) async {
    _isLoading = true;
    update();

    Response response = await matchesRepo.bookMarkUnSave(profileId);
    if (response.statusCode == 200) {
      _isBookmarkList.remove(int.parse(profileId!));
    } else {
      // ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }
  // Future<void> unSaveBookmarkApi(String? profileId,) async {
  //   _isLoading = true;
  //   update();
  //
  //   Response response = await matchesRepo.bookMarkUnSave(profileId);
  //   if(response.statusCode == 200) {
  //     int idIndex = -1;
  //     _isBookmarkList.removeAt(int.parse(profileId!));
  //     // _isBookmarkList.add(int.parse(profileId!));
  //     // Get.offAllNamed(RouteHelper.getSignInRoute());
  //     // showCustomSnackBar('Password Changed Successful', isError: false);
  //   }else {
  //     // ApiChecker.checkApi(response);
  //   }
  //   _isLoading = false;
  //   update();
  // }

  List<int?> _isConnectedIntList = [];
  List<int?> get isConnectedIntList => _isConnectedIntList;
  Future<void> sendRequestApi(String? userId,String? profileId,) async {
    _isLoading = true;
    update();

    Response response = await matchesRepo.sendRequest(userId,profileId);
    if(response.statusCode == 200) {
      _isConnectedIntList.add(int.parse(profileId!));
      // List<dynamic> errors =
      // value['message']['error'];
      // String errorMessage = errors
      //     .isNotEmpty
      //     ? errors[0]
      //     : "An unknown error occurred.";
      // Fluttertoast.showToast(
      //     msg: errorMessage);
    }else {
      // ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  List<int?> _requestSent = [];
  List<int?> get requestSent => _requestSent;







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

