


import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/models/LoginResponse.dart';
import 'package:bureau_couple/src/views/home/home_dashboard.dart';
import 'package:bureau_couple/src/views/signIn/signin_option_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../apis/login/login_api.dart';
import '../../constants/shared_prefs.dart';
import '../onboarding/onboarding_screen.dart';
import '../onboarding/welcome_screen.dart';
import '../signIn/sign_in_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    setPage();
  }

  setScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const SignInOptionScreen()));
    });
  }

  LoginResponse? response;

  setPage() {
    SharedPrefs().init();
    bool loginBool;
    bool firstRun ;
    Future.delayed(const Duration(seconds: 2), () {
      firstRun = SharedPrefs().getFirstRun() ?? false;
      loginBool = SharedPrefs().getLogin() ?? false;

      if (firstRun) {
        if (loginBool) {
        /*  loginApi(
            password: '${SharedPrefs().getLoginPassword()}',
            userName: '${SharedPrefs().getLoginEmail()}',
          ).then((value) {
            response = value;
            if (response?.status != null &&
                response!.status == 'success') {
              Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                  HomeDashboardScreen(response: response!,)));

            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignInScreen(),
                ),
              );
            }
          });*/

          loginApi(
            password: '${SharedPrefs().getLoginPassword()}',
            userName: '${SharedPrefs().getLoginEmail()}',
          ).then((value) {
            response = value;
            if (

                response!.status == 'success'
            /*value['status'] == 'success'*/) {
              print("dsd");
              print(response!.data!.user!.gender.toString());
              SharedPrefs().setLoginToken(response!.data!.accessToken.toString());
              SharedPrefs().setLoginTrue();
              // SharedPrefs().setLoginEmail(emailController.text);
              // SharedPrefs().setLoginPassword(passwordController.text);
              Navigator.push(context, MaterialPageRoute(builder: (builder) =>
               HomeDashboardScreen(response: response!,)));
              // ToastUtil.showToast("Login Successful");

            } else {
              print("api false");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignInOptionScreen(),
                ),
              );
            }
          });
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SignInOptionScreen(),
              ));
        }
      }
      else {
        SharedPrefs().setFirstRunDone();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SignInOptionScreen(),
          ),
        );
      }
    });
  }

/*  setPage() {
    SharedPrefs().init();
    bool loginBool;
    bool firstRun;
    // bool signLogin;
    Future.delayed(Duration(seconds: 2), () {
      firstRun = SharedPrefs().getFirstRun() ?? false;
      loginBool = SharedPrefs().getLogin() ?? false;
      // signLogin = SharedPrefs().getSignLogin() ?? false;
      if (firstRun) {
        if (loginBool) {
          print("done");
          loginApi(
            password: '${SharedPrefs().getLoginPassword()}',
            userName: '${SharedPrefs().getLoginEmail()}',
          ).then((value) {
            if ( value['status'] == 'success') {
              SharedPrefs().setLoginToken(value['data']['access_token']);
              // SharedPrefs().setLoginEmail(emailController.text);
              // SharedPrefs().setLoginPassword(passwordController.text);
              Navigator.push(context, MaterialPageRoute(builder: (builder) =>
              const HomeDashboardScreen()));
              // ToastUtil.showToast("Login Successful");

            } else {
              print("api false");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SignInScreen(),
                ),
              );
            }
          });
        } else {
          print("false");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SignInScreen(),
              ));
        }
      }
      else {
        SharedPrefs().setFirstRunDone();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const IntroPage(),
          ),
        );
      }
    });
  }*/


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(authBackground,),fit: BoxFit.cover)
            ),
          ),
          Center(child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset(icLogo,),
          )),
        ],
      ),
      // body: Stack(
      //   children: [
      //     Column(
      //       children: [
      //         Align(
      //           alignment: Alignment.topRight,
      //             child: Image.asset("assets/icons/ic_heart1.png",
      //             height: 150,)),
      //         Align(
      //           alignment: Alignment.centerLeft,
      //           child: Image.asset(
      //             height: 150,
      //             "assets/icons/ic_heart2.png",
      //           ),
      //         ),
      //         Align(
      //             alignment: Alignment.topRight,
      //             child: Image.asset(
      //               "assets/icons/ic_heart3.png",
      //               height: 150,
      //               ),
      //         ),
      //         Align(
      //           alignment: Alignment.bottomLeft,
      //           child: Image.asset(
      //             height: 150,
      //             "assets/icons/ic_heart2.png",
      //           ),
      //         ),
      //         Align(
      //           alignment: Alignment.bottomRight,
      //           child: Image.asset(
      //             height: 150,
      //             "assets/icons/ic_bottom_right.png",
      //           ),
      //         ),
      //       ],
      //     ),
      //     Center(
      //         child: Image.asset(
      //           'assets/icons/ic_splash_logo.png',
      //         color: Colors.white,
      //         height: 111,
      //         width: 237,
      //         ),
      //       ),
      //     ],
      //   ),
      // body: Column(
      //   children: [
      //     Container(
      //       height: 1.sh,
      //       decoration: const BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage(icSplashBg,
      //             ),
      //         fit: BoxFit.cover)
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
