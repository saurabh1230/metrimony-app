//
// import 'package:get/get.dart';
// import 'package:bureau_couple/features/views/auth/sign_in_screen.dart';
// import 'package:bureau_couple/features/views/auth/welcome_screen.dart';
// import 'package:bureau_couple/features/views/dashboard/dashboard_screen.dart';
// import 'package:bureau_couple/features/views/splash/splash_screen.dart';
//
//
// class RouteHelper {
//   static const String initial = '/';
//   static const String splash = '/splash';
//   static const String welcome = '/welcome';
//   static const String onboarding = '/onboarding';
//   static const String signUp = '/signUp';
//   static const String otpVerification = '/otp-verification';
//   static const String signIn = '/signIn';
//   static const String dashboard = '/dashboard';
//
//
//
//   /// Routes ==================>
//   static String getInitialRoute() => initial;
//   static String getSplashRoute() => splash;
//   static String getWelcomeRoute() => welcome;
//   static String getSignInRoute() => signIn;
//   static String getDashboardRoute() => dashboard;
//
//
//
//
//
//   /// Pages ==================>
//   static List<GetPage> routes = [
//
//     GetPage(name: initial, page: () => const SplashScreen()),
//     GetPage(name: welcome, page: () => const WelcomeScreen()),
//     GetPage(name: signIn, page: () => const SignInScreen()),
//     GetPage(name: dashboard, page: () => const DashboardScreen()),
//
//
//   ];
// }