import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
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
    // Implement saving logic here
    // For example, you can save it to the document directory
    // and return the file path.
    return image.path;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            GestureDetector(
             // onTap: _pickImage
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
                selectedDate: _selectedDate,
                locale: Locale('en'),
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    _selectedDate = value;
                    final DateFormat formatter = DateFormat('yyyy/MM/dd');
                    String formattedDate = formatter.format(_selectedDate);
                    print(formattedDate);
                    print(_selectedDate);
                    SharedPrefs().setDob(formattedDate);
                    print('SharedPrefs().getDob()');


                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
