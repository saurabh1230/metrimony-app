import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/helper/helper_widgets.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/views/signup/sign_up_expectation_screen.dart';
import 'package:bureau_couple/src/views/signup/sign_up_physical_apperance.dart';
import 'package:bureau_couple/src/views/signup/sign_up_profession_location.dart';
import 'package:bureau_couple/src/views/signup/sign_up_profession_screen.dart';
import 'package:bureau_couple/src/views/signup/sign_up_screen_before_three.dart';
import 'package:bureau_couple/src/views/signup/sign_up_screen_interest_screen.dart';
import 'package:bureau_couple/src/views/signup/sign_up_screen_location.dart';
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
import 'sign_up_education_screen.dart';

class SignUpOnboardScreen extends StatefulWidget {
  static final GlobalKey<_SignUpOnboardScreenState> pageViewKey = GlobalKey<_SignUpOnboardScreenState>();
  const SignUpOnboardScreen({super.key});
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
                        // const SignUpScreenPartnerExp(),
                        // const SignUpScreenLocation(),
                        const SignUpScreenPhysicalAppearanceScreen(),
                        const SignUpScreenEducation(),
                        const SignUpScreenProfessionScreen(),
                        const SignUpScreenProfessionLocationScreen(),
                        const SignUpScreenInterest(),
                        const SignUpScreenExpectationScreen(),
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
                    }
                   /* else if (_currentPage == 3 ) {
                      if (const SignUpScreenPartnerExp().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }*/
                    // else if (_currentPage == 3 ) {
                    //   if (const SignUpScreenLocation().validate()) {
                    //     _pageController.nextPage(
                    //       duration: const Duration(milliseconds: 200),
                    //       curve: Curves.easeInOut,
                    //     );
                    //   }
                    // }
                    else if (_currentPage == 3 ) {
                      if (const SignUpScreenPhysicalAppearanceScreen().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                    else if (_currentPage == 4 ) {
                      if (const SignUpScreenEducation().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }  else if (_currentPage == 5 ) {
                      if (const SignUpScreenProfessionScreen().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else if (_currentPage == 6 ) {
                      if (const SignUpScreenProfessionLocationScreen().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else if (_currentPage == 7 ) {
                      if (const SignUpScreenInterest().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                    else if (_currentPage == 8 ) {
                      if (const SignUpScreenExpectationScreen().validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }

                    else if (_currentPage == 9 ) {
                      if(pickedImagePath.isEmpty )  {
                        Fluttertoast.showToast(msg: "Please add Profile Image");
                      } else {
                        setState(() {
                          loading = true;
                        });
                        // Print all authControl values separately
                        print('userName: ${authControl.userName}');
                        print('email: ${authControl.email}');
                        print('password: ${authControl.password}');
                        print('mobileNo: ${authControl.phone}');
                        print('passwordConfirmation: ${authControl.password}');
                        print('firstName: ${authControl.firstName}');
                        print('lastName: ${authControl.lastName}');
                        print('lookingFor: ${authControl.lookingFor}');
                        print('gender: ${authControl.gender}');
                        print('motherTongue: ${authControl.motherTongueIndex}');
                        print('birthDate: ${authControl.year}-${authControl.month}-${authControl.day}');
                        print('country: India');
                        print('countryCode: IN');
                        print('maritalStatus: ${authControl.marriedStatusIndex}');
                        print('photo: $pickedImagePath');
                        print('religion: ${authControl.religionMainIndex}');
                        print('profession: ${authControl.professionIndex}');
                        print('userType: Normal');
                        print('community: ${authControl.casteMainIndex}');
                        print('positionHeld: ${authControl.positionHeldIndex}');
                        print('state: ${authControl.selectedState}');
                        print('cadar: ${authControl.cadar}');
                        print('statePosting: ${authControl.posselectedState}');
                        print('districtPosting: ${authControl.posselectedDistrict}');
                        print('postingStartDate: ${authControl.postingYear}');
                        print('postingEndDate: 2024-07-09');
                        print('degree: ${authControl.highestDegree}');
                        print('fieldofStudy: ${authControl.fieldOfStudy}');
                        print('institute: ${authControl.institute}');
                        print('batchStart: ${authControl.batchYear}');
                        print('batchEnd: 2024-07-09');
                        print('district: ${authControl.selectedDistrict}');
                        print('middleName: ${authControl.middleName}');
                        print('maritalStatusP: unmarried');
                        print('religionP: ${authControl.partnerReligion}');
                        print('communityP: ${authControl.partnerCommunity}');
                        print('motherTongueP: ${authControl.partnerMotherTongue}');
                        print('professionP: ${authControl.partnerProfession}');
                        print('positionP: ${authControl.partnerPosition}');
                        print('countryP: India');
                        print('minAgeP: ${authControl.partnerMinAge}');
                        print('maxAgeP: ${authControl.partnerMaxAge}');
                        print('minHeightP: ${authControl.startHeightValue.value}');
                        print('maxHeightP: ${authControl.endHeightValue.value}');
                        print('smokingP: ${authControl.smokingIndex}');
                        print('drinkingP: ${authControl.drikingIndex}');
                        print('funList: ${formatList(authControl.fun)}');
                        print('fitnessList: ${formatList(authControl.fitness)}');
                        print('hobbyList: ${formatList(authControl.hobbies)}');
                        print('creativeList: ${formatList(authControl.selectedCreatives)}');
                        print('otherInterestList: ${formatList(authControl.otherInterests)}');
                        print('financialCondition: ${authControl.annualIncome}');
                        print('height: ${authControl.attributeHeightValue}');
                        print('weight: ${authControl.attributeWeightValue}');
                        print('eyeColor: ${authControl.eyeColor}');
                        print('bloodGroup: ${authControl.bloodGroup}');
                        print('hairColor: ${authControl.hairColor}');



                        signUpApi(
                          userName: authControl.userName.toString(),
                          email: authControl.email.toString(),
                          password:authControl.password.toString(),
                          mobileNo: authControl.phone.toString(),
                          passwordConfirmation: authControl.password.toString(),
                          firstName: authControl.firstName.toString(),
                          lastName: authControl.lastName.toString(),
                          lookingFor: authControl.lookingFor.toString(),
                          gender:authControl.gender!,
                          motherTongue: authControl.motherTongueIndex.toString(),
                          birthDate: '${authControl.year!}-${authControl.month!}-${authControl.day!}',
                          country:  'India',
                          countryCode:  'IN',
                          maritalStatus: authControl.marriedStatusIndex.toString(),
                          photo: pickedImagePath,
                          religion: authControl.religionMainIndex.toString(),
                          profession: authControl.professionIndex.toString(),
                          userType: 'Normal',
                          community: authControl.casteMainIndex.toString(),
                          positionHeld: authControl.positionHeldIndex.toString(),
                          state: authControl.selectedState.toString(),
                          cadar: authControl.cadar.toString(),
                          statePosting:  authControl.posselectedState!,
                          districtPosting: authControl.posselectedDistrict.toString(),
                          postingStartDate:authControl.postingYear!,
                          postingEndDate: '2024-07-09',
                          degree: authControl.highestDegree.toString(),
                          fieldofStudy: authControl.fieldOfStudy.toString(),
                          institute:authControl.institute.toString(),
                          batchStart: authControl.batchYear.toString(),
                          batchEnd: '2024-07-09',
                          district: authControl.selectedDistrict.toString(),
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
                          minHeightP: authControl.startHeightValue.value.toString(),
                          maxHeightP: authControl.endHeightValue.value.toString(),
                          smokingP: authControl.smokingIndex.toString(),
                          drinkingP: authControl.drikingIndex.toString(),
                          funList: formatList(authControl.fun),
                          fitnessList: formatList(authControl.fitness),
                          hobbyList: formatList(authControl.hobbies),
                          creativeList:formatList(authControl.selectedCreatives),
                          otherInterestList: formatList(authControl.otherInterests),
                          financialCondition: authControl.annualIncome.toString(),
                          height: authControl.attributeHeightValue.toString(),
                          weight: authControl.attributeWeightValue.toString(),
                          eyeColor: authControl.eyeColor.toString(),
                          bloodGroup: authControl.bloodGroup.toString(),
                          hairColor: authControl.hairColor.toString(),
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
                              MaterialPageRoute(builder: (builder) => const AddKycDetailsScreen()),
                            );
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(builder: (builder) => const SignInScreen()),
                            // );

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
                  title:_currentPage == 9 ? 'Submit' :'Next'),
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
        const SizedBox(width: 3,),
        Container(
          height: 7,
          width: _currentPage == 5? 17 :7,
          decoration: BoxDecoration(
              color: _currentPage == 5 ?  primaryColor :
              colorD9D9D9,
              borderRadius: BorderRadius.circular(22)
          ),
        ),
        const SizedBox(width: 3,),
        Container(
          height: 7,
          width: _currentPage == 6? 17 :7,
          decoration: BoxDecoration(
              color: _currentPage == 6 ?  primaryColor :
              colorD9D9D9,
              borderRadius: BorderRadius.circular(22)
          ),
        ),
        const SizedBox(width: 3,),
        Container(
          height: 7,
          width: _currentPage == 7? 17 :7,
          decoration: BoxDecoration(
              color: _currentPage == 7 ?  primaryColor :
              colorD9D9D9,
              borderRadius: BorderRadius.circular(22)
          ),
        ),
        const SizedBox(width: 3,),

        Container(
          height: 7,
          width: _currentPage == 8 ? 17 :7,
          decoration: BoxDecoration(
              color: _currentPage == 8 ?  primaryColor :
              colorD9D9D9,
              borderRadius: BorderRadius.circular(22)
          ),
        ),
        const SizedBox(width: 3,),

        Container(
          height: 7,
          width: _currentPage == 9 ? 17 :7,
          decoration: BoxDecoration(
              color: _currentPage == 9 ?  primaryColor :
              colorD9D9D9,
              borderRadius: BorderRadius.circular(22)
          ),
        ),
        // const SizedBox(width: 3,),
        //
        // Container(
        //   height: 7,
        //   width: _currentPage == 10 ? 17 :7,
        //   decoration: BoxDecoration(
        //       color: _currentPage == 10 ?  primaryColor :
        //       colorD9D9D9,
        //       borderRadius: BorderRadius.circular(22)
        //   ),
        // ),
        // const SizedBox(width: 3,),
        //
        // Container(
        //   height: 7,
        //   width: _currentPage == 10 ? 17 :7,
        //   decoration: BoxDecoration(
        //       color: _currentPage == 10 ?  primaryColor :
        //       colorD9D9D9,
        //       borderRadius: BorderRadius.circular(22)
        //   ),
        // ),
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
