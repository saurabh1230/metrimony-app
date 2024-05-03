import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter/material.dart';


import '../../constants/assets.dart';
import '../../constants/textfield.dart';

import '../../utils/widgets/common_widgets.dart';
import '../user_profile/user_profile.dart';

class AllPremiumMatchesScreen extends StatefulWidget {
  const AllPremiumMatchesScreen({super.key});

  @override
  State<AllPremiumMatchesScreen> createState() => _AllPremiumMatchesScreenState();
}

class _AllPremiumMatchesScreenState extends State<AllPremiumMatchesScreen> {


  List<String> images = [
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
    "assets/images/ic_matches_profile.png",
  ];
  final searchController = TextEditingController();

  List<String> name  = [
    "Leslie Alexander",
    "Emily Sullivan",
    "Lily Turner",
    "Grace Harrison",
    "Sophia Bennett",
    "Aria Mitchell",
    "Ava Thompson",
    "Ella Hayes",
    "Mia Turner",
    "Ruby Morgan",
  ];
  List<String> filteredNames = [];
  @override
  void initState() {
    super.initState();
    filteredNames.addAll(name);
  }

  bool isSearch = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: backButton(context: context, image: icArrowLeft, onTap: () {
            Navigator.pop(context);
          }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: backButton(context: context,
                image: icSearch,
                onTap: (){
                  setState(() {
                    isSearch = !isSearch;
                  });
                }),
          ),
           const  SizedBox(width: 10,),
          // Padding(
          //   padding: const EdgeInsets.only(right: 16.0),
          //   child: backButton(context: context, image: icFilter, onTap: () {
          //     Navigator.push(context, MaterialPageRoute(
          //         builder: (builder) => const FilterMatchesScreen()));
          //   }),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,
              bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Premium Matches",
                style: styleSatoshiBold(size: 22, color: Colors.black),),
              isSearch ?
              textBoxPreIcon(
                  context: context,
                  label: 'Search',
                  img: icSearch,
                  controller: searchController,
                  hint: 'Search',
                  length: 40,
                  validator: null,
                  onChanged: search) :
                const  SizedBox.shrink(),
              sizedBox14(),
              Text("8 premium matches found",
                style: styleSatoshiMedium(size: 14, color: Colors.black.withOpacity(0.50)),),
              sizedBox13(),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredNames.length,
                itemBuilder: (_,i) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (builder) => const UserProfileScreen(userId: ''))
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(images[i],
                            height: 170,),
                        ),
                         const SizedBox(width: 20,),
                        Expanded(
                          flex:2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex:4,
                                    child: Text(filteredNames[i],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: styleSatoshiBold(size: 19, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Image.asset(icBookMark,
                                      height: 24,
                                      width: 24,),
                                  )
                                ],
                              ),
                              Text("5 ft 4 in  •  Khatri Hindu",
                                maxLines: 2,
                                style: styleSatoshiMedium(
                                    size: 13, color: Colors.black.withOpacity(0.80)),
                              ),
                              sizedBox16(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.asset(icBag,
                                      height: 17,
                                      width: 17,),
                                  ),
                                  SizedBox(width: 10,),
                    
                                  Expanded(
                                    flex:10,
                                    child: Text("Software Engineer",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines:2,
                    
                                      style: styleSatoshiMedium(
                                          size: 13, color: Colors.black.withOpacity(0.70)),
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox8(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Image.asset(icLocation,
                                      height: 17,
                                      width: 17,),
                                  ),
                                  const SizedBox(width: 10,),
                                  Expanded(
                                    flex:10,
                                    child: Text("New York, USA",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines:2,
                    
                                      style: styleSatoshiMedium(
                                          size: 13, color: Colors.black.withOpacity(0.70)),
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox16(),
                              button(
                                  fontSize: 14,
                                  height: 30,
                                  width: 134,
                                  context: context,
                                  onTap: (){},
                                  title: "Connect Now"),
                    
                    
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 30,),
              )

            ],
          ),
        ),
      ),

    );
  }

  void search(String text) {
    filteredNames.clear();
    if(text.isEmpty) {
      filteredNames.addAll(name);
    } else {
      filteredNames.addAll(name.where((name) => name.toLowerCase().contains(text.toLowerCase())));
    }
    setState(() {

    });
  }


}
