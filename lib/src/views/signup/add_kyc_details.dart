import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';

import 'package:flutter/material.dart';

import '../../apis/signup_api/kyc_details_api.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';

import '../../constants/sizedboxe.dart';
import '../../constants/textfield.dart';

import 'package:intl/intl.dart';
import '../../utils/widgets/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'kyc_wait_screen.dart';

class AddKycDetailsScreen extends StatefulWidget {
  const AddKycDetailsScreen({super.key});

  @override
  State<AddKycDetailsScreen> createState() => _AddKycDetailsScreenState();
}

class _AddKycDetailsScreenState extends State<AddKycDetailsScreen> {

  final designationController = TextEditingController();
  final identityProof = TextEditingController();
  final joiningDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  late DateTime _selectedDate;
  bool loading = false;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: backButton(context: context, image: icCross, onTap: (){
              onBackPressed(context) ;}),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox14(),
                    Center(child: Image.asset(icLogo,
                      height: 120,
                      width: 180,),
                    ),
                    sizedBox8(),
                    Align(
                      alignment: Alignment.center,
                      child: Text('Add Kyc Details',
                        style: styleSatoshiBold(size: 20, color: Colors.black),),
                    ),
                    sizedBox8(),
                    Text("Add your KYC details to complete the Verification",
                      style: kManrope14Medium626262,),
                    const SizedBox(height: 23,),
                    Center(
                      child: GestureDetector(
                        onTap:  () async {
                          XFile? v = await _imgPicker.pickImage(
                              source: ImageSource.gallery);
                          if (v != null) {
                            setState(
                                  () {
                                pickedImage = File(v.path);
                              },
                            );
                          }

                        },
                        child: Container(
                          height: 200,
                          width: 200,
                          padding:const EdgeInsets.all(24),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              // color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: pickedImage.path.isEmpty
                              ? Image.asset(
                            icDocument,
                            fit: BoxFit.cover,
                          )  : Image.file(
                            pickedImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )

                    ),
                    Text("Designation",
                      style: kManrope14Medium626262,),
                    sizedBox6(),
                    textBox(
                      context: context,
                      label: '',
                      controller: designationController,
                      hint: '',
                      length: 20,
                      onChanged: (value) {


                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your designation';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20,),
                    Text("Identity Proof",
                      style: kManrope14Medium626262,),
                    sizedBox6(),
                    textBox(
                      context: context,
                      label: '',
                      controller: identityProof,
                      hint: '',
                      length: 20,
                      onChanged: (value) {


                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),

                    const SizedBox(height: 30,),
                    loading ?
                    loadingButton(context: context) :
                    button(context: context, onTap: () {
                      if(pickedImage.path.isNotEmpty ) {
                        if(_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          /*  ToastUtil.showToast("Registered Successfully");
                        Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                        const KycWaitScreen()));*/
                          kycDetailsApi(
                            designation: designationController.text,
                            identityProof:identityProof.text,
                            // joiningDate: joiningDateController.text,
                            photo: pickedImage.path,
                          ).then((value) {
                            setState(() {
                            });
                            if (value['status'] == true) {
                              setState(() {
                                loading = false;
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                              const KycWaitScreen()));

                              // ToastUtil.showToast("Login Successful");

                              ToastUtil.showToast("Registered Successfully");
              
                            } else {
                              setState(() {
                                loading = false;
                              });


                              List<dynamic> errors = value['message']['error'];
                              String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                              Fluttertoast.showToast(msg: errorMessage);
                            }
                          });

                        }
                      } else{
                        Fluttertoast.showToast(msg: "Please Enter kyc document");
                      }
            


                    }, title: "Submit")

                  ],
                ),
                const SizedBox(height: 24,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _showDatePickerBottomSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ScrollDatePicker(
            selectedDate: _selectedDate,
            locale: Locale('en'),
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _selectedDate = value;
                final DateFormat formatter = DateFormat('yyyy/MM/dd');
                String formattedDate = formatter.format(_selectedDate);
                joiningDateController.text = formattedDate;
                print(formattedDate);
                print(_selectedDate);

              });
            },
          ),
        );
      },
    );
  }
  onBackPressed(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.exit_to_app_sharp, color: primaryColor),
              SizedBox(width: 10),
              Text('Close Application?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
            content: const Text('Are you sure you want to exit the Application?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No', style: TextStyle(fontSize: 15, color: primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop(false); //Will not exit the App
                },
              ),
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 15, color: primaryColor),
                ),
                onPressed: () {
                  exit(0);
                },
              )
            ],
          );
        });
  }

}


