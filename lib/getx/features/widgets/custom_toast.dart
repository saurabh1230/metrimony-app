
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void showCustomSnackBar(String? message, {bool isError = true}) {
    Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity:  ToastGravity.TOP ,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      webBgColor: isError ? "linear-gradient(to right, #ff0000, #ff7373)" : "linear-gradient(to right,#006400, #32CD32)",
      webPosition: "top_right", // Specify custom position for web
      fontSize: 16.0,
    );


}