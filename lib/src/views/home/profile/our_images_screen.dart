import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:bureau_couple/getx/utils/theme.dart';
import 'package:bureau_couple/src/models/images_model.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../../apis/profile_apis/images_apis.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizedboxe.dart';
import '../../../constants/textstyles.dart';
import '../../../utils/urls.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../signup/signup_dashboard.dart';
import 'edit_photos.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
class OurImagesScreen extends StatefulWidget {
  const OurImagesScreen({super.key});

  @override
  State<OurImagesScreen> createState() => _OurImagesScreenState();
}

class _OurImagesScreenState extends State<OurImagesScreen> {
  List<String> images = [
    'assets/images/my_photos.png',
    'assets/images/ic_demo_profile.png',
    'assets/images/ic_matches_profile.png',
    'assets/images/ic_profile_male1.png',
    'assets/images/ic_welcome2.png'



  ];
  // List<String> selectedItems = [];
  String selectedItemId = '';
  bool allImagesSelected = false;
  bool loading = false;

  bool isLoading = false;
  @override
  void initState() {
    getImage();
    super.initState();
  }

  List<PhotosModel> photos = [];
  getImage() {
    isLoading = true;
    var resp = getImagesApi();
    resp.then((value) {
      photos.clear();
      if (value['status'] == true) {
        setState(() {
          List<dynamic> data = value['data'];
          // Iterate through each object in the 'data' array
          for (var obj in data) {
            // Access the 'galleries' array within each object
            List<dynamic> galleries = obj['galleries'];
            // Iterate through each object in the 'galleries' array
            for (var gallery in galleries) {
              photos.add(PhotosModel.fromJson(gallery));
            }
            print(photos.length);
          }
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: backButton(
            context: context,
            image: icArrowLeft,
            onTap: () {
              Navigator.pop(context); // Pop back to SignUpOnboardScreen
              SignUpOnboardScreen.pageViewKey.currentState?.navigateToPage(3);

              // Navigator.push(context, MaterialPageRoute(
              //     builder: (builder) =>
              //     const HomeDashboardScreen()));
            }),
      ),
      actions:  [
        const SizedBox(width: 5,),
        selectedItemId.isNotEmpty ?
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Row(
            children: [
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    print(selectedItemId);
                  imageDeleteApi(id: selectedItemId
                  ).then((value) {
                    setState(() {
                    });
                    if (value['status'] == true) {
                      setState(() {
                        loading = false;
                        isLoading  ? Loading() :    getImage();
                      });
                      // isLoading ? Loading() :careerInfo();
                      // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                      // const KycWaitScreen()));
                      // ToastUtil.showToast("Login Successful");
                      ToastUtil.showToast("Deleted Successfully");
                      print('done');
                    } else {
                      setState(() {
                        loading = false;
                      });


                      List<dynamic> errors = value['message']['error'];
                      String errorMessage = errors.isNotEmpty ? errors[0] : "An unknown error occurred.";
                      Fluttertoast.showToast(msg: errorMessage);
                    }
                  });
                },
                  child: Icon(Icons.delete,color: Theme.of(context).primaryColor,)),
            ],
          ),
        ) :
        SizedBox(),
      ],
    ),
      body: SingleChildScrollView(
       child: isLoading ? Loading() :CustomRefreshIndicator(
         onRefresh: () {
           setState(() {
             isLoading = true;
           });
           return     getImage();
         },
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16.0),
           child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Photos",
                        style: styleSatoshiBold(size: 16, color: Colors.black),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (builder) =>
                          const EditPhotosScreen()));
                        },
                          child: Icon(Icons.add)),
                    ],
                  ),
                  Center(child: Text('Select Image (Hold to delete photo)',style: satoshiLight.copyWith(color:themeRedColor,),)),
                  sizedBox14(),
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: photos.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (_, i) {
                        print(photos[i].image.toString());
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoViewScreen(
                                    imageProvider: NetworkImage(
                                      photos[i].image != null ? '$baseGalleryImage${photos[i].image}' : '',
                                    ),
                                  ),
                                ),
                              );
                            },
                        onLongPress: () {
                          setState(() {
                            selectedItemId = photos[i].id.toString();
                          });
                        },
                          child: Container(
                            height: 220,
                            width: 130,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                selectedItemId == photos[i].id.toString()
                                    ? Colors.red
                                    : Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: photos[i].image != null ? '$baseGalleryImage${photos[i].image}' : '',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(icLogo,
                                      height: 40,
                                      width: 40,),
                                  ),
                              progressIndicatorBuilder: (a, b, c) =>
                                  customShimmer(height: 0, /*width: 0,*/),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
         ),
       ),
      ),
    );
  }
}
class PhotoViewScreen extends StatelessWidget {
  final ImageProvider imageProvider;

  const PhotoViewScreen({Key? key, required this.imageProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Customize the app bar as needed
      ),
      body: PhotoView(
        imageProvider: imageProvider,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
}