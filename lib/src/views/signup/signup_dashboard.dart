import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../apis/signup_api/signup_api.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../utils/widgets/buttons.dart';
import 'add_kyc_details.dart';
import 'signup_screen_one.dart';
import 'signup_screen_two.dart';
import 'signup_sreen_three.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SignUpOnboardScreen extends StatefulWidget {
  static final GlobalKey<_SignUpOnboardScreenState> pageViewKey =
  GlobalKey<_SignUpOnboardScreenState>();
  @override
  _SignUpOnboardScreenState createState() => _SignUpOnboardScreenState();
}

class _SignUpOnboardScreenState extends State<SignUpOnboardScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  bool loading = false;

  void navigateToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  File pickedImage = File("");
  String pickedImagePath = "";




  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(
                left: 5.0,right: 20,),
            child: Row(
              children: [
                backButton(
                  context: context,
                  image: icArrowLeft,
                  onTap: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // If on the first page, you can handle going back to the previous screen
                      Navigator.pop(context);
                    }
                  },
                ),

              ],
            ),
          ),
        ),


        body: Padding(
          padding: const EdgeInsets.only(top: 0.0,
          left: 20,
          right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // backButton(context: context),
                  // Spacer(),
                  builddots(),
                ],
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: PageView(
                    key: SignUpOnboardScreen.pageViewKey,
                  physics:  const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children:   [
                    const SignUpScreenOne(),
                    // SignUpScreenOne(),
                    const SignUpScreenTwo(),
                    SingUpScreenThree(onImagePicked: (imagePath ) {
                      setState(() {
                        pickedImagePath = imagePath;
                      });
                      // pickedImage = imagePath;
                     
                    },),
                  ]
                ),
              ),
            ],
          ),
        ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,
            vertical: 10),
            child: SingleChildScrollView(
              child:
              loading ?
              loadingButton(context: context) :
              button(
                  context: context,
                  onTap: (){
                    if (_currentPage == 0) {
                      if (SignUpScreenOne().validate()) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                    else if (_currentPage == 1) {
                      if (SignUpScreenTwo().validate()) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                    else if (_currentPage == 2) {
                     if(pickedImagePath.isEmpty )  {
                       Fluttertoast.showToast(msg: "Please add Image and birth date");
                     } else {
                       setState(() {
                         loading = true;
                       });
                       signUpApi(
                           userName: '${SharedPrefs().getUserName()}',
                           email: '${SharedPrefs().getEmail()}',
                           password:'${SharedPrefs().getPassword()}',
                           mobileNo: '${SharedPrefs().getPhone()}',
                           passwordConfirmation: '${SharedPrefs().getPassword()}',
                           firstName: '${SharedPrefs().getName()}',
                           lastName: '${SharedPrefs().getLastName()}',
                           lookingFor: 'My Self',
                           gender: '${SharedPrefs().getGender() == null ? "M" : SharedPrefs().getGender().toString()}',
                           // gender: '${SharedPrefs().getGender()}',
                           motherTongue: '${SharedPrefs().getMotherTongue()}',
                           birthDate: '${SharedPrefs().getDob()}',
                           country: '${SharedPrefs().getCountry()}',
                           countryCode:  '${SharedPrefs().getCountryCode()}',
                           maritalStatus: '${SharedPrefs().getMaritalStatus() == null ? "Unmarried" : SharedPrefs().getMaritalStatus().toString()}',
                           // maritalStatus: 'Unmarried',
                           photo: '$pickedImagePath',
                           religion: '${SharedPrefs().getReligion() == null ? "Hindu" : SharedPrefs().getReligion().toString()}',
                           profession: '${SharedPrefs().getProfession()}').then((value) async {
                         if (value['status'] == 'success') {
                           setState(() {
                             loading = false;
                           });
                           setState(() {
                             SharedPrefs().clearGender();
                             SharedPrefs().clearMaritalStatus();
                             SharedPrefs().clearReligion();
                           });
                           /*  var prefs = await SharedPreferences
                              .getInstance();
                          prefs.setString(
                              'accessToken', value['data']['access_token']);*/

                           SharedPrefs().setLoginToken(value['data']['access_token']);
                           // print(value['data']['access_token']);
                           Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(builder: (builder) => const AddKycDetailsScreen()),
                           );

                           ToastUtil.showToast("Registered Successfully");
                           print('done');
                         } else {
                           setState(() {
                             loading = false;
                           });
                           // Display error message in Flutter toast
                           List<dynamic> errors = value['message']['error'];
                           String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                           Fluttertoast.showToast(msg: errorMessage);
                         }


                         /* if ( value['status'] == 'success') {
                          SharedPrefs().setLoginToken(value['data']['access_token']);
                          print(value['data']['access_token']);

                          Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                          AddKycDetailsScreen()));
                          // ToastUtil.showToast("Login Successful");


                          ToastUtil.showToast("Registered Successfully");
                          print('done');
                        } else {
                          Fluttertoast.showToast(msg: value['message']['error']);

                        // ToastUtil.showToast("Please Check Register details");
                        }*/
                       });
                       // Navigator.push(context, MaterialPageRoute(builder: (builder) => SignInScreen()));
                       // _pageController.nextPage(
                       //   duration: Duration(milliseconds: 200),
                       //   curve: Curves.easeInOut,
                       // );
                     };

                     }




                 /*   // _handleNext();
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Handle any additional logic when reaching the last page
                    }*/

                  },
                  title:_currentPage == 2 ? 'Submit' :'Next'),
            ),
          ),

      ),
    );
  }

  Row builddots() {
    return Row(
                    children: [
                      Container(
                        height: 7,
                        width: _currentPage == 0? 17 :7,
                        decoration: BoxDecoration(
                            color:_currentPage == 0 ?  primaryColor :
                            colorD9D9D9,
                            borderRadius: BorderRadius.circular(22)
                            // shape: BoxShape.circle
                        ),
                      ),
                      const SizedBox(width: 3,),
                      Container(
                        height: 7,
                        width: _currentPage == 1? 17 :7,
                        decoration: BoxDecoration(
                            color: _currentPage == 1 ?  primaryColor :
                            colorD9D9D9,
                            borderRadius: BorderRadius.circular(22)
                        ),
                      ),
                      const SizedBox(width: 3,),
                      Container(
                        height: 7,
                        width: _currentPage == 2? 17 :7,
                        decoration: BoxDecoration(
                          color: _currentPage == 2 ?  primaryColor :
                          colorD9D9D9,
                            borderRadius: BorderRadius.circular(22)
                        ),
                      ),
                    ],
                  );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}


Future<void> saveAccessToken(String accessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('access_token', accessToken);
}

Future<String?> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}