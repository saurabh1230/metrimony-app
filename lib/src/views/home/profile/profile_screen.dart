import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/models/dashboard_model.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:bureau_couple/src/views/home/profile/edit_career_info.dart';
import 'package:bureau_couple/src/views/home/profile/edit_education_screen.dart';
import 'package:bureau_couple/src/views/home/profile/edit_interest.dart';
import 'package:bureau_couple/src/views/home/profile/edit_photos.dart';
import 'package:bureau_couple/src/views/home/profile/edit_physical_atributes.dart';
import 'package:bureau_couple/src/views/signIn/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../apis/dashboard/dashboard_api.dart';
import '../../../apis/login/login_api.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../apis/profile_apis/images_apis.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/textstyles.dart';
import '../../../models/basic_info_model.dart';
import '../../../models/images_model.dart';
import '../../../models/profie_model.dart';
import '../../../utils/widgets/buttons.dart';
import '../../../utils/widgets/custom_dialog.dart';
import '../../../utils/widgets/loader.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/pop_up_menu_button.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../utils/widgets/textfield_decoration.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'change_password_sheet.dart';
import 'edit_basic_info.dart';
import 'edit_family_info.dart';
import 'our_images_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String>? interest = ["Football","Nature","Language","Fashion","Photography","Music","Writing"];
  @override
  void initState() {
    profileDetail();
      getImage();
    super.initState();
  }
  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();
  ProfileModel  profile =  ProfileModel();
  bool isLoading = false;
  profileDetail() {
    isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
        if(value['status'] == true) {
          setState(() {
            profile = ProfileModel.fromJson(value);
            // for (var v in value['data']['user']) {
            //   dashboardDetails.add(DashboardModel.fromJson(v));
            // }
            // print(profile.data!.user!.username);
            // print('$baseProfilePhotoUrl${profile.data!.user!.image}');
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }

    });
  }
  //
  List<PhotosModel> photos = [];
  getImage() {
    isLoading = true;
    var resp = getImagesApi();
    resp.then((value) {
      photos.clear();
      if (value['status'] == true) {
        setState(() {
          List<dynamic> data = value['data'];
          for (var obj in data) {
            List<dynamic> galleries = obj['galleries'];
            for (var gallery in galleries) {
              photos.add(PhotosModel.fromJson(gallery));
            }
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final aboutController = TextEditingController();
  final educationController = TextEditingController();
  final designationController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();
  final marriedController = TextEditingController();
  final livesInController = TextEditingController();
  final childrenController = TextEditingController();
  final religionController = TextEditingController();
  final communityController = TextEditingController();
  final motherTongueController = TextEditingController();
  final gotraController = TextEditingController();
  final dietController = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading ? Loading(): Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        customDecoratedContainer(
                            child: Image.asset("assets/images/ic_profile_cover.png",
                              fit: BoxFit.cover,),
                            radius: 0,
                            color: Colors.transparent,
                            height: 180),
                        Container(
                          height: 50,

                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: CircularPercentIndicator(
                          radius: 110.0,
                          lineWidth: 7.0,
                          percent: 0.7,
                          center: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration :const BoxDecoration(
                                shape: BoxShape.circle,
                                  color:Colors.white,
                              ),
                              child:
                              GestureDetector(
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
                                child:pickedImage.path.isEmpty
                                    ? CachedNetworkImage(
                                  imageUrl: profile.data?.user?.image != null ? '$baseProfilePhotoUrl${profile.data!.user!.image}' : 'fallback_image_url_here',

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
                                ): Image.file(
                                  pickedImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          progressColor: Color(0xff00a337),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: backButton(context: context, image: icSettings, onTap: () async {
                        final result = await showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(20, 40, 0, 0), // Adjust the position as needed
                          items: [
                             PopupMenuItem<String>(
                               onTap: () {
                                 showDialog(
                                     context: context,
                                     builder: (BuildContext context) {
                                       return DeleteAccountDialog(
                                         titleButton1: 'Back',
                                         click1: () {
                                           Navigator.pop(context);
                                         },
                                         click2: () {
                                           Navigator.push(context, MaterialPageRoute(builder: (builder) => SignInScreen()));
                                         },
                                         heading: 'Delete this Account?',
                                         subheading: ' This Account with will be permanently deleted',
                                         mainButton: elevatedButton(
                                             height: 38,
                                             color: Colors.red,
                                             context: context, onTap: () {
                                         }, title: 'Delete Account',
                                             style: styleSatoshiLight(size: 14, color: Colors.white)),
                                       );
                                     });
                               },
                              value: 'Delete Account',
                              child: Text('Delete Account'),
                            ),
                            PopupMenuItem<String>(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const ChangePassSheet();
                                  },
                                );
                              },
                              value: 'Change Password',
                              child: Text('Change Password'),
                            ),
                             PopupMenuItem<String>(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return DeleteAccountDialog(
                                          titleButton1: 'Back',
                                          click1: () {
                                            Navigator.pop(context);
                                          },
                                          click2: () {
                                          },
                                          heading: 'Confirm Logout',
                                          subheading: 'Are you sure you want to Logout?',
                                          mainButton: loading
                                              ? loadingElevatedButton(
                                            height: 38,
                                            color: Colors.red,
                                            context: context,
                                          )
                                              : elevatedButton(
                                            height: 38,
                                            color: Colors.red,
                                            context: context,
                                            onTap: () {
                                              setState(() {
                                                loading = true;
                                              });

                                              logOutApi().then((value) {
                                                setState(() {});

                                                if (value['status'] == 'ok') {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  SharedPrefs().setLoginFalse();

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (builder) => const SignInScreen()));

                                                  ToastUtil.showToast("Logout Successfully");
                                                  print('done');
                                                } else {
                                                  setState(() {
                                                    loading = false;
                                                  });

                                                  List<dynamic>? errors = value['message']['error'];
                                                  String errorMessage = errors?.isNotEmpty == true
                                                      ? errors![0]
                                                      : "An unknown error occurred.";
                                                  Fluttertoast.showToast(msg: errorMessage);
                                                }
                                              });
                                            },
                                            title: 'Logout Account',
                                            style: styleSatoshiLight(size: 14, color: Colors.white),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              value: 'Logout',
                              child: Text('Logout'),
                            ),
                          ],
                        );

                        if (result != null) {
                          print('Selected: $result');
                        }
                      }),
                    )


                  ],
                ),
                sizedBox10(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Text("67% Profile completed",
                        textAlign: TextAlign.center,
                        style: styleSatoshiMedium(size: 13, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'Name',
                              addTextField: TextFormField(
                                maxLength: 30,
                                onChanged: (v) {
                                  setState(() {});

                                },
                                onFieldSubmitted: (v) {
                                  // Add your onChanged logic if needed
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller:nameController,
                                cursorColor: primaryColor,
                                decoration: AppTFDecoration(hint: 'Name')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );

                        },
                        child: Text(
                          nameController.text.isEmpty ?
                          '${profile.data?.user?.username ?? 'User'}':
                        // "Cody Fisher" :
                          nameController.text,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: styleSatoshiBold(size: 27, color: Colors.black),
                        ),
                      ),
                      sizedBox20(),
                      buildDataRowBold(title: 'Account Info', text: '', onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (builder) => const EditBasicInfoScreen()));
                      }),
                      sizedBox13(),
                      buildInfoRow(title: 'Email*',
                         text: (profile.data!.user == null || profile.data!.user!.email == null || profile.data!.user!.email!.isEmpty
                             ? 'Not Added'
                             : profile.data!.user!.email!),
                         /* text: emailController.text.isEmpty ?
                                ' celina_mark@gmail.com':
                          // '${dashboardDetails.data!.user!.email} ':
                          emailController.text, */
                          onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'Email',
                              addTextField: TextFormField(
                                maxLength: 30,
                                onChanged: (v) {
                                  setState(() {});

                                },
                                onFieldSubmitted: (v) {
                                  // Add your onChanged logic if needed
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller:emailController ,
                                cursorColor: primaryColor,
                                decoration: AppTFDecoration(hint: 'Email')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      }),
                      sizedBox13(),
                      buildInfoRow(title: 'Phone Number',
                          text: phoneController.text.isEmpty ?
                      // '+00 (232) 565 4534)' :
                          '${profile.data!.user!.mobile} ':
                      //     '${SharedPrefs().getPhone()}':
                       phoneController.text,
                          onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'Phone No',
                              addTextField: TextFormField(
                                maxLength: 30,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                controller:phoneController ,
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                cursorColor: primaryColor,
                                decoration: AppTFDecoration(hint: 'Phone No')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      }),
                      sizedBox13(),
                      buildInfoRow(title: 'Location', text: locationController.text.isEmpty ?
                      '${profile.data!.user!.address!.country} ${profile.data!.user!.address!.city}':
                      // 'New York, USA' :
                          locationController.text, onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'Location',
                              addTextField: TextFormField(
                                maxLength: 30,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller:locationController ,
                                cursorColor: primaryColor,
                                decoration: AppTFDecoration(hint:locationController.text.isEmpty ?  'Location' :
                                locationController.text)
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      }),
                      sizedBox40(),
                      buildDataRowBold(title: 'About Your Self', text: 'Change', onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NameEditDialogWidget(
                              title: 'About',
                              addTextField: TextFormField(
                                maxLength: 200,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                onEditingComplete: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                controller:aboutController ,
                                cursorColor: primaryColor,
                                decoration: AppTFDecoration(hint: 'About')
                                    .decoration(),
                                //keyboardType: TextInputType.phone,
                              ),
                            );
                          },
                        );
                      }),
                      sizedBox10(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return NameEditDialogWidget(
                                title: 'About',
                                addTextField: TextFormField(
                                  maxLength: 30,
                                  onChanged: (v) {
                                    setState(() {});
                                  },
                                  onEditingComplete: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  controller:aboutController ,
                                  cursorColor: primaryColor,
                                  decoration: AppTFDecoration(hint: 'About')
                                      .decoration(),
                                  //keyboardType: TextInputType.phone,
                                ),
                              );
                            },
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(aboutController.text.isEmpty ?
                              "Add About your self":
                          // "My name is Cody and I enjoy meet new people and in a partner, I'm looking for someone who is kind, honest, and has a good sense of humor." :
                            aboutController.text,
                            textAlign: TextAlign.start                                 ,
                            style:styleSatoshiLight(size: 14, color: color14152B.withOpacity(0.60)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,),
                        ),
                      ),
                      sizedBox40(),
                      buildDataRowBold(title: 'Education', text: 'Change', onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => const EditEducationScreen()));
                      }),

                      sizedBox13(),
                      buildDataRowBold(title: 'Career Info', text: 'Change', onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => const EditCareerInfoScreen()));
                      }),
                      sizedBox13(),


                      buildDataRowBold(title: 'Family Info', text: 'Change', onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => const EditFamilyInfoScreen()));
                      }),
                      sizedBox13(),


                      buildDataRowBold(title: 'Physical Attributes', text: 'Change', onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => const EditPhysicalAttributesScreen()));
                      }),
                      sizedBox13(),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox20(),
                          buildProfileRow(image: icBirthDatePro, title: 'Age', text: ageController.text.isEmpty ?'41 to 45':
                              ageController.text,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return NameEditDialogWidget(
                                      title: 'Age',
                                      addTextField: TextFormField(
                                        maxLength: 30,
                                        onChanged: (v) {
                                          setState(() {});

                                        },
                                        onEditingComplete: () {
                                          Navigator.pop(context); // Close the dialog
                                        },
                                        controller:ageController ,
                                        cursorColor: primaryColor,
                                        decoration: AppTFDecoration(hint: 'Age')
                                            .decoration(),
                                        //keyboardType: TextInputType.phone,
                                      ),
                                    );
                                  },
                                );
                              }),
                          buildProfileRow(image: icMarriedStatusPro, title: 'Married Status',
                              text:
                              // marriedController.text.isEmpty ?
                              profile.data!.user!.maritalStatus!.isEmpty || profile.data!.user!.maritalStatus == null ?
                                  "Update Married Status" :

                             '${profile.data!.user!.maritalStatus}' ,
                              // // 'Divorced (1 Child, Living together)':
                              // marriedController.text,
                              onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Married Status',
                                  addTextField: TextFormField(
                                    maxLength: 60,
                                    onChanged: (v) {
                                      setState(() {});

                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    controller:marriedController ,
                                    cursorColor: primaryColor,
                                    decoration: AppTFDecoration(hint: 'Married Status')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          }),
                          buildProfileRow(image: icLocationPro, title: 'Lives in',
                              text: livesInController.text.isEmpty ?
                              '${profile.data!.user!.address!.city}${profile.data!.user!.address!.state}${profile.data!.user!.address!.country}' :
                              // 'Lives in Nagpur, Maharashtra, India' :
                              livesInController.text,
                              onTap: () {
                            print('${profile.data!.user!.address!.city}' );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Lives In',
                                  addTextField: TextFormField(
                                    maxLength: 30,
                                    onChanged: (v) {
                                      setState(() {});

                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    controller:livesInController ,
                                    cursorColor: primaryColor,
                                    decoration: AppTFDecoration(hint: 'Lives In')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          }),
                          buildProfileRow(image: icChildrenIcon, title: 'Children', text: childrenController.text.isEmpty?
                          'Hindu: Agarwal, Hindu: Baniya, Hindu:Gupta, Hindu: Maheshwari' :
                              childrenController.text, onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Children',
                                  addTextField: TextFormField(
                                    maxLength: 30,
                                    onChanged: (v) {
                                      setState(() {});

                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    controller:childrenController ,
                                    cursorColor: primaryColor,
                                    decoration: AppTFDecoration(hint: 'Children')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          }),
                          buildProfileRow(image: icReligionIcon,
                              title: 'Religion', text: religionController.text.isEmpty ?
                             '${profile.data!.user!.religion}' :
                          // 'Hindu, Hindi' :
                              religionController.text, onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Religion',
                                  addTextField: TextFormField(
                                    maxLength: 30,
                                    onChanged: (v) {
                                      setState(() {});

                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    controller:religionController ,
                                    cursorColor: primaryColor,
                                    decoration: AppTFDecoration(hint: 'Religion')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          }),
                          buildProfileRow(image: icCommunityPro, title: 'Community',
                              text:communityController.text.isEmpty && profile.data!.user!.community ==null ?
                                  "Add Community"
                              '${profile.data!.user!.community}'.replaceAll("null", "") :
                              // 'Agarwal':
                              communityController.text, onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Community',
                                  addTextField: TextFormField(
                                    maxLength: 30,
                                    onChanged: (v) {
                                      setState(() {});

                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    controller:communityController ,
                                    cursorColor: primaryColor,
                                    decoration: AppTFDecoration(hint: 'Community')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          }),
                          buildProfileRow(image: icMotherToungeIcon, title: 'Mother Tongue',
                              text: motherTongueController.text.isEmpty ?
                              profile.data!.user!.community ==null ?
                                  "Add Mother Tongue":
                              '${profile.data!.user!.motherTongue}':
                          // 'Hindi' :
                              motherTongueController.text, onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Mother Tongue',
                                  addTextField: TextFormField(
                                    maxLength: 30,
                                    onChanged: (v) {
                                      setState(() {});

                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    controller:motherTongueController ,
                                    cursorColor: primaryColor,
                                    decoration: AppTFDecoration(hint: 'Mother Tongue')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          }),
                          buildProfileRow(image: icGotraIcon, title: 'Gotra', text:gotraController.text.isEmpty ?  'Jindal' :
                              gotraController.text, onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Gotra',
                                  addTextField: TextFormField(
                                    maxLength: 30,
                                    onChanged: (v) {
                                      setState(() {});

                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    controller:gotraController ,
                                    cursorColor: primaryColor,
                                    decoration: AppTFDecoration(hint: 'Gotra')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          }),
                          buildProfileRow(image: icDietIcon, title: 'Diet Preferences', text:dietController.text.isEmpty ?  'Vegetarian':
                              designationController.text, onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Vegetarian',
                                  addTextField: TextFormField(
                                    maxLength: 30,
                                    onChanged: (v) {
                                      setState(() {});

                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    controller:dietController ,
                                    cursorColor: primaryColor,
                                    decoration: AppTFDecoration(hint: 'Vegetarian')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          }),
                          // const SizedBox(height: 14,),
                        /*  buildDataRowBold(title: 'Interests', text: 'Change', onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (builder) => const EditInterestScreen()));
                          }),*/

                          // sizedBox14(),
                          // Wrap(
                          //   spacing: 8.0, // Adjust spacing as needed
                          //   runSpacing: 8.0, // Adjust run spacing as needed
                          //   children: interest!.map((e) => chipBox(name: e)).toList(),
                          // ),
                          sizedBox16(),
                          buildDataRowBold(title: 'Photos', text: 'Change', onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (builder) => const OurImagesScreen()));

                          }),
                          sizedBox8(),
                          photos.isEmpty  ?
                              SizedBox():
                          Stack(
                            children: [
                              GridView.builder(
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
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      height: 220,
                                      width: 130,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                          Colors.grey,
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
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Row(
                                  children: [
                                    customContainer(
                                      vertical: 5,
                                        horizontal: 10,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(ic4Dots),
                                            SizedBox(width: 6,),
                                            Text("See All")

                                          ],
                                        ),
                                        radius: 8,
                                        color: Colors.white, click: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (builder) => const OurImagesScreen()));

                                    })
                                  ],
                                ),
                              )
                            ],
                          ),
                          sizedBox28(),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // if (isLoading) Loading(),
        ],
      ),

    );
  }

  void _showCustomAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topRight,
          title: Text('Custom Alert Dialog'),
          content: Column(
            children: [
              Text('This is a custom alert dialog.'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }


  void _showCustomPopupMenu(BuildContext context) {
    Navigator.of(context).push(_customPopupPageRoute());
  }

  PageRouteBuilder _customPopupPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomPopupMenu();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}




GestureDetector buildDataRowBold({
    required String title,
    required String text,
  required Function() onTap,
}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                  style: styleSatoshiBold(size: 16, color: color1C1C1c),
                ),
                // Text(text,
                //   style: styleSatoshiMedium(size: 13, color: colorOnxy),
                // ),
                Image.asset(icArrowRight,
                  height: 18,
                  width: 18,)
              ],
            ),
    );
  }

GestureDetector buildInfoRow({
    required String title,
    required String text,
    required Function() onTap,

}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(title,
                    style: styleSatoshiRegular(size: 14, color: color5E5E5E),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(text,
                        maxLines: 2,
                        style: styleSatoshiMedium(size: 14, color: color212121),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Container chipBox({required String name}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(
            width: 0.5,
            color: color4B164C.withOpacity(0.20)
          ),
          color: Colors.transparent),
      padding: EdgeInsets.all(10),
      child: Text(
        name,
        style: styleSatoshiMedium(size: 16, color: color4B164C),

      ),
    );
  }

GestureDetector buildProfileRow({
    required String image,
    required String title,
    required String text,
    required Function() onTap,
}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0,bottom: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SvgPicture.asset(
                            image,
                            height: 48,
                            width: 48,
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                              style: styleSatoshiMedium(size: 14, color: color6C7378),),
                              SizedBox(
                                width: 280,
                                child: Text(text,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: styleSatoshiBold(size: 14, color: Colors.black),),
                              ),

                            ],
                          ),
                        )

                    ],),
      ),
    );
  }




