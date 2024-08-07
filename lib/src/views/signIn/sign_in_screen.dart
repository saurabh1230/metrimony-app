import 'package:bureau_couple/getx/features/widgets/custom_button%20_widget.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'New To Bureau Couple ?',
                  textAlign: TextAlign.center,
                  style: kManrope16SemiBold828282.copyWith(color: Colors.black),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SignInOptionScreen()));
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Sign Up",
                      style: kManrope16SemiBold828282.copyWith(
                          color: Theme.of(context).cardColor, fontSize: 14),
                    )),
              )
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  authBackground,
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 80, left: 44, right: 44, bottom: 60),
                  child: Image.asset(
                    icLogo,
                  ),
                ),
                AutofillGroup(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      showTitle: true,
                      controller: emailController,
                      hintText: 'Username',
                      fillColor: Colors.transparent,
                      hintColor: Colors.black.withOpacity(0.70),
                    ),
                    sizedBox16(),
                    CustomTextField(
                      showTitle: true,
                      isPassword: true,
                      controller: passwordController,
                      hintText: 'Password',
                      fillColor: Colors.transparent,
                      hintColor: Colors.black.withOpacity(0.70),
                    ),
                    // Text("Username",
                    //   style: kManrope14Medium626262.copyWith(color: Colors.black),),
                    // sizedBox6(),
                    // textBox(
                    //     string:  [AutofillHints.username],
                    //     context: context,
                    //     label: '',
                    //     controller: emailController,
                    //     hint: 'Password',
                    //     length: null,
                    //     validator: (value) {
                    //       return null;
                    //     }, onChanged: (value) {
                    //
                    // }
                    //
                    // ),
                    // sizedBox20(),
                    // Text("Password",
                    //   style: kManrope14Medium626262.copyWith(color: Colors.black),),
                    // sizedBox6(),
                    // textBoxSuffixIcon(
                    //     suffixOnTap: () {
                    //       setState(() {
                    //         _passwordVisible = !_passwordVisible;
                    //       });
                    //     },
                    //     string:  [AutofillHints.password],
                    //     context: context,
                    //     label: '',
                    //     controller: passwordController,
                    //     hint: 'Password',
                    //     length: null,
                    //     suffixIcon: _passwordVisible
                    //         ? const Icon(Icons.visibility)
                    //         : const Icon(Icons.visibility_off),
                    //     validator: (value) {
                    //       return ;
                    //     }, bool: _passwordVisible, onChanged: (String ) {  }),
                    const SizedBox(
                      height: 21,
                    ),
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
                        child: Text(
                          "Forgot Password",
                          textAlign: TextAlign.right,
                          style: kManrope16Medium.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    sizedBox16(),
                    loading ? const Center(child: CircularProgressIndicator()) :
                    CustomButtonWidget(
                      fontColor: Theme.of(context).cardColor,
                      color: Theme.of(context).primaryColor,
                        onPressed: () {
                                    if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty) {
                                      TextInput.finishAutofillContext();
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        loginApi(
                                          password: passwordController.text,
                                          userName: emailController.text,
                                        ).then((value) {
                                          response = value;

                                          if (response?.status ==
                                              'success' /*value['status'] == 'success'*/) {
                                            setState(() {
                                              loading = false;
                                            });
                                            print("cehc");
                                            print(response);
                                            SharedPrefs().setLoginToken(response!
                                                .data!.accessToken
                                                .toString());
                                            SharedPrefs().setUserName(response!
                                                .data!.user!.username
                                                .toString());
                                            SharedPrefs().setName(response!
                                                .data!.user!.firstname
                                                .toString());
                                            SharedPrefs().setEmail((response!
                                                .data!.user!.email
                                                .toString()));
                                            SharedPrefs().setPhone(response!
                                                .data!.user!.mobile
                                                .toString());
                                            SharedPrefs().setProfileId(response!
                                                .data!.user!.profileId as int);
                                            SharedPrefs().setLoginTrue();
                                            SharedPrefs().setProfilePhoto(response!
                                                .data!.user!.image
                                                .toString());
                                            SharedPrefs().setLoginGender(response!
                                                .data!.user!.gender
                                                .toString());
                                            SharedPrefs()
                                                .setLoginEmail(emailController.text);
                                            SharedPrefs().setLoginPassword(
                                                passwordController.text);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        HomeDashboardScreen(
                                                          response: response!,
                                                        )));
                                            ToastUtil.showToast("Login Successful");
                                          } else {
                                            setState(() {
                                              loading = false;
                                            });
                                            ToastUtil.showToast("Not Authorized");
                                            // Fluttertoast.showToast(msg: "Not Authorized");
                                          }
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      ToastUtil.showToast(
                                          "Please Enter Username and password");
                                    }

                        },
                        isBold: false,
                        buttonText: 'Sign In')
                    // loading
                    //     ? loadingButton(context: context)
                    //     : button(
                    //          color: Theme.of(context).cardColor,
                    //         onTap: () {
                    //           if (emailController.text.isNotEmpty ||
                    //               passwordController.text.isNotEmpty) {
                    //             TextInput.finishAutofillContext();
                    //             if (_formKey.currentState!.validate()) {
                    //               setState(() {
                    //                 loading = true;
                    //               });
                    //               loginApi(
                    //                 password: passwordController.text,
                    //                 userName: emailController.text,
                    //               ).then((value) {
                    //                 response = value;
                    //
                    //                 if (response?.status ==
                    //                     'success' /*value['status'] == 'success'*/) {
                    //                   setState(() {
                    //                     loading = false;
                    //                   });
                    //                   print("cehc");
                    //                   print(response);
                    //                   SharedPrefs().setLoginToken(response!
                    //                       .data!.accessToken
                    //                       .toString());
                    //                   SharedPrefs().setUserName(response!
                    //                       .data!.user!.username
                    //                       .toString());
                    //                   SharedPrefs().setName(response!
                    //                       .data!.user!.firstname
                    //                       .toString());
                    //                   SharedPrefs().setEmail((response!
                    //                       .data!.user!.email
                    //                       .toString()));
                    //                   SharedPrefs().setPhone(response!
                    //                       .data!.user!.mobile
                    //                       .toString());
                    //                   SharedPrefs().setProfileId(response!
                    //                       .data!.user!.profileId as int);
                    //                   SharedPrefs().setLoginTrue();
                    //                   SharedPrefs().setProfilePhoto(response!
                    //                       .data!.user!.image
                    //                       .toString());
                    //                   SharedPrefs().setLoginGender(response!
                    //                       .data!.user!.gender
                    //                       .toString());
                    //                   SharedPrefs()
                    //                       .setLoginEmail(emailController.text);
                    //                   SharedPrefs().setLoginPassword(
                    //                       passwordController.text);
                    //                   Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: (builder) =>
                    //                               HomeDashboardScreen(
                    //                                 response: response!,
                    //                               )));
                    //                   ToastUtil.showToast("Login Successful");
                    //                 } else {
                    //                   setState(() {
                    //                     loading = false;
                    //                   });
                    //                   ToastUtil.showToast("Not Authorized");
                    //                   // Fluttertoast.showToast(msg: "Not Authorized");
                    //                 }
                    //               });
                    //             }
                    //           } else {
                    //             setState(() {
                    //               loading = false;
                    //             });
                    //             ToastUtil.showToast(
                    //                 "Please Enter Username and password");
                    //           }
                    //         },
                    //         context: context,
                    //
                    //         title: 'Sign In'),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),

      ///    Old Login /// ######################################################
      // body: SingleChildScrollView(
      //   child: Form(
      //     key: _formKey,
      //     child: Column(
      //       children: [
      //         Stack(
      //           children: [
      //             Image.asset(icSignInBG),
      //             Container(
      //               child: Stack(
      //                 children: [
      //                   Image.asset(icSignInLinearBG),
      //                   Padding(
      //                     padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         backButton(context: context, image: icArrowLeft, onTap: () {
      //                           Navigator.pop(context);
      //                         }),
      //                         const SizedBox(height:80 ,),
      //                         Image.asset(icLogo,
      //                           width: 72,
      //                           height: 59,),
      //                         sizedBox10(),
      //                         Text(
      //                           "Sign In",
      //                           style: kManrope34BoldBlack,
      //                           textAlign: TextAlign.center,),
      //                         Text(
      //                           "Log in to continue your journey of\nyour love and connetion",
      //                           style: kManrope16MediumBlack,
      //                           textAlign: TextAlign.center,),
      //                         sizedBox20(),
      //                         AutofillGroup(
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text("Email / Username",
      //                                 style: kManrope14Medium626262,),
      //                               sizedBox6(),
      //                               textBox(
      //                                   string:  [AutofillHints.username],
      //                                   context: context,
      //                                   label: '',
      //                                   controller: emailController,
      //                                   hint: '',
      //                                   length: null,
      //                                   validator: (value) {
      //                                     return null;
      //                                   }, onChanged: (value) {
      //
      //                               }
      //
      //                               ),
      //                               sizedBox20(),
      //                               Text("Password",
      //                                 style: kManrope14Medium626262,),
      //                               sizedBox6(),
      //                               textBoxSuffixIcon(
      //                                   suffixOnTap: () {
      //                                     setState(() {
      //                                       _passwordVisible = !_passwordVisible;
      //                                     });
      //                                   },
      //                                   string:  [AutofillHints.password],
      //                                   context: context,
      //                                   label: '',
      //                                   controller: passwordController,
      //                                   hint: '',
      //                                   length: null,
      //                                   suffixIcon: _passwordVisible
      //                                       ? const Icon(Icons.visibility)
      //                                       : const Icon(Icons.visibility_off),
      //                                   validator: (value) {
      //                                     return ;
      //                                   }, bool: _passwordVisible, onChanged: (String ) {  }),
      //                               const SizedBox(height: 21,),
      //                               Align(
      //                                 alignment: Alignment.centerRight,
      //                                 child: GestureDetector(
      //                                   onTap: () {
      //                                     showModalBottomSheet(
      //                                       context: context,
      //                                       isScrollControlled: true,
      //                                       builder: (BuildContext context) {
      //                                         return ForgotPassEmailSheet();
      //                                       },
      //                                     );
      //                                     // Navigator.push(context, MaterialPageRoute(builder: (builder) => ForgotPasswordScreen()));
      //                                   },
      //                                   child: Text("Forgot Password",
      //                                     textAlign: TextAlign.right,
      //                                     style: kManrope16Regular4271ec,),
      //                                 ),
      //                               ),
      //
      //                               sizedBoxHeight32(),
      //                               loading ?
      //                               loadingButton(context: context) :
      //                               button(
      //                                   onTap: () {
      //                                     if(emailController.text.isNotEmpty ||
      //                                         passwordController.text.isNotEmpty) {
      //                                       TextInput.finishAutofillContext();
      //                                       if(_formKey.currentState!.validate()) {
      //                                         setState(() {
      //                                           loading = true;
      //                                         });
      //                                         loginApi(
      //                                           password: passwordController.text,
      //                                           userName: emailController.text,
      //                                         ).then((value) {
      //                                           response = value;
      //
      //                                           if (
      //                                               response?.status == 'success' /*value['status'] == 'success'*/) {
      //                                             setState(() {
      //                                               loading = false;
      //                                             });
      //                                             print("cehc");
      //                                             print(response);
      //                                             SharedPrefs().setLoginToken(response!.data!.accessToken.toString());
      //                                             SharedPrefs().setUserName(response!.data!.user!.username.toString());
      //                                             SharedPrefs().setName(response!.data!.user!.firstname.toString());
      //                                             SharedPrefs().setEmail((response!.data!.user!.email.toString()));
      //                                             SharedPrefs().setPhone(response!.data!.user!.mobile.toString());
      //                                             SharedPrefs().setProfileId(response!.data!.user!.profileId as int);
      //                                             SharedPrefs().setLoginTrue();
      //                                             SharedPrefs().setProfilePhoto(response!.data!.user!.image.toString());
      //                                             SharedPrefs().setLoginGender(response!.data!.user!.gender.toString());
      //                                             SharedPrefs().setLoginEmail(emailController.text);
      //                                             SharedPrefs().setLoginPassword(passwordController.text);
      //                                             Navigator.push(context, MaterialPageRoute(builder: (builder) =>
      //                                              HomeDashboardScreen(response: response!,)));
      //                                             ToastUtil.showToast("Login Successful");
      //
      //                                           } else {
      //                                             setState(() {
      //                                               loading = false;
      //                                             });
      //                                             print("fkfm");
      //                                             Fluttertoast.showToast(msg: "please check your account");
      //
      //                                           }
      //                                         });
      //                                       }
      //                                     } else {
      //                                       setState(() {
      //                                         loading = false;
      //                                       });
      //                                       ToastUtil.showToast("Please Enter Username and password");
      //
      //                                     }
      //                                   },
      //                                   context: context, title: 'Sign In'),
      //
      //                               sizedBoxHeight32(),
      //                               Align(
      //                                 alignment: Alignment.center,
      //                                 child: GestureDetector(
      //                                   behavior: HitTestBehavior.translucent,
      //                                   onTap: () {
      //                                     Navigator.push(context, MaterialPageRoute(
      //                                         builder: (builder) =>
      //                                         const SignInOptionScreen()));
      //                                   },
      //                                   child: Text("Sign Up Now",
      //                                     textAlign: TextAlign.center,
      //                                     style:kManrope18Bold101010 ,),
      //                                 ),
      //                               )
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ],
      //         )
      //
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }
}
