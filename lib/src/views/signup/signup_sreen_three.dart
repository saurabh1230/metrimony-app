import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:get/get.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import '../../constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

typedef ImagePickedCallback = void Function(String);
class SingUpScreenThree extends StatefulWidget {
  final ImagePickedCallback onImagePicked;

  const SingUpScreenThree({super.key, required this.onImagePicked,});

  @override
  State<SingUpScreenThree> createState() => _SingUpScreenThreeState();
  static final GlobalKey<FormState> _formKeyfinal = GlobalKey<FormState>();
  bool validate() {
    return _formKeyfinal.currentState?.validate() ?? false;
  }
}

class _SingUpScreenThreeState extends State<SingUpScreenThree> {
  // DateTime _selectedDate = DateTime.now();
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    pickedImage = File(""); // I
    DateTime today = DateTime.now();
    _selectedDate = today.subtract(const Duration(days: 18 * 365));
    fields();

    super.initState();
  }

  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();
  Future<void> _pickImage() async {
    final pickedFile = await _imgPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
      });
    }
  }



  Future<String> _saveImage(File image) async {
    return image.path;
  }

  final usernameController =  TextEditingController();
  final passwordController =  TextEditingController();
  final _emailController = TextEditingController();
  final _phNoController = TextEditingController();


  void fields() {
    usernameController.text = Get.find<AuthController>().userName ?? '';
    passwordController.text = Get.find<AuthController>().password ?? '';
    _emailController.text = Get.find<AuthController>().email ?? '';
    _phNoController.text = Get.find<AuthController>().phone ?? '';

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (authControl) {
          return  SingleChildScrollView(
            child: Form(
              key: SingUpScreenThree._formKeyfinal,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 50,),
                  GestureDetector(
                    onTap: () async {
                      XFile? v = await _imgPicker.pickImage(
                          source: ImageSource.gallery);
                      if (v != null) {
                        setState(
                              () {
                            pickedImage = File(v.path);
                          },
                        );
                        widget.onImagePicked(v.path);
                      }

                    },
                    child: Center(
                      child: Container(
                        height: 104,
                        width:  104,
                        clipBehavior: Clip.hardEdge,
                        decoration:  const BoxDecoration(
                          shape: BoxShape.circle,
                        ) ,
                        child: pickedImage.path.isEmpty
                            ? Image.asset(icProfilePlaceHolder,
                        )
                            : Image.file(
                          pickedImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  sizedBox20(),
                  Text(
                    'Final Step Lets Choose Profile Picture And Login Details',
                    textAlign: TextAlign.center,
                    style: kManrope14Medium626262.copyWith(color: Colors.black),
                  ),
                  sizedBox20(),
                  // SizedBox(
                  //   height: 250,
                  //   child: ScrollDatePicker(
                  //     maximumDate:  DateTime(2006, 12, 31),
                  //     selectedDate: _selectedDate,
                  //     locale: const Locale('en'),
                  //     onDateTimeChanged: (DateTime value) {
                  //       setState(() {
                  //         _selectedDate = value;
                  //         final DateFormat formatter = DateFormat('yyyy/MM/dd');
                  //         String formattedDate = formatter.format(_selectedDate);
                  //         authControl.setDob(formattedDate);
                  //         print(formattedDate);
                  //
                  //       });
                  //     },
                  //   ),
                  // ),

                  authControl.registerByPhone ?
                  const SizedBox() :
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        textAlign: TextAlign.center,
                        style: kManrope25Black.copyWith(fontSize: 16),
                      ),
                      sizedBox12(),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          authControl.setEmail(_emailController.text);
                        },
                      ),
                      sizedBox16(),
                    ],
                  ),
                  // authControl.registerByPhone ?
                 Column(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Phone Number',
                       textAlign: TextAlign.center,
                       style: kManrope25Black.copyWith(fontSize: 16),
                     ),
                     sizedBox12(),
                     CustomTextField(
                       inputType: TextInputType.number,
                       isNumber: true,
                       controller: _phNoController,
                       hintText: 'Phone',
                       validation: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please Enter your Phone No';
                         }
                         return null;
                       },
                       onChanged: (value) {
                         authControl.setPhone(_phNoController.text);
                       },
                     ) ,
                     sizedBox16(),

                   ],
                 ) /*: const SizedBox()*/,
                  Text(
                    'Choose Username',
                    textAlign: TextAlign.center,
                    style: kManrope25Black.copyWith(fontSize: 16),
                  ),
                  sizedBox12(),
                  CustomTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      } else if (value.length < 6) {
                        return 'Username must be at least 6 characters long';
                      } else if (!RegExp(r'^[a-z0-9]+$').hasMatch(value)) {
                        return 'Username must not contain special characters, spaces, or capital letters';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      authControl.setUserName(usernameController.text);
                    },
                  ),
                  sizedBox6(),
                  Text(
                    'Please Choose Unique Username min 6 characters',
                    textAlign: TextAlign.center,
                    style: kManrope14Medium626262.copyWith(color: Colors.black,fontSize: 10)
                  ),
                  sizedBox16(),
                  Text(
                    'Choose Password',
                    textAlign: TextAlign.center,
                    style: kManrope25Black.copyWith(fontSize: 16),
                  ),
                  sizedBox12(),
                  CustomTextField(
                    showTitle: true,
                    isPassword: true,
                    controller: passwordController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      authControl.setPassword(passwordController.text);
                    },
                    hintText: 'Password',
                  ),


                ],
              ),
            ),
          );
        } ),


      ),
    );
  }
}
