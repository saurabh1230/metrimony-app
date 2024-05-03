import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/material.dart';
import '../../../apis/profile_apis/images_apis.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../signup/signup_dashboard.dart';
import '../home_dashboard.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:photo_view/photo_view.dart';
import 'package:carousel_slider/carousel_slider.dart';


class EditPhotosScreen extends StatefulWidget {
  const EditPhotosScreen({super.key});

  @override
  State<EditPhotosScreen> createState() => _EditPhotosScreenState();
}

class _EditPhotosScreenState extends State<EditPhotosScreen> {

  List<String> images = [
    'assets/images/my_photos.png',
    'assets/images/ic_demo_profile.png',
    'assets/images/ic_matches_profile.png',
    'assets/images/ic_profile_male1.png',
    'assets/images/ic_welcome2.png'



  ];
  List<String> selectedItems = [];
  // // List selectedItems = [];
  // File pickedImage = File("");
  // final ImagePicker _imgPicker = ImagePicker();
  bool allImagesSelected = false;


  final _picker = ImagePicker();
  final CarouselController _controller = CarouselController();
  List<File> _pickedImages = [];
  int _index = 0;

  bool loading = false;



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "Photo",isBackButtonExist: true,),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child :_pickedImages.isEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12)
                ),
                child: InkWell(
                  onTap: () async {
                    List<XFile> images = await _picker.pickMultiImage();
                    setState(() {
                      for (var v in images) {
                        _pickedImages.add(File(v.path));
                      }
                    });
                    if (_pickedImages.isNotEmpty) {
                      // log(_pickedImages.toString());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: const Center(
                      child: DottedPlaceHolder(text:'Add Photos',),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

            ],
          )
              : Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CarouselSlider.builder(
                carouselController: _controller,
                itemCount: _pickedImages.length,
                itemBuilder: (ctx, index, realIndex) {
                  return Container(
                    //color: Colors.red,
                    height: 350,
                    child: Stack(
                      // clipBehavior: Clip.antiAlias,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.file(
                            _pickedImages[index],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _pickedImages.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              child: Icon(
                                Icons.delete_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  //height: 40.h,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _index = index;
                    });
                  },
                  viewportFraction: 0.5,
                  enlargeFactor: 0.3,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  //pageSnapping: false,
                  enableInfiniteScroll: false,
                ),
              ),
              SizedBox(
                height: 36,
              ),
              InkWell(
                onTap: () async {
                  List<XFile> images = await _picker.pickMultiImage();
                  setState(() {
                    for (var v in images) {
                      _pickedImages.add(File(v.path));
                    }
                  });
                  if (_pickedImages.isNotEmpty) {

                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Add more',
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 38,
              ),

              SizedBox(
                height: 16,
              ),
              button(
                color: Colors.redAccent,
                  context: context, onTap: () {
                setState(() {
                  _pickedImages.clear();
                });
              }, title: "Discard"),
              sizedBox16(),
              sizedBox16(),
              loading ?
                  loadingButton(context: context):
              button(
                  color: primaryColor,
                  context: context, onTap: () {
                    if (_pickedImages.length >= 5) {
                      ToastUtil.showToast("You can't add more than 5 photos at a time");
                    } else{
                      setState(() {
                        loading = true;
                      });
                      addImageAPi(imgList: _pickedImages
                        // id: career[0].id.toString(),
                      )
                          .then((value) {
                        if (value['status'] == true) {
                          setState(() {
                            loading = false;
                          });

                          // isLoading ? Loading() :careerInfo();
                          // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                          // const KycWaitScreen()));

                          // ToastUtil.showToast("Login Successful");

                          ToastUtil.showToast("Images Uploaded Successfully");
                        } else {
                          setState(() {
                            loading = false;
                          });

                          List<dynamic> errors =
                          value['message']['error'];
                          String errorMessage = errors.isNotEmpty
                              ? errors[0]
                              : "An unknown error occurred.";
                          Fluttertoast.showToast(msg: errorMessage);
                        }
                      });

                    }



              }, title: "Add")
            ],
          ),
        ),
      ),
    );
  }
}

// Create a new StatelessWidget for the PhotoViewScreen
