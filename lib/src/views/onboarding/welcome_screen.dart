import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:bureau_couple/src/views/signIn/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import '../../constants/sizedboxe.dart';
import '../../utils/widgets/buttons.dart';
import '../signIn/signin_option_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: Stack(
           children: [
             Column(
               children: [
                 Container(
                   height: 0.5.sh,
                 decoration: const BoxDecoration(
                   color: primaryColor,
                   gradient:LinearGradient(
                     colors: [Color(0xffffffff), Color(0xfff7325d)],
                     stops: [0.02, 0.5],
                     begin: Alignment.bottomCenter,
                     end: Alignment.topCenter,
                   )

                 ),
                 ),
                 Container(
                   height: 0.5.sh,
                   decoration: const BoxDecoration(
                     color: Colors.white,
                   ),
                 ),
               ],
             ),
             Padding(
               padding: const EdgeInsets.only(top: 100.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text("Welcome",
                   style: kManrope30,),
                   sizedBox8(),
                   Text("Embark on your journey to Everlasting\nLove Where Connection Blossoms",
                     textAlign: TextAlign.center,
                     style: kManrope16Medium,),
                   const SizedBox(height: 59,),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 26.0),
                     child: Stack(
                       children: [
                         Row(
                           children: [
                             Expanded(
                               child: Image.asset(
                                 icWelcome1,
                               ),
                             ),
                             const SizedBox(width: 4,),
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.only(top: 20.0),
                                 child: Image.asset(
                                   icWelcome2,
                                 ),
                               ),
                             )
                           ],
                         ),
                         Positioned(
                             left: 40,
                             right: 40,
                             top: 40,
                             bottom:40,
                             child: Container(
                               padding: const EdgeInsets.all(40),
                               child: Image.asset(icHeartWelcome,
                               height: 72,
                               width: 72,),
                             ))
                       ],
                     ),
                   ),
                   const SizedBox(height: 39,),
                   Text("Continue with Social Media",
                   style: kManrope16MediumBlack,),
                   sizedBox18(),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset(icFacebook,
                       height: 48,
                       width: 48,),
                       sizedBoxWidth15(),
                       Image.asset(icGoogle,
                         height: 48,
                         width: 48,),
                       sizedBoxWidth15(),
                       Image.asset(icApple,
                         height: 48,
                         width: 48,),
                     ],
                   ),
                   sizedBox28(),
                   Padding(
                     padding: const EdgeInsets.symmetric(
                         horizontal: 20,
                     ),
                   child:   button(
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                             const SignInOptionScreen()));
                       },
                       context: context,
                       title: 'Create Account'),
                   ),
                   const SizedBox(height: 29,),
                   GestureDetector(
                     behavior: HitTestBehavior.translucent,
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (builder)=>
                     const SignInOptionScreen()));},
                     child: Text("Sign in",
                     style: kManrope18BoldBlack,),
                   )

                 ],
               ),
             )
           ],
         ),
       ),
    );
  }
}
