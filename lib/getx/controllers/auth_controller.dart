import 'package:bureau_couple/getx/data/response/community_model.dart';
import 'package:bureau_couple/getx/data/response/mother_tongue_model.dart';
import 'package:bureau_couple/getx/data/response/position_held.dart';
import 'package:bureau_couple/getx/data/response/profession_model.dart';
import 'package:bureau_couple/getx/data/response/religion_model.dart';
import 'package:bureau_couple/getx/features/widgets/date_converter.dart';
import 'package:bureau_couple/getx/repository/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;

  AuthController({
    required this.authRepo,
    required this.sharedPreferences,
  });

  int? _userId;

  int? get userId => _userId;

  String? firstNameString;
  String? lastNameString;

  XFile? _pickedImage;

  XFile? get pickedImage => _pickedImage;
  XFile? _pickedCover;

  XFile? get pickedCover => _pickedCover;

  void pickImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickedImage = null;
      _pickedCover = null;
    } else {
      if (isLogo) {
        _pickedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        _pickedCover =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      update();
    }
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<void> saveUserIdToPrefs(String userId) async {
    try {
      await sharedPreferences.setString(AppConstants.userId, userId);
      print('User ID saved to SharedPreferences: $userId');
    } catch (e) {
      print('Error saving User ID to SharedPreferences: $e');
    }
  }

  Future<String?> getUserIdFromPrefs() async {
    try {
      String? userId = sharedPreferences.getString(AppConstants.userId);
      print('User ID retrieved from SharedPreferences: $userId');
      return userId;
    } catch (e) {
      print('Error retrieving User ID from SharedPreferences: $e');
      return null;
    }
  }

  bool isFirstTime = true;
  bool _showPassView = false;
  bool _lengthCheck = false;
  bool _numberCheck = false;
  bool _uppercaseCheck = false;
  bool _lowercaseCheck = false;
  bool _spatialCheck = false;

  List<dynamic>? _additionalList;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get showPassView => _showPassView;

  bool get lengthCheck => _lengthCheck;

  bool get numberCheck => _numberCheck;

  bool get uppercaseCheck => _uppercaseCheck;

  bool get lowercaseCheck => _lowercaseCheck;

  List<dynamic>? get additionalList => _additionalList;

  // Future<void> loginApi(username, password,) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await authRepo.login(username, password);
  //   var responseData = response.body;
  //   if(responseData['status'] == "success") {
  //     _isLoading = false;
  //     update();
  //     showCustomSnackBar("Login Success",isError: false);
  //     authRepo.saveUserToken(responseData['data']['access_token']);
  //     Get.offAllNamed(RouteHelper.getDashboardRoute());
  //   } else {
  //     showCustomSnackBar("Login Failed Please Check Credentials",isError: false);
  //   }
  //   _isLoading = false;
  //   update();
  // }
  String? _from;
  String? _to;

  String? get from => _from;

  String? get to => _to;

  late DateTimeRange _selectedDateRange;

  void initSetDate() {
    _from = DateConverter.formatDate(
        DateTime.now().subtract(const Duration(days: 30)));
    _to = DateConverter.formatDate(DateTime.now());
  }

  void showDatePicker(
    BuildContext context,
  ) async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      saveText: 'done'.tr,
      confirmText: 'done'.tr,
      cancelText: 'cancel'.tr,
      fieldStartLabelText: 'start_date'.tr,
      fieldEndLabelText: 'end_date'.tr,
      errorInvalidRangeText: 'select_range'.tr,
    );

    if (result != null) {
      _selectedDateRange = result;

      _from = _selectedDateRange.start.toString().split(' ')[0];
      _to = _selectedDateRange.end.toString().split(' ')[0];
      print('======> Date From ${_from}');
      print('======> Date To ${_to}');
      update();
    }
  }




  DateTime? _batchFrom;
  DateTime? _batchTo;

  DateTime? get batchFrom => _batchFrom;

  DateTime? get batchTo => _batchTo;

  String get batchFromString =>
      _batchFrom != null ? '${_batchFrom!.year}' : 'Select';

  String get batchToString => _batchTo != null ? '${_batchTo!.year}' : 'Select';

  void showStartingYearPickerDialog() async {
    final pickedDate = await Get.dialog<DateTime>(
      YearPickerDialog(
        firstDate: DateTime(1980, 1),
        lastDate: DateTime.now(),
        initialDate: _batchFrom ?? DateTime.now(),
      ),
    );

    if (pickedDate != null) {
      _batchFrom = pickedDate;

      print('check batch from ========== >>${batchFromString}');
      update(); // Notify listeners that _batchFrom has changed
    }
  }

  void showEndingYearPickerDialog() async {
    final pickedDate = await Get.dialog<DateTime>(
      YearPickerDialog(
        firstDate: _batchFrom ?? DateTime(1980, 1),
        lastDate: DateTime.now(),
        initialDate: _batchTo ?? DateTime.now(),
      ),
    );

    if (pickedDate != null) {
      _batchTo = pickedDate;
      print('check batch from ========== >>${batchToString}');
      update(); // Notify listeners that _batchTo has changed
    }
  }

  final Map<String, List<String>> stateDistricts = {
    'Andhra Pradesh': ['Anantapur', 'Chittoor', 'East Godavari', 'Guntur'],
    'Arunachal Pradesh': ['Tawang', 'West Kameng', 'East Kameng'],
    'Assam': ['Baksa', 'Barpeta', 'Biswanath'],
    'Bihar': ['Araria', 'Arwal', 'Aurangabad'],
    'Chhattisgarh': ['Balod', 'Baloda Bazar', 'Balrampur'],
    'Goa': ['North Goa', 'South Goa'],
    'Gujarat': ['Ahmedabad', 'Amreli', 'Anand'],
    'Haryana': ['Ambala', 'Bhiwani', 'Charkhi Dadri'],
    'Himachal Pradesh': ['Bilaspur', 'Chamba', 'Hamirpur'],
    'Jharkhand': ['Bokaro', 'Chatra', 'Deoghar'],
    'Karnataka': ['Bagalkot', 'Bangalore Rural', 'Bangalore Urban'],
    'Kerala': ['Alappuzha', 'Ernakulam', 'Idukki'],
    'Madhya Pradesh': ['Agar Malwa', 'Alirajpur', 'Anuppur'],
    'Maharashtra': ['Ahmednagar', 'Akola', 'Amravati'],
    'Manipur': ['Bishnupur', 'Chandel', 'Churachandpur'],
    'Meghalaya': ['East Garo Hills', 'East Jaintia Hills', 'East Khasi Hills'],
    'Mizoram': ['Aizawl', 'Champhai', 'Kolasib'],
    'Nagaland': ['Dimapur', 'Kiphire', 'Kohima'],
    'Odisha': ['Angul', 'Balangir', 'Balasore'],
    'Punjab': ['Amritsar', 'Barnala', 'Bathinda'],
    'Rajasthan': ['Ajmer', 'Alwar', 'Banswara'],
    'Sikkim': ['East Sikkim', 'North Sikkim', 'South Sikkim'],
    'Tamil Nadu': ['Ariyalur', 'Chengalpattu', 'Chennai'],
    'Telangana': ['Adilabad', 'Bhadradri Kothagudem', 'Hyderabad'],
    'Tripura': ['Dhalai', 'Gomati', 'Khowai'],
    'Uttar Pradesh': ['Agra', 'Aligarh', 'Prayagraj'],
    'Uttarakhand': ['Almora', 'Bageshwar', 'Chamoli'],
    'West Bengal': ['Alipurduar', 'Bankura', 'Birbhum'],
    // Add remaining states and their districts
  };

  final Map<String, List<String>> posStateDistricts = {
    'Andhra Pradesh': ['Anantapur', 'Chittoor', 'East Godavari', 'Guntur'],
    'Arunachal Pradesh': ['Tawang', 'West Kameng', 'East Kameng'],
    'Assam': ['Baksa', 'Barpeta', 'Biswanath'],
    'Bihar': ['Araria', 'Arwal', 'Aurangabad'],
    'Chhattisgarh': ['Balod', 'Baloda Bazar', 'Balrampur'],
    'Goa': ['North Goa', 'South Goa'],
    'Gujarat': ['Ahmedabad', 'Amreli', 'Anand'],
    'Haryana': ['Ambala', 'Bhiwani', 'Charkhi Dadri'],
    'Himachal Pradesh': ['Bilaspur', 'Chamba', 'Hamirpur'],
    'Jharkhand': ['Bokaro', 'Chatra', 'Deoghar'],
    'Karnataka': ['Bagalkot', 'Bangalore Rural', 'Bangalore Urban'],
    'Kerala': ['Alappuzha', 'Ernakulam', 'Idukki'],
    'Madhya Pradesh': ['Agar Malwa', 'Alirajpur', 'Anuppur'],
    'Maharashtra': ['Ahmednagar', 'Akola', 'Amravati'],
    'Manipur': ['Bishnupur', 'Chandel', 'Churachandpur'],
    'Meghalaya': ['East Garo Hills', 'East Jaintia Hills', 'East Khasi Hills'],
    'Mizoram': ['Aizawl', 'Champhai', 'Kolasib'],
    'Nagaland': ['Dimapur', 'Kiphire', 'Kohima'],
    'Odisha': ['Angul', 'Balangir', 'Balasore'],
    'Punjab': ['Amritsar', 'Barnala', 'Bathinda'],
    'Rajasthan': ['Ajmer', 'Alwar', 'Banswara'],
    'Sikkim': ['East Sikkim', 'North Sikkim', 'South Sikkim'],
    'Tamil Nadu': ['Ariyalur', 'Chengalpattu', 'Chennai'],
    'Telangana': ['Adilabad', 'Bhadradri Kothagudem', 'Hyderabad'],
    'Tripura': ['Dhalai', 'Gomati', 'Khowai'],
    'Uttar Pradesh': ['Agra', 'Aligarh', 'Prayagraj'],
    'Uttarakhand': ['Almora', 'Bageshwar', 'Chamoli'],
    'West Bengal': ['Alipurduar', 'Bankura', 'Birbhum'],
    // Add remaining states and their districts
  };

  // var selectedState = ''.obs;
  // var selectedDistrict = ''.obs;

  String? _selectedState;

  String? get selectedState => _selectedState;

  String? _selectedDistrict;

  String? get selectedDistrict => _selectedDistrict;

  List<String> get states => stateDistricts.keys.toList();

  List<String> get districts =>
      _selectedState == null || _selectedState!.isEmpty
          ? []
          : stateDistricts[_selectedState!] ?? [];

  void setState(String state) {
    _selectedState = state;
    _selectedDistrict = null;
    update();
  }

  String? _selectedPosState;

  String? get selectedPosState => _selectedPosState;

  String? _selectedPosDistrict;

  String? get selectedPosDistrict => _selectedPosDistrict;

  List<String> get posStates => posStateDistricts.keys.toList();

  List<String> get posDistricts =>
      _selectedPosState == null || _selectedPosState!.isEmpty
          ? []
          : posStateDistricts[_selectedState!] ?? [];

  void setPosState(String state) {
    _selectedPosState = state;
    _selectedPosDistrict = null;
    update();
  }






  // void clearStateDistrict() {
  //   // _selectedState = null;
  //   _selectedDistrict = null; // Clear the selected district
  //   update();
  // }

  void setDistrict(String district) {
    _selectedDistrict = district;
    update();
  }

  void setPosDistrict(String district) {
    _selectedPosDistrict = district;
    update();
  }

  List<ReligionModel>? _religionList;

  List<ReligionModel>? get religionList => _religionList;

  int? _religionIndex = 0;

  int? get religionIndex => _religionIndex;

  List<int?> _religionIds = [];

  List<int?> get religionIds => _religionIds;

  int? _religionMainIndex = 0;
  int? get religionMainIndex => _religionMainIndex;
  void setReligionMainIndex(int? index, bool notify) {
    _religionMainIndex = index;
    if (notify) {
      update();
    }
  }

  int? _religionFilterIndex = 0;
  int? get religionFilterIndex => _religionFilterIndex;
  void setReligionFilterIndex(int? index, bool notify) {
    _religionFilterIndex = index;
    if (notify) {
      update();
    }
  }

  Future<void> getReligionsList() async {
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getAttributesUrl();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['religions'];
        _religionList =
            responseData.map((json) => ReligionModel.fromJson(json)).toList();
        _religionIds = [0, ..._religionList!.map((e) => e.id)];

        if (_religionList!.isNotEmpty) {
          _religionMainIndex = _religionList![0].id;
          _partnerReligion = _religionList![0].id;
        }
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
      }
    } catch (error) {
      print("Error while fetching list: $error");
    } finally {
      _isLoading = false;
      update();
    }
  }

  List<CommunityModel>? _communityList;

  List<CommunityModel>? get communityList => _communityList;

  List<int?> _communityIds = [];

  List<int?> get communityIds => _communityIds;
  int? _communityMainIndex = 0;

  int? get communityMainIndex => _communityMainIndex;

  void setCommunityMainListIndex(int? index, bool notify) {
    _communityMainIndex = index;
    if (notify) {
      update();
    }
  }


  int? _communityFilterIndex = 0;

  int? get communityFilterIndex => _communityFilterIndex;

  void setCommunityFilterIndex(int? index, bool notify) {
    _communityFilterIndex = index;
    if (notify) {
      update();
    }
  }


  Future<void> getCommunityList() async {
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getAttributesUrl();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['community'];
        _communityList =
            responseData.map((json) => CommunityModel.fromJson(json)).toList();
        _communityIds = [0, ..._communityList!.map((e) => e.id)];

        // Select the first item by default
        if (_communityList!.isNotEmpty) {
          _communityMainIndex = _communityList![0].id;
          _partnerCommunity = _communityList![0].id;
        }
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
        // Handle API error
        // ApiChecker.checkApi(response);
      }
    } catch (error) {
      // Handle errors, such as network failures
      _isLoading = false;
      update();
      print("Error while fetching list: $error");
      // You might want to set _mlaList and _mlaIds to null or empty lists here.
    } finally {
      _isLoading = false;
      update();
    }
  }

  int? _motherTongueIndex = 0;

  int? get motherTongueIndex => _motherTongueIndex;
  List<int?> _motherTongueIds = [];

  List<int?> get motherTongueIds => _motherTongueIds;
  List<MotherTongueModel>? _motherTongueList;

  List<MotherTongueModel>? get motherTongueList => _motherTongueList;

  void setMotherTongueIndex(int? index, bool notify) {
    _motherTongueIndex = index;
    if (notify) {
      update();
    }
  }

  int? _motherTongueFilterIndex = 0;
  int? get motherTongueFilterIndex => _motherTongueFilterIndex;
  void setMotherTongueFilterIndex(int? index, bool notify) {
    _motherTongueFilterIndex = index;
    if (notify) {
      update();
    }
  }


  Future<void> getMotherTongueList() async {
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getAttributesUrl();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['motherTongue'];
        _motherTongueList = responseData
            .map((json) => MotherTongueModel.fromJson(json))
            .toList();
        _motherTongueIds = [0, ..._motherTongueList!.map((e) => e.id)];
        _partnerMotherTongue = _motherTongueList![0].id;

        // Select the first item by default
        if (_motherTongueList!.isNotEmpty) {
          _motherTongueIndex = _motherTongueList![0].id;
        }
        _isLoading = false;
        update();
      } else {
        // Handle API error
        // ApiChecker.checkApi(response);
        _isLoading = false;
        update();
      }
    } catch (error) {
      // Handle errors, such as network failures
      print("Error while fetching list: $error");
      _isLoading = false;
      update();
    } finally {
      _isLoading = false;
      update();
    }
  }

  int? _professionIndex = 0;

  int? get professionIndex => _professionIndex;
  List<int?> _professionIds = [];

  List<int?> get professionIds => _professionIds;
  List<ProfessionModel>? _professionList;

  List<ProfessionModel>? get professionList => _professionList;

  void setProfessionIndex(int? index, bool notify) {
    _professionIndex = index;
    if (notify) {
      update();
    }
  }

  Future<void> getProfessionList() async {
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getAttributesUrl();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['profession'];
        _professionList =
            responseData.map((json) => ProfessionModel.fromJson(json)).toList();
        _professionIds = [0, ..._professionList!.map((e) => e.id)];

        if (_professionList!.isNotEmpty) {
          _professionIndex = _professionList![0].id;
          _partnerProfession = _professionList![0].id;
        }
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
      }
    } catch (error) {
      // Handle errors, such as network failures
      print("Error while fetching list: $error");
      _isLoading = false;
      update();
      // You might want to set _mlaList and _mlaIds to null or empty lists here.
    } finally {
      _isLoading = false;
      update();
    }
  }

  int? _positionHeldIndex = 0;

  int? get positionHeldIndex => _positionHeldIndex;
  List<int?> _positionHeldIds = [];

  List<int?> get positionHeldIds => _positionHeldIds;
  List<PositionHeldModel>? _positionHeldList;

  List<PositionHeldModel>? get positionHeldList => _positionHeldList;

  void setPositionIndex(int? index, bool notify) {
    _positionHeldIndex = index;
    if (notify) {
      update();
    }
  }

  Future<void> getPositionHeldList() async {
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getAttributesUrl();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['positionHeld'];
        _positionHeldList = responseData
            .map((json) => PositionHeldModel.fromJson(json))
            .toList();
        _positionHeldIds = [0, ..._positionHeldList!.map((e) => e.id)];

        // Select the first item by default
        if (_positionHeldList!.isNotEmpty) {
          _positionHeldIndex = _positionHeldList![0].id;
          _partnerPosition = _positionHeldList![0].id;
        }
        _isLoading = false;
        update();
      } else {
        // Handle API error
        // ApiChecker.checkApi(response);
      }
    } catch (error) {
      // Handle errors, such as network failures
      print("Error while fetching list: $error");
      _isLoading = false;
      update();
    } finally {
      _isLoading = false;
      update();
    }
  }

  String? _userName;

  String? get userName => _userName;

  String? _firstName;

  String? get firstName => _firstName;

  void setFirstName(String firstName) {
    _firstName = firstName;
    update();
  }

  String? _middleName;

  String? get middleName => _middleName;

  void setMiddleName(String middleName) {
    _middleName = middleName;
    update();
  }

  String? _lastName;

  String? get lastName => _lastName;

  void setLastName(String lastName) {
    _lastName = lastName;
    update();
  }

  String? _email;

  String? get email => _email;

  void setEmail(String email) {
    _email = email;
    update(); // Notify listeners that selectedState has changed
  }

  String? _phone;

  String? get phone => _phone;

  void setPhone(String phone) {
    _phone = phone;
    update(); // Notify listeners that selectedState has changed
  }

  String? _country;

  String? get country => _country;

  void setCountry(String country) {
    _country = country;
    update(); // Notify listeners that selectedState has changed
  }

  String? _state;

  String? get state => _state;

  void setstate(String state) {
    _state = state;
    update(); // Notify listeners that selectedState has changed
  }

  String? _posState;

  String? get posState => _posState;

  void setPosstate(String state) {
    _posState = state;
    update(); // Notify listeners that selectedState has changed
  }


  String? _district;

  String? get district => _district;

  void setDist(String district) {
    _district = district;
    update(); // Notify listeners that selectedState has changed
  }

  String? _posDistrict;

  String? get posDistrict => _posDistrict;

  void setPosDist(String district) {
    _posDistrict = district;
    update(); // Notify listeners that selectedState has changed
  }



  String? _password;

  String? get password => _password;

  void setPassword(String password) {
    _password = password;
    update(); // Notify listeners that selectedState has changed
  }

  void setUserName(String userName) {
    _userName = userName;
    update(); // Notify listeners that selectedState has changed
  }

  String? _gender = "M";
  String? get gender => _gender;

  void setGender(String? gender) {
    _gender = gender;
    update();
  }

  final List<String> financialConditionList = ["Below 3 Lacs","3 - 8 lacs","Above 8 lacs"];
  String? _financialCondition = "Below 3 Lacs";
  String? get financialCondition => _financialCondition;

  void setFinancialCondition(String? gender) {
    _financialCondition = gender;
    update();
  }

  String? _profession;

  String? get profession => _profession;

  void setProfession(String profession) {
    _profession = profession;
    update();
  }

  String? _positionHeld;

  String? get positionHeld => _positionHeld;

  void setPositionHeld(String positionHeld) {
    _positionHeld = positionHeld;
    update(); // Notify listeners that selectedState has changed
  }

  String? _cadar;

  String? get cadar => _cadar;

  void setCadar(String cadar) {
    _cadar = cadar;
    update();
  }

  String? _batchStartYear;

  String? get batchStartYear => _batchStartYear;

  void setBatchStartYear(String batchStartYear) {
    _batchStartYear = batchStartYear;
    update();
  }

  String? _batchEndYear;

  String? get batchEndYear => _batchEndYear;

  void setBatchEndYear(String batchEndYear) {
    _batchEndYear = batchEndYear;
    update();
  }

  String? _postingState;

  String? get postingState => _postingState;

  void setPPostingState(String postingState) {
    _postingState = postingState;
    update();
  }

  String? _postingDistrict;

  String? get postingDistrict => _postingDistrict;

  void setPPostingDistrict(String postingDistrict) {
    _postingDistrict = postingDistrict;
    update(); // Notify listeners that selectedState has changed
  }

  String? _postingStartDate;

  String? get postingStartDate => _postingStartDate;

  void setPostingStartDate(String postingStartDate) {
    _postingStartDate = postingStartDate;
    update();
  }

  String? _postingEndDate;

  String? get postingEndDate => _postingEndDate;

  void setPostingEndDate(String postingEndDate) {
    _postingEndDate = postingEndDate;
    update(); // Notify listeners that selectedState has changed
  }

  String? _highestDegree;

  String? get highestDegree => _highestDegree;

  void setHighestDegree(String highestDegree) {
    _highestDegree = highestDegree;
    update(); // Notify listeners that selectedState has changed
  }

  String? _fieldOfStudy;

  String? get fieldOfStudy => _fieldOfStudy;

  void setFieldOfStudy(String fieldOfStudy) {
    _fieldOfStudy = fieldOfStudy;
    update(); // Notify listeners that selectedState has changed
  }

  String? _institute;

  String? get institute => _institute;

  void setInstitute(String institute) {
    _institute = institute;
    update(); // Notify listeners that selectedState has changed
  }

  String? _dob;

  String? get dob => _dob;

  void setDob(String dob) {
    _dob = dob;
    update(); // Notify listeners that selectedState has changed
  }




