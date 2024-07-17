import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/src/constants/assets.dart';
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


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (authControl) {
          return  SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50,),
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
                sizedBox20(),
                Text("What is your birthday?",
                  style: styleSatoshiBold(size: 25, color: Colors.black),),
                sizedBox13(),
                Text("Your age information will be updated on your profile page and this will displayed publicly on your profile.",
                  style: styleSatoshiLight(size: 14, color: color828282),
                  textAlign: TextAlign.center,),
                SizedBox(
                  height: 250,
                  child: ScrollDatePicker(
                    maximumDate:  DateTime(2006, 12, 31),
                    selectedDate: _selectedDate,
                    locale: const Locale('en'),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        _selectedDate = value;
                        final DateFormat formatter = DateFormat('yyyy/MM/dd');
                        String formattedDate = formatter.format(_selectedDate);
                        authControl.setDob(formattedDate);
                        print(formattedDate);
                        print(_selectedDate);
                        print('SharedPrefs().getDob()');

                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } ),


      ),
    );
  }
}
