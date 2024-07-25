import 'dart:io';

import 'package:bureau_couple/getx/data/response/community_list_model.dart';
import 'package:bureau_couple/getx/data/response/community_model.dart';
import 'package:bureau_couple/getx/data/response/married_status_model.dart';
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
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../utils/app_constants.dart';
import '../utils/colors.dart';

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
    'Andhra Pradesh': ['Anantapur', 'Chittoor', 'East Godavari', 'Guntur', 'Krishna', 'Kurnool', 'Prakasam', 'Srikakulam', 'Sri Potti Sriramulu Nellore', 'Visakhapatnam', 'Vizianagaram', 'West Godavari', 'YSR Kadapa'],
    'Arunachal Pradesh': ['Tawang', 'West Kameng', 'East Kameng', 'Papum Pare', 'Kurung Kumey', 'Kra Daadi', 'Lower Subansiri', 'Upper Subansiri', 'West Siang', 'East Siang', 'Siang', 'Upper Siang', 'Lower Siang', 'Lower Dibang Valley', 'Dibang Valley', 'Anjaw', 'Lohit', 'Namsai', 'Changlang', 'Tirap', 'Longding'],
    'Assam': ['Baksa', 'Barpeta', 'Biswanath', 'Bongaigaon', 'Cachar', 'Charaideo', 'Chirang', 'Darrang', 'Dhemaji', 'Dhubri', 'Dibrugarh', 'Goalpara', 'Golaghat', 'Hailakandi', 'Hojai', 'Jorhat', 'Kamrup Metropolitan', 'Kamrup', 'Karbi Anglong', 'Karimganj', 'Kokrajhar', 'Lakhimpur', 'Majuli', 'Morigaon', 'Nagaon', 'Nalbari', 'Dima Hasao', 'Sivasagar', 'Sonitpur', 'South Salmara-Mankachar', 'Tinsukia', 'Udalguri', 'West Karbi Anglong'],
    'Bihar': ['Araria', 'Arwal', 'Aurangabad', 'Banka', 'Begusarai', 'Bhagalpur', 'Bhojpur', 'Buxar', 'Darbhanga', 'East Champaran (Motihari)', 'Gaya', 'Gopalganj', 'Jamui', 'Jehanabad', 'Kaimur (Bhabua)', 'Katihar', 'Khagaria', 'Kishanganj', 'Lakhisarai', 'Madhepura', 'Madhubani', 'Munger (Monghyr)', 'Muzaffarpur', 'Nalanda', 'Nawada', 'Patna', 'Purnia (Purnea)', 'Rohtas', 'Saharsa', 'Samastipur', 'Saran', 'Sheikhpura', 'Sheohar', 'Sitamarhi', 'Siwan', 'Supaul', 'Vaishali', 'West Champaran'],
    'Chhattisgarh': ['Balod', 'Baloda Bazar', 'Balrampur', 'Bastar', 'Bemetara', 'Bijapur', 'Bilaspur', 'Dantewada (South Bastar)', 'Dhamtari', 'Durg', 'Gariyaband', 'Janjgir-Champa', 'Jashpur', 'Kabirdham (Kawardha)', 'Kanker (North Bastar)', 'Kondagaon', 'Korba', 'Koriya', 'Mahasamund', 'Mungeli', 'Narayanpur', 'Raigarh', 'Raipur', 'Rajnandgaon', 'Sukma', 'Surajpur', 'Surguja'],
    'Goa': ['North Goa', 'South Goa'],
    'Gujarat': ['Ahmedabad', 'Amreli', 'Anand', 'Aravalli', 'Banaskantha (Palanpur)', 'Bharuch', 'Bhavnagar', 'Botad', 'Chhota Udepur', 'Dahod', 'Dangs (Ahwa)', 'Devbhoomi Dwarka', 'Gandhinagar', 'Gir Somnath', 'Jamnagar', 'Junagadh', 'Kheda (Nadiad)', 'Kutch', 'Mahisagar', 'Mehsana', 'Morbi', 'Narmada (Rajpipla)', 'Navsari', 'Panchmahal (Godhra)', 'Patan', 'Porbandar', 'Rajkot', 'Sabarkantha (Himmatnagar)', 'Surat', 'Surendranagar', 'Tapi (Vyara)', 'Vadodara', 'Valsad'],
    'Haryana': ['Ambala', 'Bhiwani', 'Charkhi Dadri', 'Faridabad', 'Fatehabad', 'Gurgaon', 'Hisar', 'Jhajjar', 'Jind', 'Kaithal', 'Karnal', 'Kurukshetra', 'Mahendragarh', 'Mewat', 'Palwal', 'Panchkula', 'Panipat', 'Rewari', 'Rohtak', 'Sirsa', 'Sonipat', 'Yamunanagar'],
    'Himachal Pradesh': ['Bilaspur', 'Chamba', 'Hamirpur', 'Kangra', 'Kinnaur', 'Kullu', 'Lahaul & Spiti', 'Mandi', 'Shimla', 'Sirmaur (Sirmour)', 'Solan', 'Una'],
    'Jharkhand': ['Bokaro', 'Chatra', 'Deoghar', 'Dhanbad', 'Dumka', 'East Singhbhum', 'Garhwa', 'Giridih', 'Godda', 'Gumla', 'Hazaribag', 'Jamtara', 'Khunti', 'Koderma', 'Latehar', 'Lohardaga', 'Pakur', 'Palamu', 'Ramgarh', 'Ranchi', 'Sahebganj', 'Seraikela-Kharsawan', 'Simdega', 'West Singhbhum'],
    'Karnataka': ['Bagalkot', 'Bangalore Rural', 'Bangalore Urban', 'Belgaum', 'Bellary', 'Bidar', 'Chamarajanagar', 'Chikkaballapur', 'Chikkamagaluru', 'Chitradurga', 'Dakshina Kannada', 'Davanagere', 'Dharwad', 'Gadag', 'Gulbarga', 'Hassan', 'Haveri', 'Kodagu', 'Kolar', 'Koppal', 'Mandya', 'Mysore', 'Raichur', 'Ramanagara', 'Shimoga', 'Tumkur', 'Udupi', 'Uttara Kannada', 'Vijayapura', 'Yadgir'],
    'Kerala': ['Alappuzha', 'Ernakulam', 'Idukki', 'Kannur', 'Kasaragod', 'Kollam', 'Kottayam', 'Kozhikode', 'Malappuram', 'Palakkad', 'Pathanamthitta', 'Thiruvananthapuram', 'Thrissur', 'Wayanad'],
    'Madhya Pradesh': ['Agar Malwa', 'Alirajpur', 'Anuppur', 'Ashoknagar', 'Balaghat', 'Barwani', 'Betul', 'Bhind', 'Bhopal', 'Burhanpur', 'Chhatarpur', 'Chhindwara', 'Damoh', 'Datia', 'Dewas', 'Dhar', 'Dindori', 'Guna', 'Gwalior', 'Harda', 'Hoshangabad', 'Indore', 'Jabalpur', 'Jhabua', 'Katni', 'Khandwa', 'Khargone', 'Mandla', 'Mandsaur', 'Morena', 'Narsinghpur', 'Neemuch', 'Panna', 'Raisen', 'Rajgarh', 'Ratlam', 'Rewa', 'Sagar', 'Satna', 'Sehore', 'Seoni', 'Shahdol', 'Shajapur', 'Sheopur', 'Shivpuri', 'Sidhi', 'Singrauli', 'Tikamgarh', 'Ujjain', 'Umaria', 'Vidisha'],
    'Maharashtra': ['Ahmednagar', 'Akola', 'Amravati', 'Aurangabad', 'Beed', 'Bhandara', 'Buldhana', 'Chandrapur', 'Dhule', 'Gadchiroli', 'Gondia', 'Hingoli', 'Jalgaon', 'Jalna', 'Kolhapur', 'Latur', 'Mumbai City', 'Mumbai Suburban', 'Nagpur', 'Nanded', 'Nandurbar', 'Nashik', 'Osmanabad', 'Palghar', 'Parbhani', 'Pune', 'Raigad', 'Ratnagiri', 'Sangli', 'Satara', 'Sindhudurg', 'Solapur', 'Thane', 'Wardha', 'Washim', 'Yavatmal'],
    'Manipur': ['Bishnupur', 'Chandel', 'Churachandpur', 'Imphal East', 'Imphal West', 'Jiribam', 'Kakching', 'Kamjong', 'Kangpokpi', 'Noney', 'Pherzawl', 'Senapati', 'Tamenglong', 'Tengnoupal', 'Thoubal', 'Ukhrul'],
    'Meghalaya': ['East Garo Hills', 'East Jaintia Hills', 'East Khasi Hills', 'North Garo Hills', 'Ri Bhoi', 'South Garo Hills', 'South West Garo Hills', 'South West Khasi Hills', 'West Garo Hills', 'West Jaintia Hills', 'West Khasi Hills'],
    'Mizoram': ['Aizawl', 'Champhai', 'Kolasib', 'Lawngtlai', 'Lunglei', 'Mamit', 'Saiha', 'Serchhip'],
    'Nagaland': ['Dimapur', 'Kiphire', 'Kohima', 'Longleng', 'Mokokchung', 'Mon', 'Peren', 'Phek', 'Tuensang', 'Wokha', 'Zunheboto'],
    'New Delhi': ['Central Delhi', 'East Delhi', 'New Delhi', 'North Delhi', 'North East Delhi', 'North West Delhi', 'Shahdara', 'South Delhi', 'South East Delhi', 'South West Delhi', 'West Delhi'],
    'Odisha': ['Angul', 'Balangir', 'Balasore', 'Bargarh', 'Bhadrak', 'Boudh', 'Cuttack', 'Deogarh', 'Dhenkanal', 'Gajapati', 'Ganjam', 'Jagatsinghpur', 'Jajpur', 'Jharsuguda', 'Kalahandi', 'Kandhamal', 'Kendrapara', 'Kendujhar (Keonjhar)', 'Khordha', 'Koraput', 'Malkangiri', 'Mayurbhanj', 'Nabarangpur', 'Nayagarh', 'Nuapada', 'Puri', 'Rayagada', 'Sambalpur', 'Sonepur', 'Sundargarh'],
    'Punjab': ['Amritsar', 'Barnala', 'Bathinda', 'Faridkot', 'Fatehgarh Sahib', 'Fazilka', 'Ferozepur', 'Gurdaspur', 'Hoshiarpur', 'Jalandhar', 'Kapurthala', 'Ludhiana', 'Mansa', 'Moga', 'Muktsar', 'Nawanshahr (Shahid Bhagat Singh Nagar)', 'Pathankot', 'Patiala', 'Rupnagar', 'Sahibzada Ajit Singh Nagar (Mohali)', 'Sangrur', 'Tarn Taran'],
    'Rajasthan': ['Ajmer', 'Alwar', 'Banswara', 'Baran', 'Barmer', 'Bharatpur', 'Bhilwara', 'Bikaner', 'Bundi', 'Chittorgarh', 'Churu', 'Dausa', 'Dholpur', 'Dungarpur', 'Hanumangarh', 'Jaipur', 'Jaisalmer', 'Jalore', 'Jhalawar', 'Jhunjhunu', 'Jodhpur', 'Karauli', 'Kota', 'Nagaur', 'Pali', 'Pratapgarh', 'Rajsamand', 'Sawai Madhopur', 'Sikar', 'Sirohi', 'Sri Ganganagar', 'Tonk', 'Udaipur'],
    'Sikkim': ['East Sikkim', 'North Sikkim', 'South Sikkim', 'West Sikkim'],
    'Tamil Nadu': ['Ariyalur', 'Chengalpattu', 'Chennai', 'Coimbatore', 'Cuddalore', 'Dharmapuri', 'Dindigul', 'Erode', 'Kallakurichi', 'Kanchipuram', 'Kanyakumari', 'Karur', 'Krishnagiri', 'Madurai', 'Nagapattinam', 'Namakkal', 'Nilgiris', 'Perambalur', 'Pudukkottai', 'Ramanathapuram', 'Ranipet', 'Salem', 'Sivaganga', 'Tenkasi', 'Thanjavur', 'Theni', 'Thoothukudi (Tuticorin)', 'Tiruchirappalli', 'Tirunelveli', 'Tirupathur', 'Tiruppur', 'Tiruvallur', 'Tiruvannamalai', 'Tiruvarur', 'Vellore', 'Viluppuram', 'Virudhunagar'],
    'Telangana': ['Adilabad', 'Bhadradri Kothagudem', 'Hyderabad', 'Jagtial', 'Jangaon', 'Jayashankar Bhoopalpally', 'Jogulamba Gadwal', 'Kamareddy', 'Karimnagar', 'Khammam', 'Kumuram Bheem Asifabad', 'Mahabubabad', 'Mahabubnagar', 'Mancherial', 'Medak', 'Medchal', 'Nagarkurnool', 'Nalgonda', 'Nirmal', 'Nizamabad', 'Peddapalli', 'Rajanna Sircilla', 'Ranga Reddy', 'Sangareddy', 'Siddipet', 'Suryapet', 'Vikarabad', 'Wanaparthy', 'Warangal (Rural)', 'Warangal (Urban)', 'Yadadri Bhuvanagiri'],
    'Tripura': ['Dhalai', 'Gomati', 'Khowai', 'North Tripura', 'Sepahijala', 'South Tripura', 'Unakoti', 'West Tripura'],
    'Uttar Pradesh': ['Agra', 'Aligarh', 'Ambedkar Nagar', 'Amethi (Chatrapati Sahuji Mahraj Nagar)', 'Amroha (J.P. Nagar)', 'Auraiya', 'Ayodhya (Faizabad)', 'Azamgarh', 'Badaun', 'Baghpat', 'Bahraich', 'Ballia', 'Balrampur', 'Banda', 'Barabanki', 'Bareilly', 'Basti', 'Bhadohi', 'Bijnor', 'Budaun', 'Bulandshahr', 'Chandauli', 'Chitrakoot', 'Deoria', 'Etah', 'Etawah', 'Farrukhabad', 'Fatehpur', 'Firozabad', 'Gautam Buddha Nagar', 'Ghaziabad', 'Ghazipur', 'Gonda', 'Gorakhpur', 'Hamirpur', 'Hapur (Panchsheel Nagar)', 'Hardoi', 'Hathras', 'Jalaun', 'Jaunpur', 'Jhansi', 'Kannauj', 'Kanpur Dehat', 'Kanpur Nagar', 'Kasganj (Kanshiram Nagar)', 'Kaushambi', 'Kheri', 'Kushinagar (Padrauna)', 'Lalitpur', 'Lucknow', 'Maharajganj', 'Mahoba', 'Mainpuri', 'Mathura', 'Mau', 'Meerut', 'Mirzapur', 'Moradabad', 'Muzaffarnagar', 'Pilibhit', 'Pratapgarh', 'Prayagraj', 'Raebareli', 'Rampur', 'Saharanpur', 'Sambhal (Bhim Nagar)', 'Sant Kabir Nagar', 'Shahjahanpur', 'Shamli', 'Shrawasti', 'Siddharthnagar', 'Sitapur', 'Sonbhadra', 'Sultanpur', 'Unnao', 'Varanasi'],
    'Uttarakhand': ['Almora', 'Bageshwar', 'Chamoli', 'Champawat', 'Dehradun', 'Haridwar', 'Nainital', 'Pauri Garhwal', 'Pithoragarh', 'Rudraprayag', 'Tehri Garhwal', 'Udham Singh Nagar', 'Uttarkashi'],
    'West Bengal': ['Alipurduar', 'Bankura', 'Birbhum', 'Cooch Behar', 'Dakshin Dinajpur (South Dinajpur)', 'Darjeeling', 'Hooghly', 'Howrah', 'Jalpaiguri', 'Jhargram', 'Kalimpong', 'Kolkata', 'Malda', 'Murshidabad', 'Nadia', 'North 24 Parganas', 'Paschim Bardhaman (West Bardhaman)', 'Paschim Medinipur (West Medinipur)', 'Purba Bardhaman (East Bardhaman)', 'Purba Medinipur (East Medinipur)', 'Purulia', 'South 24 Parganas', 'Uttar Dinajpur (North Dinajpur)'],
  };


  final Map<String, List<String>> posstateDistricts = {
    'Andhra Pradesh': ['Anantapur', 'Chittoor', 'East Godavari', 'Guntur', 'Krishna', 'Kurnool', 'Prakasam', 'Srikakulam', 'Sri Potti Sriramulu Nellore', 'Visakhapatnam', 'Vizianagaram', 'West Godavari', 'YSR Kadapa'],
    'Arunachal Pradesh': ['Tawang', 'West Kameng', 'East Kameng', 'Papum Pare', 'Kurung Kumey', 'Kra Daadi', 'Lower Subansiri', 'Upper Subansiri', 'West Siang', 'East Siang', 'Siang', 'Upper Siang', 'Lower Siang', 'Lower Dibang Valley', 'Dibang Valley', 'Anjaw', 'Lohit', 'Namsai', 'Changlang', 'Tirap', 'Longding'],
    'Assam': ['Baksa', 'Barpeta', 'Biswanath', 'Bongaigaon', 'Cachar', 'Charaideo', 'Chirang', 'Darrang', 'Dhemaji', 'Dhubri', 'Dibrugarh', 'Goalpara', 'Golaghat', 'Hailakandi', 'Hojai', 'Jorhat', 'Kamrup Metropolitan', 'Kamrup', 'Karbi Anglong', 'Karimganj', 'Kokrajhar', 'Lakhimpur', 'Majuli', 'Morigaon', 'Nagaon', 'Nalbari', 'Dima Hasao', 'Sivasagar', 'Sonitpur', 'South Salmara-Mankachar', 'Tinsukia', 'Udalguri', 'West Karbi Anglong'],
    'Bihar': ['Araria', 'Arwal', 'Aurangabad', 'Banka', 'Begusarai', 'Bhagalpur', 'Bhojpur', 'Buxar', 'Darbhanga', 'East Champaran (Motihari)', 'Gaya', 'Gopalganj', 'Jamui', 'Jehanabad', 'Kaimur (Bhabua)', 'Katihar', 'Khagaria', 'Kishanganj', 'Lakhisarai', 'Madhepura', 'Madhubani', 'Munger (Monghyr)', 'Muzaffarpur', 'Nalanda', 'Nawada', 'Patna', 'Purnia (Purnea)', 'Rohtas', 'Saharsa', 'Samastipur', 'Saran', 'Sheikhpura', 'Sheohar', 'Sitamarhi', 'Siwan', 'Supaul', 'Vaishali', 'West Champaran'],
    'Chhattisgarh': ['Balod', 'Baloda Bazar', 'Balrampur', 'Bastar', 'Bemetara', 'Bijapur', 'Bilaspur', 'Dantewada (South Bastar)', 'Dhamtari', 'Durg', 'Gariyaband', 'Janjgir-Champa', 'Jashpur', 'Kabirdham (Kawardha)', 'Kanker (North Bastar)', 'Kondagaon', 'Korba', 'Koriya', 'Mahasamund', 'Mungeli', 'Narayanpur', 'Raigarh', 'Raipur', 'Rajnandgaon', 'Sukma', 'Surajpur', 'Surguja'],
    'Goa': ['North Goa', 'South Goa'],
    'Gujarat': ['Ahmedabad', 'Amreli', 'Anand', 'Aravalli', 'Banaskantha (Palanpur)', 'Bharuch', 'Bhavnagar', 'Botad', 'Chhota Udepur', 'Dahod', 'Dangs (Ahwa)', 'Devbhoomi Dwarka', 'Gandhinagar', 'Gir Somnath', 'Jamnagar', 'Junagadh', 'Kheda (Nadiad)', 'Kutch', 'Mahisagar', 'Mehsana', 'Morbi', 'Narmada (Rajpipla)', 'Navsari', 'Panchmahal (Godhra)', 'Patan', 'Porbandar', 'Rajkot', 'Sabarkantha (Himmatnagar)', 'Surat', 'Surendranagar', 'Tapi (Vyara)', 'Vadodara', 'Valsad'],
    'Haryana': ['Ambala', 'Bhiwani', 'Charkhi Dadri', 'Faridabad', 'Fatehabad', 'Gurgaon', 'Hisar', 'Jhajjar', 'Jind', 'Kaithal', 'Karnal', 'Kurukshetra', 'Mahendragarh', 'Mewat', 'Palwal', 'Panchkula', 'Panipat', 'Rewari', 'Rohtak', 'Sirsa', 'Sonipat', 'Yamunanagar'],
    'Himachal Pradesh': ['Bilaspur', 'Chamba', 'Hamirpur', 'Kangra', 'Kinnaur', 'Kullu', 'Lahaul & Spiti', 'Mandi', 'Shimla', 'Sirmaur (Sirmour)', 'Solan', 'Una'],
    'Jharkhand': ['Bokaro', 'Chatra', 'Deoghar', 'Dhanbad', 'Dumka', 'East Singhbhum', 'Garhwa', 'Giridih', 'Godda', 'Gumla', 'Hazaribag', 'Jamtara', 'Khunti', 'Koderma', 'Latehar', 'Lohardaga', 'Pakur', 'Palamu', 'Ramgarh', 'Ranchi', 'Sahebganj', 'Seraikela-Kharsawan', 'Simdega', 'West Singhbhum'],
    'Karnataka': ['Bagalkot', 'Bangalore Rural', 'Bangalore Urban', 'Belgaum', 'Bellary', 'Bidar', 'Chamarajanagar', 'Chikkaballapur', 'Chikkamagaluru', 'Chitradurga', 'Dakshina Kannada', 'Davanagere', 'Dharwad', 'Gadag', 'Gulbarga', 'Hassan', 'Haveri', 'Kodagu', 'Kolar', 'Koppal', 'Mandya', 'Mysore', 'Raichur', 'Ramanagara', 'Shimoga', 'Tumkur', 'Udupi', 'Uttara Kannada', 'Vijayapura', 'Yadgir'],
    'Kerala': ['Alappuzha', 'Ernakulam', 'Idukki', 'Kannur', 'Kasaragod', 'Kollam', 'Kottayam', 'Kozhikode', 'Malappuram', 'Palakkad', 'Pathanamthitta', 'Thiruvananthapuram', 'Thrissur', 'Wayanad'],
    'Madhya Pradesh': ['Agar Malwa', 'Alirajpur', 'Anuppur', 'Ashoknagar', 'Balaghat', 'Barwani', 'Betul', 'Bhind', 'Bhopal', 'Burhanpur', 'Chhatarpur', 'Chhindwara', 'Damoh', 'Datia', 'Dewas', 'Dhar', 'Dindori', 'Guna', 'Gwalior', 'Harda', 'Hoshangabad', 'Indore', 'Jabalpur', 'Jhabua', 'Katni', 'Khandwa', 'Khargone', 'Mandla', 'Mandsaur', 'Morena', 'Narsinghpur', 'Neemuch', 'Panna', 'Raisen', 'Rajgarh', 'Ratlam', 'Rewa', 'Sagar', 'Satna', 'Sehore', 'Seoni', 'Shahdol', 'Shajapur', 'Sheopur', 'Shivpuri', 'Sidhi', 'Singrauli', 'Tikamgarh', 'Ujjain', 'Umaria', 'Vidisha'],
    'Maharashtra': ['Ahmednagar', 'Akola', 'Amravati', 'Aurangabad', 'Beed', 'Bhandara', 'Buldhana', 'Chandrapur', 'Dhule', 'Gadchiroli', 'Gondia', 'Hingoli', 'Jalgaon', 'Jalna', 'Kolhapur', 'Latur', 'Mumbai City', 'Mumbai Suburban', 'Nagpur', 'Nanded', 'Nandurbar', 'Nashik', 'Osmanabad', 'Palghar', 'Parbhani', 'Pune', 'Raigad', 'Ratnagiri', 'Sangli', 'Satara', 'Sindhudurg', 'Solapur', 'Thane', 'Wardha', 'Washim', 'Yavatmal'],
    'Manipur': ['Bishnupur', 'Chandel', 'Churachandpur', 'Imphal East', 'Imphal West', 'Jiribam', 'Kakching', 'Kamjong', 'Kangpokpi', 'Noney', 'Pherzawl', 'Senapati', 'Tamenglong', 'Tengnoupal', 'Thoubal', 'Ukhrul'],
    'Meghalaya': ['East Garo Hills', 'East Jaintia Hills', 'East Khasi Hills', 'North Garo Hills', 'Ri Bhoi', 'South Garo Hills', 'South West Garo Hills', 'South West Khasi Hills', 'West Garo Hills', 'West Jaintia Hills', 'West Khasi Hills'],
    'Mizoram': ['Aizawl', 'Champhai', 'Kolasib', 'Lawngtlai', 'Lunglei', 'Mamit', 'Saiha', 'Serchhip'],
    'Nagaland': ['Dimapur', 'Kiphire', 'Kohima', 'Longleng', 'Mokokchung', 'Mon', 'Peren', 'Phek', 'Tuensang', 'Wokha', 'Zunheboto'],
    'New Delhi': ['Central Delhi', 'East Delhi', 'New Delhi', 'North Delhi', 'North East Delhi', 'North West Delhi', 'Shahdara', 'South Delhi', 'South East Delhi', 'South West Delhi', 'West Delhi'],
    'Odisha': ['Angul', 'Balangir', 'Balasore', 'Bargarh', 'Bhadrak', 'Boudh', 'Cuttack', 'Deogarh', 'Dhenkanal', 'Gajapati', 'Ganjam', 'Jagatsinghpur', 'Jajpur', 'Jharsuguda', 'Kalahandi', 'Kandhamal', 'Kendrapara', 'Kendujhar (Keonjhar)', 'Khordha', 'Koraput', 'Malkangiri', 'Mayurbhanj', 'Nabarangpur', 'Nayagarh', 'Nuapada', 'Puri', 'Rayagada', 'Sambalpur', 'Sonepur', 'Sundargarh'],
    'Punjab': ['Amritsar', 'Barnala', 'Bathinda', 'Faridkot', 'Fatehgarh Sahib', 'Fazilka', 'Ferozepur', 'Gurdaspur', 'Hoshiarpur', 'Jalandhar', 'Kapurthala', 'Ludhiana', 'Mansa', 'Moga', 'Muktsar', 'Nawanshahr (Shahid Bhagat Singh Nagar)', 'Pathankot', 'Patiala', 'Rupnagar', 'Sahibzada Ajit Singh Nagar (Mohali)', 'Sangrur', 'Tarn Taran'],
    'Rajasthan': ['Ajmer', 'Alwar', 'Banswara', 'Baran', 'Barmer', 'Bharatpur', 'Bhilwara', 'Bikaner', 'Bundi', 'Chittorgarh', 'Churu', 'Dausa', 'Dholpur', 'Dungarpur', 'Hanumangarh', 'Jaipur', 'Jaisalmer', 'Jalore', 'Jhalawar', 'Jhunjhunu', 'Jodhpur', 'Karauli', 'Kota', 'Nagaur', 'Pali', 'Pratapgarh', 'Rajsamand', 'Sawai Madhopur', 'Sikar', 'Sirohi', 'Sri Ganganagar', 'Tonk', 'Udaipur'],
    'Sikkim': ['East Sikkim', 'North Sikkim', 'South Sikkim', 'West Sikkim'],
    'Tamil Nadu': ['Ariyalur', 'Chengalpattu', 'Chennai', 'Coimbatore', 'Cuddalore', 'Dharmapuri', 'Dindigul', 'Erode', 'Kallakurichi', 'Kanchipuram', 'Kanyakumari', 'Karur', 'Krishnagiri', 'Madurai', 'Nagapattinam', 'Namakkal', 'Nilgiris', 'Perambalur', 'Pudukkottai', 'Ramanathapuram', 'Ranipet', 'Salem', 'Sivaganga', 'Tenkasi', 'Thanjavur', 'Theni', 'Thoothukudi (Tuticorin)', 'Tiruchirappalli', 'Tirunelveli', 'Tirupathur', 'Tiruppur', 'Tiruvallur', 'Tiruvannamalai', 'Tiruvarur', 'Vellore', 'Viluppuram', 'Virudhunagar'],
    'Telangana': ['Adilabad', 'Bhadradri Kothagudem', 'Hyderabad', 'Jagtial', 'Jangaon', 'Jayashankar Bhoopalpally', 'Jogulamba Gadwal', 'Kamareddy', 'Karimnagar', 'Khammam', 'Kumuram Bheem Asifabad', 'Mahabubabad', 'Mahabubnagar', 'Mancherial', 'Medak', 'Medchal', 'Nagarkurnool', 'Nalgonda', 'Nirmal', 'Nizamabad', 'Peddapalli', 'Rajanna Sircilla', 'Ranga Reddy', 'Sangareddy', 'Siddipet', 'Suryapet', 'Vikarabad', 'Wanaparthy', 'Warangal (Rural)', 'Warangal (Urban)', 'Yadadri Bhuvanagiri'],
    'Tripura': ['Dhalai', 'Gomati', 'Khowai', 'North Tripura', 'Sepahijala', 'South Tripura', 'Unakoti', 'West Tripura'],
    'Uttar Pradesh': ['Agra', 'Aligarh', 'Ambedkar Nagar', 'Amethi (Chatrapati Sahuji Mahraj Nagar)', 'Amroha (J.P. Nagar)', 'Auraiya', 'Ayodhya (Faizabad)', 'Azamgarh', 'Badaun', 'Baghpat', 'Bahraich', 'Ballia', 'Balrampur', 'Banda', 'Barabanki', 'Bareilly', 'Basti', 'Bhadohi', 'Bijnor', 'Budaun', 'Bulandshahr', 'Chandauli', 'Chitrakoot', 'Deoria', 'Etah', 'Etawah', 'Farrukhabad', 'Fatehpur', 'Firozabad', 'Gautam Buddha Nagar', 'Ghaziabad', 'Ghazipur', 'Gonda', 'Gorakhpur', 'Hamirpur', 'Hapur (Panchsheel Nagar)', 'Hardoi', 'Hathras', 'Jalaun', 'Jaunpur', 'Jhansi', 'Kannauj', 'Kanpur Dehat', 'Kanpur Nagar', 'Kasganj (Kanshiram Nagar)', 'Kaushambi', 'Kheri', 'Kushinagar (Padrauna)', 'Lalitpur', 'Lucknow', 'Maharajganj', 'Mahoba', 'Mainpuri', 'Mathura', 'Mau', 'Meerut', 'Mirzapur', 'Moradabad', 'Muzaffarnagar', 'Pilibhit', 'Pratapgarh', 'Prayagraj', 'Raebareli', 'Rampur', 'Saharanpur', 'Sambhal (Bhim Nagar)', 'Sant Kabir Nagar', 'Shahjahanpur', 'Shamli', 'Shrawasti', 'Siddharthnagar', 'Sitapur', 'Sonbhadra', 'Sultanpur', 'Unnao', 'Varanasi'],
    'Uttarakhand': ['Almora', 'Bageshwar', 'Chamoli', 'Champawat', 'Dehradun', 'Haridwar', 'Nainital', 'Pauri Garhwal', 'Pithoragarh', 'Rudraprayag', 'Tehri Garhwal', 'Udham Singh Nagar', 'Uttarkashi'],
    'West Bengal': ['Alipurduar', 'Bankura', 'Birbhum', 'Cooch Behar', 'Dakshin Dinajpur (South Dinajpur)', 'Darjeeling', 'Hooghly', 'Howrah', 'Jalpaiguri', 'Jhargram', 'Kalimpong', 'Kolkata', 'Malda', 'Murshidabad', 'Nadia', 'North 24 Parganas', 'Paschim Bardhaman (West Bardhaman)', 'Paschim Medinipur (West Medinipur)', 'Purba Bardhaman (East Bardhaman)', 'Purba Medinipur (East Medinipur)', 'Purulia', 'South 24 Parganas', 'Uttar Dinajpur (North Dinajpur)'],
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

  String? _posselectedState;

  String? get posselectedState => _posselectedState;

  String? _posselectedDistrict;

  String? get posselectedDistrict => _posselectedDistrict;

  List<String> get posstates => posstateDistricts.keys.toList();

  List<String> get posdistricts =>
      _posselectedState == null || _posselectedState!.isEmpty
          ? []
          : posstateDistricts[_posselectedState!] ?? [];

  void possetState(String state) {
    _posselectedState = state;
    _posselectedDistrict = null;
    update();
  }
  void possetDistrict(String district) {
    _posselectedDistrict = district;
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

  // void setPosDistrict(String district) {
  //   _selectedPosDistrict = district;
  //   update();
  // }

  List<ReligionModel>? _religionList;

  List<ReligionModel>? get religionList => _religionList;

  List<ReligionModel>? _partReligionList;

  List<ReligionModel>? get partReligionList => _partReligionList;

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
        // _religionList =
        //     responseData.map((json) => ReligionModel.fromJson(json)).toList();
        _religionList = responseData
            .map((json) => ReligionModel.fromJson(json))
            .where((religion) => religion.id != 10)
            .toList();
        _partReligionList = responseData
            .map((json) => ReligionModel.fromJson(json))
            .where((religion) => religion.id != 11)
            .toList();
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

  List<CommunityModel>? _partCommunityList;

  List<CommunityModel>? get partCommunityList => _partCommunityList;

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
        // _communityList =
        //     responseData.map((json) => CommunityModel.fromJson(json)).toList();
        _communityList = responseData
            .map((json) => CommunityModel.fromJson(json))
            .where((religion) => religion.id != 10)
            .toList();
        _partCommunityList = responseData
            .map((json) => CommunityModel.fromJson(json))
            .where((religion) => religion.id != 11)
            .toList();
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

  List<MotherTongueModel>? _partMotherTongueList;

  List<MotherTongueModel>? get partMotherTongueList => _partMotherTongueList;

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
        // _motherTongueList = responseData
        //     .map((json) => MotherTongueModel.fromJson(json))
        //     .toList();
        _motherTongueList = responseData
            .map((json) => MotherTongueModel.fromJson(json))
            .where((religion) => religion.id != 9)
            .toList();
        _partMotherTongueList = responseData
            .map((json) => MotherTongueModel.fromJson(json))
            .where((religion) => religion.id != 10)
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

  List<ProfessionModel>? _partProfessionList;

  List<ProfessionModel>? get partProfessionList => _partProfessionList;

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
        // _professionList =
        //     responseData.map((json) => ProfessionModel.fromJson(json)).toList();
        _professionList = responseData
            .map((json) => ProfessionModel.fromJson(json))
            .where((religion) => religion.id != 9)
            .toList();
        _partProfessionList = responseData
            .map((json) => ProfessionModel.fromJson(json))
            .where((religion) => religion.id != 10)
            .toList();

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




  List<PositionHeldModel>? _partPositionHeldList;

  List<PositionHeldModel>? get partPositionHeldList => _partPositionHeldList;

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
        // _positionHeldList = responseData
        //     .map((json) => PositionHeldModel.fromJson(json))
        //     .toList();
        _positionHeldList = responseData
            .map((json) => PositionHeldModel.fromJson(json))
            .where((religion) => religion.id != 13)
            .toList();
        _partPositionHeldList = responseData
            .map((json) => PositionHeldModel.fromJson(json))
            .where((religion) => religion.id != 14)
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

  String? _day;

  String? get day => _day;

  void setDay(String lastName) {
    _day = lastName;
    update();
  }

  String? _batchDay;

  String? get batchDay => _batchDay;

  void setBatchDay(String lastName) {
    _batchDay = lastName;
    update();
  }

  String? _postingDay;

  String? get postingDay => _postingDay;

  void setPostingDay(String lastName) {
    _postingDay = lastName;
    update();
  }

  String? _month;

  String? get month => _month;

  void setMonth(String lastName) {
    _month = lastName;
    update();
  }

  String? _batchMonth;

  String? get batchMonth => _batchMonth;

  void setBatchMonth(String lastName) {
    _batchMonth = lastName;
    update();
  }

  String? _postingMonth;

  String? get postingMonth => _postingMonth;

  void setPostingMonth(String lastName) {
    _postingMonth = lastName;
    update();
  }

  String? _year;

  String? get year => _year;

  void setYear(String lastName) {
    _year = lastName;
    update();
  }

  String? _batchYear;

  String? get batchYear => _batchYear;

  void setBatchYear(String lastName) {
    _batchYear = lastName;
    update();
  }

  String? _postingYear;

  String? get postingYear => _postingYear;

  void setPostingYear(String lastName) {
    _postingYear = lastName;
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


  final List<String> genderList = ['Male','Female','Others'];

  String? _gender = "Male";
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


  // var values = SfRangeValues(20.0, 80.0);
  //
  // void setValues(SfRangeValues newValues) {
  //   values = newValues;
  // }



  // var startValue = 20.0;
  // var endValue = 80.0;
  //
  // void setAgeValue(RangeValues newValues) {
  //   startValue = newValues;
  //   endValue = newValues.end;
  //   update(); // Notify listeners to update the UI
  // }

  var startValue = 20.0.obs; // Use observable to update UI
  var endValue = 50.0.obs;

  void setAgeValue(RangeValues newValues) {
    startValue.value = newValues.start; // Update the observable values
    endValue.value = newValues.end;
    _partnerMinAge = startValue.value.toStringAsFixed(0);
    _partnerMaxAge = endValue.value.toStringAsFixed(0);
    print(partnerMinAge);
    print(partnerMaxAge);
    update(); // Notify listeners to update the UI
  }

  // Use RxDouble to handle decimal values
  var startHeightValue = 5.0.obs;
  var endHeightValue = 7.0.obs;

  // Function to set new height values
  void setHeightValue(RangeValues newValues) {
    // Update RxDouble values directly with new decimal values
    startHeightValue.value = newValues.start;
    endHeightValue.value = newValues.end;

    // Convert to string with one decimal place
    String partnerMinHeight = startHeightValue.value.toStringAsFixed(1);
    String partnerMaxHeight = endHeightValue.value.toStringAsFixed(1);

    // Print the updated heights
    print('Check partner height: $partnerMinHeight');
    print('Check partner max height: $partnerMaxHeight');

    update(); // Notify listeners to update the UI
  }
  // var startHeightValue = 5.0.obs;  // Use RxInt for integer values
  // var endHeightValue = 7.0.obs;
  //
  // void setHeightValue(RangeValues newValues) {
  //   startHeightValue.value = newValues.start.toInt(); // Convert to integer
  //   endHeightValue.value = newValues.end.toInt();
  //
  //   // Convert to string without decimal places
  //   _partnerMinHeight = startHeightValue.value.toString();
  //   _partnerMaxHeight = endHeightValue.value.toString();
  //
  //   // Print the updated heights
  //   print('check partner height $partnerMinHeight');
  //   print('check partner max height $partnerMaxHeight');
  //
  //   update(); // Notify listeners to update the UI
  // }

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

  String? _caste  = 'Yes';
  String? get caste => _caste;

  void setCasteStatus(String val) {
    _caste = val;
    update();
  }

  String? _partnerDrinkingStatus = 'Yes';
  String? get partnerDrinkingStatus => _partnerDrinkingStatus;

  void setPartnerDrinkingStatus(String val) {
    _partnerDrinkingStatus = val;
    update();
  }

  int? _smokingIndex = 0;

  int? get smokingIndex => _smokingIndex;
  List<int?> _smokingIds = [];

  List<int?> get smokingIds => _smokingIds;
  List<ProfessionModel>? _smokingList;

  List<ProfessionModel>? get smokingList => _smokingList;


  void setSmokingIndex(int? index, bool notify) {
    _smokingIndex = index;
    if (notify) {
      update();
    }
  }

  Future<void> getSmokingList() async {
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getAttributesUrl();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['smoking'];
        _smokingList =
            responseData.map((json) => ProfessionModel.fromJson(json)).toList();
        _smokingIds = [0, ..._smokingList!.map((e) => e.id)];
        if (_smokingList!.isNotEmpty) {
          _smokingIndex = _smokingList![0].id;
          // _partnerProfession = _smokingList![0].id;
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


  int? _drikingIndex = 0;

  int? get drikingIndex => _drikingIndex;
  List<int?> _drikingIds = [];

  List<int?> get drikingIds => _drikingIds;
  List<ProfessionModel>? _drikingList;

  List<ProfessionModel>? get drikingList => _drikingList;


  void setDrikingIndex(int? index, bool notify) {
    _drikingIndex = index;
    if (notify) {
      update();
    }
  }

  Future<void> getDrinkingList() async {
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getAttributesUrl();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['drinking'];
        _drikingList =
            responseData.map((json) => ProfessionModel.fromJson(json)).toList();
        _drikingIds = [0, ..._drikingList!.map((e) => e.id)];
        if (_drikingList!.isNotEmpty) {
          _drikingIndex = _drikingList![0].id;
          // _partnerProfession = _smokingList![0].id;
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





  final List<String> indianStatesAndUTs = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
    'Andaman and Nicobar Islands', 'Chandigarh', 'Dadra and Nagar Haveli and Daman and Diu', 'Lakshadweep', 'Delhi', 'Puducherry', 'Ladakh', 'Jammu and Kashmir'
  ];

  String? _indianStates;

  String? get indianStates => _indianStates;

  List<String> get indianstates => indianStatesAndUTs;

  void setIndianStates(String state) {
    _indianStates = state;
    update();
  }

  final List<String> highestDegreeList = [
    'AA',
    'AAS',
    'ABA',
    'ADBus',
    'ADIT',
    'ADN',
    'AE',
    'AET',
    'AS',
    'AFA',
    'B.Arch',
    'B.Arch (Hons)',
    'B.Com',
    'B.Com (Hons)',
    'B.Des',
    'B.Ed',
    'BFA',
    'BHM',
    'B.IT',
    'BA (Hons)',
    'BA Computer Science',
    'B.A',
    'B.Arch',
    'B.Sc',
    'B.Sc (Hons)',
    'BCA',
    'BDS',
    'BEng (Hons)',
    'BMM',
    'BMS',
    'B.Pharma',
    'BPT',
    'BVSc',
    'CA / CPA',
    'CFA',
    'CS',
    'D.Arch',
    'D.Ed',
    'DFA',
    'Diploma',
    'Doctorate',
    'Engineering Diploma',
    'High School',
    'Honours',
    'IT Diploma',
    'LLB (Hons)',
    'ML / LLM',
    'M.Arch',
    'M.Com',
    'M.Des',
    'M.Ed',
    'MFA',
    'M.Med',
    'M.Pharma',
    'M.S Engineering',
    'M.Sc',
    'M.Sc / MFin / MS',
    'M.A',
    'M.Arch',
    'M.Com',
    'MDS',
    'M.D',
    'M.Med',
    'M.Phil',
    'MPT',
    'M.Sc',
    'M.S Medicine',
    'MBA',
    'MBBS',
    'MDS',
    'MFin',
    'MSc / MFin / MS',
    'MMed',
    'MVSc',
    'PGDM',
    'PGD Finance',
    'PGDCA',
    'Ph.D',
    'Less Than High School',
    'Bachelor',
    'Master',
    'MSW',
    'MJMC',
    'M.Arch',
    'M.Des',
    'MFA',
    'M.Ed',
    'M.A',
    'MSW',
    'MPT',
    'Ph.D',
    'Doctorate',
    'Associate'
  ];


  String? _highestDegree;

  String? get highestDegree => _highestDegree;

  List<String> get highesdegree => highestDegreeList;

  void setHighestDegree(String state) {
    _highestDegree = state;
    update();
  }

  final List<String> annualIncomeList = [
    'INR Below 3 Lakh',
    'INR 3 Lakh to 6 Lakh',
    'INR 6 Lakh to 10 Lakh',
    'INR 10 Lakh to 14 Lakh',
    'INR 14 Lakh to 18 Lakh',
    'INR 18 Lakh to 21 Lakh',
    'INR 21 Lakh to 24 Lakh',
    'INR 24 Lakh to 28 Lakh',
    'INR 28 Lakh to 32 Lakh',
    'INR 33 Lakh to 35 Lakh', // Remove duplicates
    'INR 40 Lakh to 50 Lakh',
    'INR 50 Lakh to 60 Lakh',
    'INR 60 Lakh to 70 Lakh',
    'INR 70 Lakh to 80 Lakh',
    'INR 80 Lakh to 90 Lakh',
    'INR 90 Lakh to 1 Crore',
    'Above 1 Crore',
  ].toSet().toList(); // Remove duplicates using Set


  String? _annualIncome;

  String? get annualIncome => _annualIncome;

  List<String> get annualincome => annualIncomeList;

  void setAnnualIncome(String state) {
    _annualIncome = state;
    update();
  }

  final List<String> batchYearList = [
    '2023', '2022', '2021', '2020', '2019', '2018', '2017', '2016', '2015', '2014', '2013', '2012', '2011', '2010',
    '2009', '2008', '2007', '2006', '2005', '2004', '2003', '2002', '2001', '2000', '1999', '1998', '1997', '1996',
    '1995', '1994', '1993', '1992', '1991', '1990', '1989', '1988', '1987', '1986', '1985', '1984', '1983', '1982',
    '1981', '1980', '1979', '1978', '1977', '1976', '1975', '1974', '1973', '1972', '1971', '1970'
  ];


  // String? _batchYear;
  //
  // String? get batchYear => _batchYear;
  //
  // List<String> get batchyear => batchYearList;
  //
  // void setBatchYear(String state) {
  //   _batchYear = state;
  //   update();
  // }
  // String? _postingYear;
  //
  // String? get postingYear => _postingYear;
  // void setPostingYear(String state) {
  //   _postingYear = state;
  //   update();
  // }


  final List<String> cadarList = ['Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Andaman and Nicobar Islands', 'Chandigarh', 'Dadra and Nagar Haveli and Daman and Diu', 'Lakshadweep', 'Delhi', 'Puducherry', 'Ladakh', 'Jammu and Kashmir'
  ];

  String? _cadar;

  String? get cadar => _cadar;
  List<String> get cadars => cadarList;

  void setCadar(String cadar) {
    _cadar = cadar;
    update();
  }


  final List<String> documentList = [
   'Aadhar Card', 'Driving License', 'Passport','Govt Authorized Card'
  ];

  String? _document;

  String? get document => _document;
  List<String> get setdocument => documentList;

  void setDocument(String value) {
    _document = value;
    update();
  }

  // final List<String> indianStatesAndUTs = [
  //   'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
  //   'Andaman and Nicobar Islands', 'Chandigarh', 'Dadra and Nagar Haveli and Daman and Diu', 'Lakshadweep', 'Delhi', 'Puducherry', 'Ladakh', 'Jammu and Kashmir'
  // ];
  //
  // String? _indianStates;
  //
  // String? get indianStates => _indianStates;
  //
  // List<String> get indianstates => indianStatesAndUTs;
  //
  // void setIndianStates(String state) {
  //   _indianStates = state;
  //   update();
  // }

  /// /////////////////////////////////////////////////////////////////////////////////////////



  final List<String> lookingForList = ["MySelf", "My Son", "My Daughter", 'My Brother', 'Sister','My Friend'];

  String? _lookingFor = "MySelf";
  String? get lookingFor => _lookingFor;

  void setLookingFor(String? gender) {
    _lookingFor = gender;
    update();
  }






  int? _marriedStatusIndex = 0;

  int? get marriedStatusIndex => _marriedStatusIndex;
  List<int?> _marriedStatusIds = [];

  List<int?> get marriedStatusIds => _marriedStatusIds;
  List<MarriedStatusModel>? _marriedStatusList;

  List<MarriedStatusModel>? get marriedStatusList => _marriedStatusList;

  List<MarriedStatusModel>? _partmarriedStatusList;

  List<MarriedStatusModel>? get partmarriedStatusList => _partmarriedStatusList;

  // int? _partnermarriedStatus;
  // int? get partnermarriedStatus => _partnermarriedStatus;
  //
  // void setmarriedStatus(int val) {
  //   _partnermarriedStatus = val;
  //   update();
  // }

  void setmarriedStatusIndex(int? index, bool notify) {
    _marriedStatusIndex = index;
    if (notify) {
      update();
    }
  }

  Future<void> getmarriedStatusList() async {
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getAttributesUrl();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['maritalStatuses'];
        // _positionHeldList = responseData
        //     .map((json) => PositionHeldModel.fromJson(json))
        //     .toList();
        _marriedStatusList = responseData
            .map((json) => MarriedStatusModel.fromJson(json))
            .where((religion) => religion.id != 13)
            .toList();
        _partmarriedStatusList = responseData
            .map((json) => MarriedStatusModel.fromJson(json))
            .where((religion) => religion.id != 14)
            .toList();
        _marriedStatusIds = [0, ..._marriedStatusList!.map((e) => e.id)];

        // Select the first item by default
        if (_marriedStatusList!.isNotEmpty) {
          _marriedStatusIndex = _marriedStatusList![0].id;
          // _partnerPosition = _positionHeldList![0].id;
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

  final List<String> creativeList = [
    'Writing', 'Cooking', 'Singing', 'Photography', 'Playing Instruments', 'Painting',
    'Drawing', 'Dancing', 'Acting', 'Crafting', 'Sculpting'
  ];
  final List<String> _selectedCreatives = [];
  List<String> get selectedCreatives => _selectedCreatives;

  void selectCreative(String gender) {
    if (_selectedCreatives.isEmpty) {
      _selectedCreatives.add(creativeList.first);
    }else if (_selectedCreatives.contains(gender)) {
      _selectedCreatives.remove(gender);
    } else {
      _selectedCreatives.add(gender);
    }
    update();
  }

  void initList() {
    // Add the first item of the creativeList to _selectedCreatives by default
    if (creativeList.isNotEmpty) {
      _selectedCreatives.add(creativeList.first);
      update(); // Notify listeners
    }
    if (funList.isNotEmpty) {
      _fun.add(funList.first);
      update(); // Notify listeners
    }
    if (fitnessList.isNotEmpty) {
      _fitness.add(fitnessList.first);
      update(); // Notify listeners
    }
    if (otherInterestList.isNotEmpty) {
      _otherInterests.add(otherInterestList.first);
      update(); // Notify listeners
    }
    if (hobbiesList.isNotEmpty) {
      _hobbies.add(hobbiesList.first);
      update(); // Notify listeners
    }
  }

  bool isExpanded = false;
  void toggleExpanded() {
    isExpanded = !isExpanded;
    update();
  }


  final List<String> funList = [
    'Movies', 'Music', 'Travelling', 'Reading', 'Sports', 'Social Media',
    'Gaming', 'Cooking', 'Hiking', 'Yoga', 'Photography', 'Fishing',
    'Cycling', 'Gardening', 'Swimming', 'Bird Watching', 'Collecting',
    'Knitting', 'Board Games', 'Volunteering', 'Blogging', 'Podcasting',
    'Martial Arts', 'Puzzles', 'Rock Climbing', 'Running', 'Skiing',
    'Snowboarding', 'Surfing', 'Tennis', 'Woodworking', 'Writing',
    'Drawing', 'Dancing', 'Acting', 'Crafting', 'Sculpting'
  ];

  final List<String> _fun = [];
  List<String> get fun => _fun;

  void selectFun(String gender) {
    if (_fun.contains(gender)) {
      _fun.remove(gender);
    } else {
      _fun.add(gender);
    }
    update();
  }
  bool isFunExpanded = false;
  void toggleFunExpanded() {
    isFunExpanded = !isFunExpanded;
    update();
  }

  final List<String> fitnessList = [
    'Running', 'Swimming', 'Cycling', 'Yoga', 'Pilates', 'Weightlifting',
    'Cardio', 'HIIT', 'CrossFit', 'Zumba', 'Dance Fitness', 'Boxing',
    'Kickboxing', 'Martial Arts', 'Hiking', 'Rock Climbing', 'Rowing',
    'Gymnastics', 'Aerobics', 'Stretching', 'Meditation', 'Tai Chi',
    'Walking', 'Jogging', 'Jump Rope', 'Squash', 'Tennis', 'Badminton'
  ];

  final List<String> _fitness = [];
  List<String> get fitness => _fitness;

  void selectFitness(String activity) {
    if (_fitness.contains(activity)) {
      _fitness.remove(activity);
    } else {
      _fitness.add(activity);
    }
    update();
  }

  bool isFitnessExpanded = false;
  void toggleFitnessExpanded() {
    isFitnessExpanded = !isFitnessExpanded;
    update();
  }

  final List<String> otherInterestList = [
    'Pets', 'Farming', 'Veganism', 'Cooking', 'Gardening', 'Reading', 'Writing',
    'Blogging', 'Podcasting', 'Traveling', 'Crafting', 'Painting', 'Sculpting',
    'Photography', 'Videography', 'Drawing', 'Collecting', 'Bird Watching',
    'Fishing', 'Woodworking', 'Knitting', 'Volunteering'
  ];

  final List<String> _otherInterests = [];
  List<String> get otherInterests => _otherInterests;

  void selectOtherInterest(String interest) {
    if (_otherInterests.contains(interest)) {
      _otherInterests.remove(interest);
    } else {
      _otherInterests.add(interest);
    }
    update();
  }

  bool isOtherInterestExpanded = false;
  void toggleOtherInterestExpanded() {
    isOtherInterestExpanded = !isOtherInterestExpanded;
    update();
  }

  final List<String> hobbiesList = [
    'Photography', 'Gardening', 'Cooking', 'Knitting', 'Painting',
    'Drawing', 'Writing', 'Reading', 'Crafting', 'Sculpting',
    'Collecting', 'Bird Watching', 'Fishing', 'Hiking', 'Camping',
    'Traveling', 'Music', 'Dancing', 'Playing Instruments', 'DIY Projects',
    'Model Building', 'Puzzle Solving', 'Cooking Classes', 'Yoga', 'Meditation'
  ];

  final List<String> _hobbies = [];
  List<String> get hobbies => _hobbies;

  void selectHobby(String hobby) {
    if (_hobbies.contains(hobby)) {
      _hobbies.remove(hobby);
    } else {
      _hobbies.add(hobby);
    }
    update();
  }

  bool isHobbiesExpanded = false;
  void toggleHobbiesExpanded() {
    isHobbiesExpanded = !isHobbiesExpanded;
    update();
  }







  List<CommunityListModel>? _casteList;

  List<CommunityListModel>? get casteList => _casteList;

  List<CommunityListModel>? _partCasteList;

  List<CommunityListModel>? get partCasteList => _partCasteList;

  int? _casteIndex = 0;

  int? get casteIndex => _casteIndex;

  List<int?> _casteIds = [];

  List<int?> get casteIds => _casteIds;

  int? _casteMainIndex = 0;
  int? get casteMainIndex => _casteMainIndex;
  void setCasteMainIndex(int? index, bool notify) {
    _casteMainIndex = index;
    if (notify) {
      update();
    }
  }

  int? _casteFilterIndex = 0;
  int? get casteFilterIndex => _casteFilterIndex;
  void setCasteFilterIndex(int? index, bool notify) {
    _casteFilterIndex = index;
    if (notify) {
      update();
    }
  }


  int? _partnerCaste;
  int? get partnerCaste => _partnerCaste;

  void setPartnerCaste(int val) {
    _partnerCaste = val;
    update();
  }

  Future<void> getCasteList(id) async {
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getCommunityUrl(id);
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['community'];
        // _religionList =
        //     responseData.map((json) => ReligionModel.fromJson(json)).toList();
        _casteList = responseData
            .map((json) => CommunityListModel.fromJson(json))
            .where((religion) => religion.id != 10)
            .toList();
        _partCasteList = responseData
            .map((json) => CommunityListModel.fromJson(json))
            .where((religion) => religion.id != 11)
            .toList();
        _casteIds = [0, ..._casteList!.map((e) => e.id)];

        if (_casteList!.isNotEmpty) {
          _casteMainIndex = _casteList![0].id;
          _partnerCaste = _casteList![0].id;
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



  bool _registerByPhone= false;
  bool get registerByPhone => _registerByPhone;








  onBackPressed(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.exit_to_app_sharp, color: primaryColor),
              SizedBox(width: 10),
              Text('Close Application?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
            content: const Text('Are you sure you want to exit the Application?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No', style: TextStyle(fontSize: 15, color: primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop(false); //Will not exit the App
                },
              ),
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 15, color: primaryColor),
                ),
                onPressed: () {
                  exit(0);
                },
              )
            ],
          );
        });
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
      title: const Text("Select Year"),
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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle confirmation if needed
            Get.back();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }






}
