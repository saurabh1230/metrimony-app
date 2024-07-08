import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  String login = 'login';
  String firstRun = 'firstRun';
  String token = 'token';
  String firstname = 'firstname';
  String loginEmail = 'loginEmail';
  String loginPassword = 'loginPassword';
  String lastname = 'lastname';
  String email = 'email';
  String phone = 'phone';
  String password = 'password';
  String profileFor = 'profile_for';
  String gender = 'gender';
  String loginGender = 'login_gender';
  String userName = 'username';
  String country = 'county';
  String countryCode = 'countryCode';
  String motherTongue = 'motherTongue';
  String profession = 'profession';
  String userType = 'userType';
  String dateOfBirth = 'dateOfBirth';
  String profileId = 'profileId';
  String maritalStatus = 'marital_status';
  String religion = 'religion';
  String profilePhoto = 'profile_photo';
  String state = 'state';
  String age = 'age';
  String community = 'community';

  static SharedPreferences? _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future clearPrefs() async {
    await _prefs?.clear();
  }

  Future setProfilePhoto(String sProfilePhoto) async {
    await init(); // Make sure to initialize SharedPreferences before using it
    return await _prefs?.setString(profilePhoto, sProfilePhoto);
  }

  String? getProfilePhoto() {
    return _prefs?.getString(profilePhoto);
  }

  Future setProfileId(int profileId) async {
    await init();
    return await _prefs?.setInt('profileId', profileId); // Use setInt instead of setString
  }

  int? getProfileId() {
    return _prefs?.getInt('profileId'); // Use getInt instead of getString
  }
  Future setLoginEmail(String sLoginEmail) async {
    await init(); // Make sure to initialize SharedPreferences before using it
    return await _prefs?.setString(loginEmail, sLoginEmail);
  }

  String? getLoginEmail() {
    return _prefs?.getString(loginEmail);
  }

  Future setLoginPassword(String sLoginPassword) async {
    await init(); // Make sure to initialize SharedPreferences before using it
    return await _prefs?.setString(loginPassword, sLoginPassword);
  }

  String? getLoginPassword() {
    return _prefs?.getString(loginPassword);
  }

  Future setLoginTrue() async {
    await init();
    return await _prefs?.setBool(login, true);
  }

  bool? getLogin() {
    return _prefs?.getBool(login);
  }
  Future setLoginFalse() async {
    return await _prefs?.setBool(login, false);
  }

  bool? getFirstRun() {
    return _prefs?.getBool(firstRun);
  }

   Future setFirstRunDone() async {
    await init();
    return await _prefs?.setBool(firstRun, true);
  }


  Future setDob(String sDob) async {
    await init();
    return await _prefs?.setString(dateOfBirth, sDob);
  }

  String? getDob() {
    return _prefs?.getString(dateOfBirth);
  }

  Future setLoginGender(String sGender) async {
    await init();
    return await _prefs?.setString(loginGender, sGender);
  }

  String? getLoginGender() {
    return _prefs?.getString(loginGender);
  }

  Future clearDob() async {
    await init();
    return await _prefs?.remove(dateOfBirth);
  }

  Future setReligion(String sReligion) async {
    await init();
    return await _prefs?.setString(religion, sReligion);
  }

  String? getReligion() {
    return _prefs?.getString(religion);
  }

  Future clearReligion() async {
    await init();
    return await _prefs?.remove(religion);
  }

  
  Future setState(String sState) async {
    await init();
    return await _prefs?.setString(state, sState);
  }

  String? getState() {
    return _prefs?.getString(state);
  }

  Future clearState() async {
    await init();
    return await _prefs?.remove(state);
  }

  Future setAge(String sState) async {
    await init();
    return await _prefs?.setString(age, sState);
  }

  String? getAge() {
    return _prefs?.getString(age);
  }

  Future clearAge() async {
    await init();
    return await _prefs?.remove(age);
  }


  Future setProfession(String sProfession) async {
    await init();
    return await _prefs?.setString(profession, sProfession);
  }

  Future setUserType(String sUserType) async {
    await init();
    return await _prefs?.setString(userType, sUserType);
  }

  String? getUserType() {
    return _prefs?.getString(userType);
  }
  Future clearUserType() async {
    await init();
    return await _prefs?.remove(userType);
  }

  String? getProfession() {
    return _prefs?.getString(profession);
  }

  Future clearProfession() async {
    await init();
    return await _prefs?.remove(profession);
  }

  Future setCountryCode(String sCountry) async {
    await init();
    return await _prefs?.setString(countryCode, sCountry);
  }

  String? getCountryCode() {
    return _prefs?.getString(countryCode);
  }
  Future clearCountryCode() async {
    await init();
    return await _prefs?.remove(countryCode);
  }
  Future setMotherTongue(String sMotherTongue) async {
    await init();
    return await _prefs?.setString(motherTongue, sMotherTongue);
  }

  String? getMotherTongue() {
    return _prefs?.getString(motherTongue);
  }
  Future clearMotherTongue() async {
    await init();
    return await _prefs?.remove(motherTongue);
  }

  Future setCommunity(String sCommunity) async {
    await init();
    return await _prefs?.setString(community, sCommunity);
  }

  String? getCommunity() {
    return _prefs?.getString(community);
  }
  Future clearCommunity() async {
    await init();
    return await _prefs?.remove(community);
  }

  Future setCountry(String sCountry) async {
    await init();
    return await _prefs?.setString(country, sCountry);
  }

  String? getCountry() {
    return _prefs?.getString(country);
  }

  Future clearCountry() async {
    await init();
    return await _prefs?.remove(country);
  }


  Future setUserName(String sUserName) async {
    await init();
    return await _prefs?.setString(userName, sUserName);
  }

  String? getUserName() {
    return _prefs?.getString(userName);
  }

  Future clearUserName() async {
    await init();
    return await _prefs?.remove(userName);
  }


  Future setProfileFor(String sProfileFor) async {
    await init();
    return await _prefs?.setString(profileFor, sProfileFor);
  }

  String? getProfileFor() {
    return _prefs?.getString(profileFor);
  }
  Future clearProfileFor() async {
    await init();
    return await _prefs?.remove(profileFor);
  }

  Future setGender(String sGender) async {
    await init();
    return await _prefs?.setString(gender, sGender);
  }

  String? getGender() {
    return _prefs?.getString(gender);
  }
  Future clearGender() async {
    await init();
    return await _prefs?.remove(gender);
  }

  Future setMaritalStatus(String sMStatus) async {
    await init();
    return await _prefs?.setString(maritalStatus, sMStatus);
  }

  String? getMaritalStatus() {
    return _prefs?.getString(maritalStatus);
  }

  Future clearMaritalStatus() async {
    await init();
    return await _prefs?.remove(maritalStatus);
  }


  Future setName(String fName) async {
    await init();
    return await _prefs?.setString(firstname, fName);
  }
  Future setLastName(String LName) async {
    await init();
    return await _prefs?.setString(lastname, LName);
  }
  Future clearLastName() async {
    await init();
    return await _prefs?.remove(lastname);
  }
  Future setEmail(String sEmail) async {
    await init();
    return await _prefs?.setString(email, sEmail);
  }

  String? getEmail() {
    return _prefs?.getString(email);
  }
  Future setPhone(String sPhone) async {
    await init();
    return await _prefs?.setString(phone, sPhone);
  }

  String? getPhone() {
    return _prefs?.getString(phone);
  }

  Future setPassword(String sPassword) async {
    await init();
    return await _prefs?.setString(password, sPassword);
  }

  String? getPassword() {
    return _prefs?.getString(password);
  }

  String? getLastName() {
    return _prefs?.getString(lastname);
  }


  String? getName() {
    return _prefs?.getString(firstname);
  }

  String? getLoginToken() {
    return _prefs?.getString(token);
  }

  Future setLoginToken(String loginToken) async {
    // await init();
    return await _prefs?.setString(token, loginToken);
  }
}



class SharedPreferencesHelper {
  static const String _kUsernameKey = 'username';
  static const String _kPasswordKey = 'password';

  static Future<void> saveLoginDetails(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_kUsernameKey, username);
    prefs.setString(_kPasswordKey, password);
  }

  static Future<Map<String, String>> getLoginDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString(_kUsernameKey) ?? '';
    final String password = prefs.getString(_kPasswordKey) ?? '';
    return {'username': username, 'password': password};
  }
}
