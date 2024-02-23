import 'package:bureau_couple/src/constants/assets.dart';
import 'package:bureau_couple/src/constants/colors.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:bureau_couple/src/views/home/home_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../signup/signup_dashboard.dart';

class EditInterestScreen extends StatefulWidget {
  const EditInterestScreen({super.key});

  @override
  State<EditInterestScreen> createState() => _EditInterestScreenState();
}

class _EditInterestScreenState extends State<EditInterestScreen> {

  List tags = [
    'Football',
    'Nature',
    'Language',
    'Fashion',
    'Dancing',
    'Trekking',
    'Make-up',
    'Writing',
    'Photography',
    'Swimming',
    'Coding',
    'Designing',
    'Eating',
    'Movies',
    'Music',
    'Gardening',
    'Cooking',
    'Gadgets',
    'Video games',
    'Travelling',
    'Sports',
    'Antiques',
    'Board Games',
    'Hiking',
    'Pets',
    'Yoga',
    'Shows',
    'Beauty',
    'Gym',
    'Craft',
    'Fishing',
    'Art'
  ];

  List tagsList = [];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        width: 1.sw,
        height: 52.h,
        color: Colors.transparent,
        child:  SingleChildScrollView(
          child: button(
              context: context,
              onTap: () {

              },
              title: 'update ${tagsList.isNotEmpty && tagsList.length < 11 ? '(${tagsList.length}/10)' : ''}',),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: backButton(
              context: context,
              image: icArrowLeft,
              onTap: () {
                Navigator.pop(context); // Pop back to SignUpOnboardScreen
                SignUpOnboardScreen.pageViewKey.currentState?.navigateToPage(3);
                // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                // HomeDashboardScreen()));
          }),
        ),
      ),
      body:SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxHeight: 1.sh),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Select your Interests",
                style:styleSatoshiBold(size: 20, color: Colors.black),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Select upto 10 interests",
                style: styleSatoshiLight(size: 14, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: tags.length,
                  //physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2.8,
                  ),
                  itemBuilder: (_, i) {
                    return TagContainer(
                      onTap: () {
                        if (tagsList.length < 10 && !tagsList.contains(tags[i])) {
                          tagsList.add(tags[i]);
                        } else {
                          tagsList.remove(tags[i]);
                        }
                        setState(() {
                          //print(tagsList);
                        });
                        print(tagsList);
                      },
                      title: tags[i],
                      selected: tagsList.contains(tags[i]
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class TagContainer extends StatelessWidget {
  final Function onTap;
  final bool selected;
  final String title;
  const TagContainer({
    Key? key,
    required this.selected,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 1,
        ),
        decoration: BoxDecoration(
          color: selected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(48),
          border: Border.all(color: primaryColor, width: 1),
        ),
        child: Center(
          child: Text(selected ? title :  title,
              style:styleSatoshiRegular(size: 12, color:selected ?Colors.white: Colors.black),
        ),
      ),
    ),);
  }
}