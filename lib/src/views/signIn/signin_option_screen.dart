import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/register_bottom_sheet.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/views/signIn/sign_in_screen.dart';
import 'package:bureau_couple/src/views/signup/signup_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/sizedboxe.dart';
import '../../utils/widgets/common_widgets.dart';

class SignInOptionScreen extends StatefulWidget {
  const SignInOptionScreen({super.key});

  @override
  State<SignInOptionScreen> createState() => _SignInOptionScreenState();
}

class _SignInOptionScreenState extends State<SignInOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,
      bottomNavigationBar:
      SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (authController) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0,left: 16,bottom: 20,right: 16),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'New To Bureau Couple ?',
                    textAlign: TextAlign.center,
                    style: kManrope16SemiBold828282.copyWith(color: Colors.black),
                  ),
                ),
                sizedBox12(),
                socialMediaButton(
                    context: context,
                    onTap: () {
                      Get.bottomSheet(
                        RegisterBottomSheet(emailOrPhone: 'Email Id',),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (builder) => SignUpOnboardScreen()));
                      },
                    title: 'Sign Up With Email',
                    image: icEmail),
                sizedBox10(),
                socialMediaButton(
                    context: context,
                    onTap: () {
                      Get.bottomSheet(
                        RegisterBottomSheet(emailOrPhone: 'Mobile No',),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (builder) => SignUpOnboardScreen()));
                      authController.registerByPhone == true;
                    },
                    title: 'Sign Up With Phone',
                    image: icPhone),
                sizedBox10(),
                socialMediaButton(
                    context: context,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => SignUpOnboardScreen()));

                    },
                    title: 'Sign Up With Google',
                    image: icGoogle24),
                sizedBox40(),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Already Register With Us',
                        textAlign: TextAlign.center,
                        style: kManrope16SemiBold828282.copyWith(color: Colors.black,fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>
                        const SignInScreen()));
                      },
                      child: Container(padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Text("Login",style: kManrope16SemiBold828282.copyWith(color: Theme.of(context).cardColor,fontSize: 14),)),
                    )
                  ],
                ),
              ],
            ),
          );
        })
      ),
      body:  Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(authBackground,),fit: BoxFit.cover)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 160,left: 44,right: 44,bottom: 60),
                  child: Image.asset(icLogo,),
                ),



              ],
            ),
          ),
          // child: Scaffold(
          //   appBar: AppBar(
          //     backgroundColor: Colors.white,
          //     elevation: 0,
          //     centerTitle: true,
          //     automaticallyImplyLeading: false,
          //     title: Padding(
          //       padding: const EdgeInsets.only(
          //         left: 5.0,right: 20,),
          //       child: Row(
          //         children: [
          //           backButton(context: context, image: icArrowLeft, onTap: () {
          //             Navigator.pop(context);
          //           }),
          //         ],
          //       ),
          //     ),
          //   ),
          //   bottomNavigationBar: Padding(
          //     padding: const EdgeInsets.only(bottom: 16.0),
          //     child: SingleChildScrollView(
          //         child: EasyRichText(
          //           "When Signing up bureau couple. you are agreeing. to our Terms & Condition and Privacy Policy",
          //           textAlign: TextAlign.center,
          //           patternList: [
          //             EasyRichTextPattern(
          //               targetString: 'Terms & Condition',
          //               stringBeforeTarget: 'our',
          //               stringAfterTarget: "and",
          //               style: const TextStyle(color: primaryColor),
          //             ),
          //             EasyRichTextPattern(
          //               targetString: 'Privacy Policy',
          //               stringBeforeTarget: 'and',
          //               stringAfterTarget: "",
          //               style: const TextStyle(color: primaryColor),
          //             ),
          //           ],
          //         ),),
          //   ),
          //   body: Container(
          //     decoration: const BoxDecoration(
          //         image: DecorationImage(image: AssetImage(authBackground,),fit: BoxFit.cover)
          //     ),
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(top: 20.0,
          //                 left: 20,
          //                 right: 20),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 const SizedBox(height: 30,),
          //                 Image.asset(icLogo,
          //                   width: 91,
          //                   height: 74,),
          //                 sizedBox16(),
          //                 Text("Connecting Heart.One Swipe.at a Time. Your Pathway to Lasting Love ",
          //                   style: kManrope24SemiBoldBlack, textAlign: TextAlign.center,),
          //                 const SizedBox(height: 54,),
          //                 button(context: context,
          //                     onTap: (){
          //                       Navigator.push(context, MaterialPageRoute(builder: (builder) => SignUpOnboardScreen()));
          //                     },
          //                     title: 'Join Us'),
          //                 const SizedBox(height: 19,),
          //                 Text(
          //                   "OR",
          //                   style: kManrope16SemiBold828282,
          //                   textAlign: TextAlign.center,),
          //                 const SizedBox(height: 19,),
          //                 socialMediaButton(
          //                     context: context,
          //                     onTap: () {  },
          //                     title: 'Continue with Facebook',
          //                     image: icFacebook24),
          //                 SizedBox(height: 12,),
          //                 socialMediaButton(
          //                     context: context,
          //                     onTap: () {  },
          //                     title: 'Continue with Google',
          //                     image: icGoogle24),
          //                 const SizedBox(height: 12,),
          //                 socialMediaButton(
          //                     context: context,
          //                     onTap: () {  },
          //                     title: 'Continue with Google',
          //                     image: icApple24),
          //
          //
          //
          //               ],
          //             ),
          //           )
          //
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ),




    );
  }
}
