import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/views/signup/signup_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/textfield.dart';
import '../../utils/widgets/common_widgets.dart';

class SignInOptionScreen extends StatefulWidget {
  const SignInOptionScreen({super.key});

  @override
  State<SignInOptionScreen> createState() => _SignInOptionScreenState();
}

class _SignInOptionScreenState extends State<SignInOptionScreen> {

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
                backButton(context: context, image: icArrowLeft, onTap: () {
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SingleChildScrollView(
              child: EasyRichText(
                "When Signing up bureau couple. you are agreeing. to our Terms & Condition and Privacy Policy",
                textAlign: TextAlign.center,
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'Terms & Condition',
                    stringBeforeTarget: 'our',
                    stringAfterTarget: "and",
                    style: TextStyle(color: primaryColor),
                  ),
                  EasyRichTextPattern(
                    targetString: 'Privacy Policy',
                    stringBeforeTarget: 'and',
                    stringAfterTarget: "",
                    style: TextStyle(color: primaryColor),
                  ),
                ],
              ),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0,
                    left: 20,
                    right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30,),
                    Image.asset(icLogo,
                      width: 91,
                      height: 74,),
                    sizedBox16(),
                    Text(
                      "Connecting Heart.One Swipe.at a Time. Your Pathway to Lasting Love ",
                      style: kManrope24SemiBoldBlack,
                      textAlign: TextAlign.center,),
                    SizedBox(height: 54,),
                    button(
                        context: context,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                              SignUpOnboardScreen()));
                        },
                        title: 'Join Us'),
                    SizedBox(height: 19,),
                    Text(
                      "OR",
                      style: kManrope16SemiBold828282,
                      textAlign: TextAlign.center,),
                    SizedBox(height: 19,),
                    socialMediaButton(
                        context: context,
                        onTap: () {  },
                        title: 'Continue with Facebook',
                        image: icFacebook24),
                    SizedBox(height: 12,),
                    socialMediaButton(
                        context: context,
                        onTap: () {  },
                        title: 'Continue with Google',
                        image: icGoogle24),
                    SizedBox(height: 12,),
                    socialMediaButton(
                        context: context,
                        onTap: () {  },
                        title: 'Continue with Google',
                        image: icApple24),



                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
