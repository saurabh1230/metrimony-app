

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../apis/forgot_password_api.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/textfield.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/buttons.dart';
import '../../utils/widgets/common_widgets.dart';


class ForgotPassEmailSheet extends StatefulWidget {
  @override
  State<ForgotPassEmailSheet> createState() => _ForgotPassEmailSheetState();
}

class _ForgotPassEmailSheetState extends State<ForgotPassEmailSheet> {


  String? selectedValue;
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      // height: MediaQuery.of(context).size.height - 40,
      padding: MediaQuery.of(context).viewInsets,

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Forgot Password',
                style: styleSatoshiBold(size: 18, color: Colors.black),
              ),
              sizedBox16(),
              Text("Enter Your email to reset password \nyou will receive otp on your mail",
                style: styleSatoshiLight(size: 12, color: Colors.black),),
              sizedBox16(),
              Text("Email",
                style: kManrope14Medium626262,),
              sizedBox6(),

              textBox(
                  context: context,
                  label: "Email",
                  controller: emailController,
                  hint: '',
                  length: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@') || !value.contains('.com')) {
                      return 'Enter Valid email';
                    }
                    return null;
                  },
                  onChanged: null),
              sizedBox16(),


              sizedBox16(),

              loading ?
                  loadingButton(context: context):
              button(context: context, onTap: () {
                if(_formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  forgotPassEmailApi(
                    email: emailController.text,
                  ).then((value) {
                    if ( value['status'] == 'success') {
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return ForgotPasswordOtpSheet(email: emailController.text,);
                        },
                      );

                      // Flutter(value['data']['code']);
                      ToastUtil.showToast(value['data']['code'].toString());
                      // ToastUtil.showToast(value['data']['code']);

                    } else if(value['status'] == 'error'){
                      setState(() {
                        loading = false;
                      });
                      List<dynamic> errors = value['message']['error'];
                      String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                      ToastUtil.showToast(errorMessage);
                    }
                  });


                }

              }, title: "Send"),
              sizedBox16(),


            ],
          ),
        ),
      ),
    );
  }
}



class ForgotPasswordOtpSheet extends StatefulWidget {
  final String email;
  const ForgotPasswordOtpSheet({super.key, required this.email});

  @override
  State<ForgotPasswordOtpSheet> createState() => _ForgotPasswordOtpSheetState();
}

class _ForgotPasswordOtpSheetState extends State<ForgotPasswordOtpSheet> {
  @override
  String? selectedValue;
  final otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  Timer? _timer;
  int _start = 30;
  String otp = '';

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
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
          child: Form(
            key: _formKey,
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
                  'Enter your 4 Code',
                  style: styleSatoshiBold(size: 18, color: Colors.black),
                ),
                sizedBox16(),
                Text("Enter Your 4 digit code that you received on your email",
                  style: styleSatoshiLight(size: 12, color: Colors.black),),
                sizedBox16(),
                // Text("Enter Otp",
                //   style: kManrope14Medium626262,),
                sizedBox6(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: PinCodeTextField(
                          keyboardType: TextInputType.number,
                          controller: otpController,
                          enableActiveFill: true,
                          showCursor: false,
                          pinTheme: PinTheme(
                            fieldHeight: 35,
                            fieldWidth: 35,
                            shape: PinCodeFieldShape.box,
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(8),
                            inactiveColor: primaryColor,
                            activeColor: primaryColor,
                            selectedColor: primaryColor,
                            selectedFillColor:Colors.white,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                          ),
                          appContext: context,
                          length: 6,
                          validator: (value) {

                            return 'Please Verify with OTP';

                          },
                          onChanged: (value) {
                            setState(() {
                              // currentText = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBox16(),
                InkWell(
                    onTap: _start == 0
                        ? () {
                      setState(() {
                        _start = 30;
                      });
                      _startTimer();
                    }
                        : () {

                      //print(otp.length);
                    },
                    child: Text(
                        _start == 0 ? "Resend" :
                        'Resend ${_start.toString()}',
                        style: styleSatoshiLight(size: 16, color: primaryColor)
                      /* _start == 0
                          ? kManRope_400_16_006D77
                          : kManRope_400_16_626A6A*/
                    )
                ),
                sizedBox16(),

                loading ?
                loadingButton(context: context): button(
                    context: context,
                    onTap: () {
                      // if(_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        forgotPassOtpApi(
                          email:widget.email,
                          code: otpController.text,
                        ).then((value) {
                          if ( value['status'] == 'success') {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return ForgotChangePassSheet(
                                  email: widget.email,
                                  otp: otpController.text,
                                );
                              },
                            );

                            ToastUtil.showToast("Otp Validate Set Password now");

                          } else if(value['status'] == 'error'){
                            setState(() {
                              loading = false;
                            });
                            List<dynamic> errors = value['message']['error'];
                            String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                            ToastUtil.showToast(errorMessage);
                          }
                        });

                      // }
                      // Navigator.push(context, MaterialPageRoute(builder: (builder) => ForgotChangePassSheet()));
                    }, title: "Send"),
                sizedBox16(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotChangePassSheet extends StatefulWidget {
  final String email;
  final String otp;
  const ForgotChangePassSheet({super.key, required this.email, required this.otp});

  @override
  State<ForgotChangePassSheet> createState() => _ForgotChangePassSheetState();
}

class _ForgotChangePassSheetState extends State<ForgotChangePassSheet> {
  String? selectedValue;
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
                'Reset Password',
                style: styleSatoshiBold(size: 18, color: Colors.black),
              ),
              sizedBox16(),
              Text("Setup new password for login",
                style: styleSatoshiLight(size: 12, color: Colors.black),),
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
                      ?const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
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
                      ? const Icon(Icons.visibility)
                      : const  Icon(Icons.visibility_off),
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
                  forgotEnterNewPassApi(
                    email: widget.email,
                    password: passwordController.text,
                    confirmPassword:confirmController.text,
                    code: widget.otp,
                  ).then((value) {
                    if ( value['status'] == 'success') {
                      setState(() {
                        loading = false;
                      });
                      ToastUtil.showToast("Password changed successfully");
                      Navigator.pop(context);



                    } else if(value['status'] == 'error'){
                      setState(() {
                        loading = false;
                      });
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
    
      return false;
    }
    return true;
  }
}


