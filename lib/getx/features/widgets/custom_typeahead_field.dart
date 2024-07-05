import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:flutter/material.dart';

InputDecoration authDecoration(
    BuildContext context,
    String? hintText,) {
  return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 12, bottom: 18, top: 18, right: 10),
      hintText: hintText,
      hintStyle: satoshiRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
      // disabledBorder: OutlineInputBorder(borderRadius: radius(), borderSide: const BorderSide(color: Colors.transparent, width: 0.0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius5),
        borderSide: BorderSide(style: BorderStyle.solid, width: 0.3, color: Theme.of(context).primaryColorDark.withOpacity(0.80)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius5),
        borderSide: BorderSide(style: BorderStyle.solid, width: 1, color: Theme.of(context).primaryColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius5),
        borderSide: BorderSide(style:  BorderStyle.solid, width: 0.3, color:Theme.of(context).primaryColorDark.withOpacity(0.80)),
      ),
      suffixIcon: const Icon(Icons.arrow_drop_down)
  );
}