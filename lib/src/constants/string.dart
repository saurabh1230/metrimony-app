const String SatoshiBlack = 'Satoshi-Black';
const String SatoshiBlackItalic = 'Satoshi-BoldItalic';
const String SatoshiBold = 'Satoshi-Bold';
const String SatoshiBoldItalic = 'Satoshi-BoldItalic';
const String SatoshiItalic = 'Satoshi-Italic';
const String SatoshiLight = 'Satoshi-Light';
const String SatoshiLightItalic = 'Satoshi-LightItalic';
const String SatoshiMedium = 'Satoshi-Medium';
const String SatoshiMediumItalic = 'Satoshi-MediumItalic';
const String SatoshiRegular = 'Satoshi-Regular';


class Keys {
  final String token = 'token';
  final String firstRun = 'firstRun';}


class StringUtils {
  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
