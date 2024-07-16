import 'package:bureau_couple/src/constants/assets.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:
          Column(
            children: [
              Card(
              shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
               ),
                elevation: 2,
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                  child: Image.asset(icArrowLeft,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
