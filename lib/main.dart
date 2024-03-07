import 'dart:io';

import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:bureau_couple/src/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await SharedPrefs().init();
  runApp(const MyApp());
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
    ));

    return  ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return  GetMaterialApp(
            theme: ThemeData(
              primaryColor: primaryColor,//here.change this one
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          
        );
        //Dashboard());
      },
    );
  }
}

