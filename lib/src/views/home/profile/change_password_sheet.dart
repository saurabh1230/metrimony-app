import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../apis/forgot_password_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/fonts.dart';
import '../../../constants/sizedboxe.dart';
import '../../../constants/textfield.dart';
import '../../../constants/textstyles.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/common_widgets.dart';

class ChangePassSheet extends StatefulWidget {

  const ChangePassSheet({super.key,});

  @override
  State<ChangePassSheet> createState() => _ChangePassSheetState();
}

class _ChangePassSheetState extends State<ChangePassSheet> {
  String? selectedValue;
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool _passwordVisible = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        width: 1.sw,
        padding: MediaQuery.of(context).viewInsets,

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  backButton(context: context, image: icCross, onTap: () {
                    Navigator.pop(context);
                  }),
                ],
              ),
              Text(
                'Change Password',
                style: styleSatoshiBold(size: 18, color: Colors.black),
              ),

              Text("Setup new password for login",
                style: styleSatoshiLight(size: 12, color: Colors.black),),
              sizedBox16(),
              Text("Old Password",
                style: kManrope14Medium626262,),
              sizedBox6(),
              textBoxSuffixIcon(
                  suffixOnTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  string:  [AutofillHints.password],
                  context: context,
                  label: '',
                  controller: oldPasswordController,
                  hint: '',
                  length: null,
                  suffixIcon: _passwordVisible
                      ?Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  validator: (value) {
                    return ;
                  }, bool: _passwordVisible, onChanged: (String ) {  }),
              sizedBox16(),
              Text("Password",
                style: kManrope14Medium626262,),
              sizedBox6(),
              textBoxSuffixIcon(
                  suffixOnTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  string:  [AutofillHints.password],
                  context: context,
                  label: '',
                  controller: passwordController,
                  hint: '',
                  length: null,
                  suffixIcon: _passwordVisible
                      ?Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  validator: (value) {
                    return ;
                  }, bool: _passwordVisible, onChanged: (String ) {  }),
              sizedBox16(),
              Text("Confirm Password",
                style: kManrope14Medium626262,),
              sizedBox6(),
              textBoxSuffixIcon(
                  suffixOnTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  string:  [AutofillHints.password],
                  context: context,
                  label: '',
                  controller: confirmController,
                  hint: '',
                  length: null,
                  suffixIcon: _passwordVisible
                      ?Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  bool: _passwordVisible, onChanged: (String ) {  }),

              sizedBox16(),
              sizedBox16(),
              loading ?
              loadingButton(context: context):
              button(context: context, onTap: () {
                if (_validatePasswordsMatch()) {
                  setState(() {
                    loading = true;
                  });
                  changePasswordApi(
                      currentPassword:oldPasswordController.text ,
                      oldPassword: passwordController.text,
                      confirmPassword: confirmController.text

                  ).then((value) {
                    if ( value['status'] == 'success') {
                      setState(() {
                        loading = false;
                      });
                      ToastUtil.showToast("Password changed successfully");
                      Navigator.pop(context);



                    } else if(value['status'] == 'error'){
                      // setState(() {
                        loading = false;
                      // });
                      List<dynamic> errors = value['message']['error'];
                      String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                      ToastUtil.showToast(errorMessage);
                    }
                  });
                  Navigator.pop(context);
                }
                // Navigator.pop(context);

              }, title: "Done"),
              sizedBox16(),


            ],
          ),
        ),
      ),
    );
  }
  bool _validatePasswordsMatch() {
    // Validate if passwords match
    if (passwordController.text != confirmController.text) {
      // Show an error message or handle the case when passwords don't match
      // For now, you can print an error message
      print('Passwords do not match');
      return false;
    }
    return true;
  }
}