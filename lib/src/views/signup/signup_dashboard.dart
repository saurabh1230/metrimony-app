import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/screens/auth/register/register_1.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/views/signIn/sign_in_screen.dart';
import 'package:bureau_couple/src/views/signup/sign_up_screen_before_three.dart';
import 'package:bureau_couple/src/views/signup/sign_up_screen_partner_expectation.dart';
import 'package:bureau_couple/src/views/signup/signup_screen_one.dart';
import 'package:bureau_couple/src/views/signup/signup_screen_two.dart';
import 'package:bureau_couple/src/views/signup/signup_sreen_three.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../apis/signup_api/signup_api.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../utils/widgets/buttons.dart';
import 'add_kyc_details.dart';
import 'package:get/get.dart';
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
      child: GetBuilder<AuthController>(builder: (authControl) {
        return  Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
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
                        // RegisterOne(),
                        const SignUpScreenOne(),
                        const SignUpScreenTwo(),
                        const SignUpScreenProfessional(),
                        const SignUpScreenPartnerExp(),
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
                    print(authControl.gender);
                    if (_currentPage == 0) {
                      if (const SignUpScreenOne().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                    else if (_currentPage == 1) {
                      if (const SignUpScreenTwo().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else if (_currentPage == 2 ) {
                      if (const SignUpScreenProfessional().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else if (_currentPage == 3 ) {
                      if (const SignUpScreenPartnerExp().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                    else if (_currentPage == 4) {
                      if(pickedImagePath.isEmpty )  {
                        Fluttertoast.showToast(msg: "Please add Image and birth date");
                      } else {
                        setState(() {
                          loading = true;
                        });
                        signUpApi(
                          userName: authControl.userName!,
                          email: authControl.email!,
                          password:authControl.password!,
                          mobileNo: authControl.phone!,
                          passwordConfirmation: authControl.password!,
                          firstName: authControl.firstName!,
                          lastName: authControl.lastName!,
                          lookingFor: 'My Self',
                          gender:authControl.gender!,
                          motherTongue: authControl.motherTongueIndex.toString(),
                          birthDate: authControl.dob!,
                          country:  'India',
                          countryCode:  'IN',
                          maritalStatus: "unmarried",
                          photo: pickedImagePath,
                          religion: authControl.religionMainIndex.toString(),
                          profession: authControl.professionIndex.toString(),
                          userType: 'Normal',
                          community:  authControl.communityMainIndex.toString(),
                          positionHeld: authControl.positionHeldIndex.toString(),
                          state: authControl.state!,
                          cadar: "Nil",
                          statePosting:  authControl.state!,
                          districtPosting: authControl.district.toString(),
                          postingStartDate: authControl.from.toString(),
                          postingEndDate: '2024-07-09',
                          degree: authControl.highestDegree!,
                          fieldofStudy: authControl.fieldOfStudy!,
                          institute:authControl.institute!,
                          batchStart: authControl.batchFromString,
                          batchEnd: '2024',
                          district: authControl.district.toString(),
                          middleName: authControl.middleName.toString(),
                          maritalStatusP: 'unmarried',
                          religionP: authControl.partnerReligion.toString(),
                          communityP: authControl.partnerCommunity.toString(),
                          motherTongueP:authControl.partnerMotherTongue.toString(),
                          professionP: authControl.partnerProfession.toString(),
                          positionP: authControl.partnerPosition.toString(),
                          countryP: 'India',
                          minAgeP: authControl.partnerMinAge.toString(),
                          maxAgeP: authControl.partnerMaxAge.toString(),
                          minHeightP: authControl.partnerMinHeight.toString(),
                          maxHeightP: authControl.partnerMaxHeight.toString(),
                          smokingP: authControl.smokingIndex.toString(),
                          drinkingP: authControl.drikingIndex.toString(),
                          // phone: '',
                        ).then((value) async {
                          setState(() {
                            loading = false;
                          });
                          if (value['status'] == 'success') {
                            setState(() {
                              loading = false;
                            });
                            setState(() {
                              SharedPrefs().clearGender();
                              SharedPrefs().clearMaritalStatus();
                              SharedPrefs().clearReligion();
                            });

                            SharedPrefs().setLoginToken(value['data']['access_token']);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (builder) => const SignInScreen()),
                            );

                            ToastUtil.showToast("Registered Successfully");

                          } else {
                            setState(() {
                              loading = false;
                            });
                            List<dynamic> errors = value['message']['error'];
                            String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                            Fluttertoast.showToast(msg: errorMessage);
                          }
                        });
                      }
                    }
                  },
                  title:_currentPage == 4 ? 'Submit' :'Next'),
            ),
          ),

        );
      }),

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
        const SizedBox(width: 3,),
        Container(
          height: 7,
          width: _currentPage == 3? 17 :7,
          decoration: BoxDecoration(
              color: _currentPage == 3 ?  primaryColor :
              colorD9D9D9,
              borderRadius: BorderRadius.circular(22)
          ),
        ),
        const SizedBox(width: 3,),
        Container(
          height: 7,
          width: _currentPage == 4? 17 :7,
          decoration: BoxDecoration(
              color: _currentPage == 4 ?  primaryColor :
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


// I/flutter (17714): {remark: registration_success,
// status: success,
// message: {success: [Registration successful]},
// data: {access_token: 1475|dQWxwjJLhSmohKT3swsaXVQs0by1Zk8jJq6qoKd1,
// user: {profile_id: 32329162,
// looking_for: My Self,
// email: hdndndndj@gmail.com,
// username: hdjfjfjdj,
// firstname: Dbndjfbf,
// lastname: Ndndndn,
// religion: 2, marital_status: unmarried,
// mother_tongue: 1,
// community: 1,
// profession: 2,
// middle_name: ,
// gender: M,
// image: 6687f2ae8fdd71720185518.jpg,
// country_code: IN, mobile: 9165656556,
// address: {address: null, state: Andhra Pradesh,
// zip: null, country: India, district: null},
// kv: 1, ev: 1, sv: 1,
// updated_at: 2024-07-05T13:18:38.000000Z,
// created_at: 2024-07-05T13:18:38.000000Z, id: 55},
// token_type: Bearer}}
