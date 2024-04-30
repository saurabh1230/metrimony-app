
import 'package:bureau_couple/src/views/signIn/signin_option_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../apis/login/login_api.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/shared_prefs.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/textfield.dart';
import '../../models/LoginResponse.dart';
import '../../utils/widgets/buttons.dart';
import '../../utils/widgets/common_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home/home_dashboard.dart';
import '../signup/forgot_password.dart';
import '../signup/forgot_password_Screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _loadSavedLoginDetails();
  }

  bool loading = false;
  bool saveLoginDetails = false;


  _loadSavedLoginDetails() async {
    final loginDetails = await SharedPreferencesHelper.getLoginDetails();
    emailController.text = loginDetails['username'] ?? '';
    passwordController.text = loginDetails['password'] ?? '';
  }

  _onLoginButtonPressed() async {
    // Perform login logic

    // Save login details if checkbox is selected
    if (saveLoginDetails) {
      SharedPreferencesHelper.saveLoginDetails(
        emailController.text,
        passwordController.text,
      );
    }
  }


  LoginResponse? response;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(icSignInBG),
                  Container(
                    child: Stack(
                      children: [
                        Image.asset(icSignInLinearBG),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0,
                              left: 20,
                              right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              backButton(context: context, image: icArrowLeft, onTap: () {
                                Navigator.pop(context);
                              }),
                              SizedBox(height:80 ,),
                              Image.asset(icLogo,
                                width: 72,
                                height: 59,),
                              sizedBox10(),
                              Text(
                                "Sign In",
                                style: kManrope34BoldBlack,
                                textAlign: TextAlign.center,),
                              Text(
                                "Log in to continue your journey of\nyour love and connetion",
                                style: kManrope16MediumBlack,
                                textAlign: TextAlign.center,),
                              sizedBox20(),
                              AutofillGroup(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Email / Username",
                                      style: kManrope14Medium626262,),
                                    sizedBox6(),
                                    textBox(
                                        string:  [AutofillHints.username],
                                        context: context,
                                        label: '',
                                        controller: emailController,
                                        hint: '',
                                        length: null,
                                        validator: (value) {
                                          return null;
                                        }, onChanged: (value) {

                                    }
                                      //   validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return 'Please enter your email address.';
                                      //   }
                                      //   if (!isValidEmail(value)) {
                                      //     return 'Please enter a valid email address.';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                    sizedBox20(),
                                    Text("Password",
                                      style: kManrope14Medium626262,),
                                    sizedBox6(),
                                    textBoxSuffixIcon(
                                        suffixOnTap: () {
                                          setState(() {
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                        string:  [AutofillHints.password],
                                        context: context,
                                        label: '',
                                        controller: passwordController,
                                        hint: '',
                                        length: null,
                                        suffixIcon: _passwordVisible
                                            ?Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                        validator: (value) {
                                          return ;
                                        }, bool: _passwordVisible, onChanged: (String ) {  }),
                                    SizedBox(height: 21,),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return ForgotPassEmailSheet();
                                            },
                                          );
                                          // Navigator.push(context, MaterialPageRoute(builder: (builder) => ForgotPasswordScreen()));
                                        },
                                        child: Text("Forgot Password",
                                          textAlign: TextAlign.right,
                                          style: kManrope16Regular4271ec,),
                                      ),
                                    ),

                                    sizedBoxHeight32(),
                                    loading ?
                                    loadingButton(context: context) :
                                    button(
                                        onTap: () {
                                          if(emailController.text.isNotEmpty ||
                                              passwordController.text.isNotEmpty) {
                                            TextInput.finishAutofillContext();
                                            if(_formKey.currentState!.validate()) {
                                              setState(() {
                                                loading = true;
                                              });
                                              loginApi(
                                                password: passwordController.text,
                                                userName: emailController.text,
                                              ).then((value) {
                                                response = value;

                                                if (
                                                    response?.status == 'success' /*value['status'] == 'success'*/) {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  print("cehc");
                                                  print(response);
                                                  SharedPrefs().setLoginToken(response!.data!.accessToken.toString());
                                                  SharedPrefs().setUserName(response!.data!.user!.username.toString());
                                                  SharedPrefs().setName(response!.data!.user!.firstname.toString());
                                                  SharedPrefs().setEmail((response!.data!.user!.email.toString()));
                                                  SharedPrefs().setPhone(response!.data!.user!.mobile.toString());
                                                  SharedPrefs().setProfileId(response!.data!.user!.profileId as int);
                                                  SharedPrefs().setLoginTrue();
                                                  SharedPrefs().setProfilePhoto(response!.data!.user!.image.toString());
                                                  SharedPrefs().setLoginGender(response!.data!.user!.gender.toString());
                                                  // SharedPrefs().setLoginGender(value['data']['user']['gender']);
                                                  // SharedPrefs().setLoginToken(value['data']['access_token']);
                                                  // SharedPrefs().setUserName(value['data']['user']['username']);
                                                  // SharedPrefs().setEmail(value['data']['user']['email']);
                                                  // SharedPrefs().setPhone(value['data']['user']['mobile']);
                                                  // SharedPrefs().setProfileId(value['data']['user']['profile_id'] as int);
                                                  // SharedPrefs().setLoginTrue();
                                                  // SharedPrefs().setProfilePhoto(value['data']['user']['image']);
                                                  // SharedPrefs().setLoginGender(value['data']['user']['gender']);
                                                  SharedPrefs().setLoginEmail(emailController.text);
                                                  SharedPrefs().setLoginPassword(passwordController.text);
                                                  Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                                                   HomeDashboardScreen(response: response!,)));
                                                  ToastUtil.showToast("Login Successful");

                                                } else {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  print("fkfm");
                                                  Fluttertoast.showToast(msg: "please check your account");

                                                  // List<dynamic> errors = value['message']['error'];
                                                  // String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                                                  // Fluttertoast.showToast(msg: errorMessage);
                                                }
                                              });
                                              /*setState(() {
                                                loading = true;
                                              });
                                              loginApi(
                                                password: passwordController.text,
                                                userName: emailController.text,
                                              ).then((value) {
                                                response = value;
                                                if (response?.status != null &&
                                                    response!.status == 'success') {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  SharedPrefs().setLoginToken(response!.data!.accessToken.toString());
                                                  SharedPrefs().setUserName(response!.data!.user!.username.toString());
                                                  SharedPrefs().setEmail(response!.data!.user!.email.toString());
                                                  SharedPrefs().setPhone(response!.data!.user!.mobile.toString());
                                                  // SharedPrefs().setProfileId(value['data']['user']['profile_id']);
                                                  SharedPrefs().setLoginTrue();
                                                  SharedPrefs().setLoginEmail(emailController.text);
                                                  SharedPrefs().setLoginPassword(passwordController.text);
                                                  Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                                                      HomeDashboardScreen(response: response!,)));
                                                  ToastUtil.showToast("Login Successful");

                                                }
                                                else if(value['status'] == 'error'){
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  List<dynamic> errors = value['message']['error'];
                                                  String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                                                  Fluttertoast.showToast(msg: errorMessage);
                                                }
                                              });*/
                                            }
                                          } else {
                                            setState(() {
                                              loading = false;
                                            });
                                            ToastUtil.showToast("Please Enter Username and password");

                                          }
                                        },
                                        context: context, title: 'Sign In'),

                                    sizedBoxHeight32(),
                                    Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (builder) =>
                                              const SignInOptionScreen()));
                                        },
                                        child: Text("Sign Up Now",
                                          textAlign: TextAlign.center,
                                          style:kManrope18Bold101010 ,),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }
}
