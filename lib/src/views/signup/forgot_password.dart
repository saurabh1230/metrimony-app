import 'package:bureau_couple/src/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../constants/fonts.dart';
import '../../constants/sizedboxe.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign Up',
                    style: kManrope25Black,),
                  sizedBox8(),
                  Text("Start your journey towards everlasting love. Create an account and discover meaningful connections",
                    style: kManrope14Medium626262,),
                  const SizedBox(height: 23,),
                  Text("Username",
                    style: kManrope14Medium626262,),
                  sizedBox6(),
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    enableActiveFill: true,
                    showCursor: false,
                    pinTheme: PinTheme(
                      fieldHeight: 42,
                      fieldWidth: 56,
                      shape: PinCodeFieldShape.box,
                      borderWidth: 1,
                      borderRadius: BorderRadius.circular(8),
                      inactiveColor: primaryColor,
                      activeColor: primaryColor,
                      selectedColor: primaryColor,
                      selectedFillColor: Colors.grey.withOpacity(0.7),
                      activeFillColor: primaryColor,
                      inactiveFillColor: primaryColor,
                    ),
                    appContext: context,
                    length: 4,
                    onChanged: (value) {
                      setState(() {
                        // currentText = value;
                      });
                    },
                  ),

                ],
              ),
              const SizedBox(height: 24,),
            ],
          ),
        ),
      ),
    );
  }
}
