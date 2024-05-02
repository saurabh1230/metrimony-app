
import 'package:bureau_couple/src/constants/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

styleSatoshiBlack({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiBlack,
  );
}
styleSatoshiBlackItalic({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiBlackItalic);
}

styleSatoshiBold({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiBold, fontWeight: FontWeight.w900);
}

styleSatoshiBoldItalic({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiBoldItalic, fontWeight: FontWeight.bold);
}

styleSatoshiItalic({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiItalic);
}

styleSatoshiLight({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiLight);
}

styleSatoshiLightItalic({required double? size, required Color color}) {
  return TextStyle(fontSize: size ?? null, color: color, fontFamily: SatoshiLightItalic, fontWeight: FontWeight.w400);
}

styleSatoshiMedium({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiMedium);
}
styleSatoshiLarge({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiMedium, fontWeight: FontWeight.w500);
}
styleSatoshiMediumItalic({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiMediumItalic);
}
styleSatoshiRegular({required double size, required Color color}) {
  return TextStyle(fontSize: size, color: color, fontFamily: SatoshiRegular);
}