/// PARTNER EXPECTATION VARIABLES //

  final List<String> smokingStatus = ["Yes","No",];
  final List<String> drinkingStatus = ["Yes","No",];

  int? _partnerProfessionIndex = 0;
  int? get partnerProfessionIndex => _partnerProfessionIndex;
  void setPartnerProfessionIndex(int? index, bool notify) {
    _partnerProfessionIndex = index;
    if (notify) {
      update();
    }}

  int? _partnerProfession;
  int? get partnerProfession => _partnerProfession;



  void setPartnerProfession(int val) {
    _partnerProfession = val;
    update();
  }

  int? _partnerReligion;
  int? get partnerReligion => _partnerReligion;

  void setPartnerReligion(int val) {
    _partnerReligion = val;
    update();
  }

  int? _partnerMotherTongue;
  int? get partnerMotherTongue => _partnerMotherTongue;

  void setPartnerMotherTongue(int val) {
    _partnerMotherTongue = val;
    update();
  }

  int? _partnerCommunity;
  int? get partnerCommunity => _partnerCommunity;

  void setPartnerCommunity(int val) {
    _partnerCommunity = val;
    update();
  }

  int? _partnerPosition;
  int? get partnerPosition => _partnerPosition;

  void setPartnerPosition(int val) {
    _partnerPosition = val;
    update();
  }

  String? _partnerMinAge;
  String? get partnerMinAge => _partnerMinAge;

  void setPartnerMinAge(String val) {
    _partnerMinAge = val;
    update();
  }

  String? _partnerMaxAge;
  String? get partnerMaxAge => _partnerMaxAge;

  void setPartnerMaxAge(String val) {
    _partnerMaxAge = val;
    update();
  }

  String? _partnerMinHeight;
  String? get partnerMinHeight => _partnerMinHeight;

  void setPartnerMinHeight(String val) {
    _partnerMinHeight = val;
    update();
  }

  String? _partnerMaxHeight;
  String? get partnerMaxHeight => _partnerMaxHeight;

  void setPartnerMaxHeight(String val) {
    _partnerMaxHeight = val;
    update();
  }

  String? _partnerSmokingStatus  = 'Yes';
  String? get partnerSmokingStatus => _partnerSmokingStatus;

  void setPartnerSmokingStatus(String val) {
    _partnerSmokingStatus = val;
    update();
  }

  String? _partnerDrinkingStatus = 'Yes';
  String? get partnerDrinkingStatus => _partnerDrinkingStatus;

  void setPartnerDrinkingStatus(String val) {
    _partnerDrinkingStatus = val;
    update();
  }

}
















class YearPickerDialog extends StatelessWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;

  YearPickerDialog({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Year"),
      content: Container(
        width: 300,
        height: 300,
        child: YearPicker(
          firstDate: firstDate,
          lastDate: lastDate,
          initialDate: initialDate ?? DateTime.now(),
          selectedDate: initialDate ?? DateTime.now(),
          onChanged: (DateTime dateTime) {
            Get.back(result: dateTime);
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle confirmation if needed
            Get.back();
          },
          child: Text('OK'),
        ),
      ],
    );
  }






}
