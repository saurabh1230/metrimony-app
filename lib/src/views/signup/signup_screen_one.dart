import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import '../../constants/fonts.dart';
import '../../constants/shared_prefs.dart';
import '../../constants/sizedboxe.dart';
import '../../constants/textfield.dart';
import '../../utils/state.dart';
import 'package:provider/provider.dart';
import '../../utils/widgets/buttons.dart';


class SignUpScreenOne extends StatefulWidget {

  const SignUpScreenOne({super.key, });
  @override
  State<SignUpScreenOne> createState() => _SignUpScreenOneState();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validate() {
    return _formKey.currentState?.validate() ?? false;
  }
}

class _SignUpScreenOneState extends State<SignUpScreenOne> {



  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phNoController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible = false;

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: SignUpScreenOne._formKey,
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
                      textBox(
                        context: context,
                        label: '',
                        controller: usernameController,
                        hint: '',
                        length: 20,
                        onChanged: (value) {
                          setState(() {
                            SharedPrefs().setUserName(usernameController.text);
                          });

                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          } else if (value.length < 6) {
                            return 'username must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20,),
                      Text("First Name",
                        style: kManrope14Medium626262,),
                      sizedBox6(),
                      textBox(
                          context: context,
                          label: '',
                          controller: firstNameController,
                          hint: '',
                          length: 20,
                          onChanged: (value) {
                            setState(() {
                              SharedPrefs().setName(firstNameController.text);
                            });

                          },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                          ),
                      const SizedBox(height: 20,),

                      Text("Last Name",
                        style: kManrope14Medium626262,),
                      sizedBox6(),
                      textBox(
                          context: context,
                          label: '',
                          controller: lastNameController,
                          hint: '',
                          length: 20,
                          onChanged: (value) {
                            setState(() {
                              SharedPrefs().setLastName(lastNameController.text);
                            });
                          },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Last name';
                          }
                          return null;
                        },),
                      SizedBox(height: 20,),
                      Text("Email",
                        style: kManrope14Medium626262,),
                      sizedBox6(),
                      textBox(
                          context: context,
                          label: '',
                          controller: emailController,
                          hint: '',
                          length: 30,
                          onChanged: (value) {
                            SharedPrefs().setEmail(emailController.text);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.contains('@') || !value.contains('.com')) {
                              return 'enter Valid email';
                            }
                            return null;
                          },),
                      SizedBox(height: 20,),
                      Text("Phone",
                        style: kManrope14Medium626262,),
                      sizedBox6(),
                      textBoxPrefixIcon(
                          context: context,
                          label: '',
                          controller: phNoController,
                          hint: '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Phone no';
                            }
                            return null;
                          }, onChanged: (value) {
                            setState(() {
                              SharedPrefs().setPhone(phNoController.text);
                            });
                      }, length: 10),
                      SizedBox(height: 20,),

                      Text("Password",
                        style: kManrope14Medium626262,),
                      sizedBox6(),
                      textBoxSuffixIcon(
                          suffixOnTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          context: context,
                          label: '',
                          controller: passwordController,
                          hint: '',
                          length: null,
                          suffixIcon: _passwordVisible
                              ?Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please set a password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          }, bool: _passwordVisible,
                          onChanged: (value) {
                            SharedPrefs().setPassword(passwordController.text);
                          }),
                    ],
                  ),
              SizedBox(height: 24,),
            ],
          ),
        ),
      ),
    );
  }

}
