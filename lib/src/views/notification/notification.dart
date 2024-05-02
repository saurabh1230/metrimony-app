import 'package:bureau_couple/src/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../constants/textstyles.dart';
import '../../utils/widgets/common_widgets.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> selectedItems = [];
  bool allImagesSelected = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: backButton(
              context: context,
              image: icArrowLeft,
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        title: Text("Notification",
          style: styleSatoshiBold(size: 22, color: Colors.black),
        ),
        actions: [

          const SizedBox(width: 5,),
          selectedItems.isNotEmpty ?
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (allImagesSelected) {
                          selectedItems.clear();
                        } else {
                          selectedItems.addAll(name);
                        }
                        allImagesSelected = !allImagesSelected;
                      });

                    },
                    child: Image.asset(icSelectAll,height: 24,
                      width: 24,)),
                    const Icon(Icons.delete),
              ],
            ),
          ) :
            const SizedBox(),
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (_,i) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onLongPress: () {
                    if (selectedItems.isEmpty) {
                      setState(() {
                        selectedItems.add(name[i]);
                      });
                    }
                  },
                  onTap: () {
                    if (selectedItems.isEmpty) {

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             selectedItems()));
                    } else {
                      if (selectedItems.contains(name[i])) {
                        setState(() {
                          selectedItems.remove(name[i]);
                        });
                      } else {
                        setState(() {
                          selectedItems.add(name[i]);
                        });
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 0.5,
                        color: selectedItems.contains(name[i])
                            ? Colors.red
                            : Colors.grey
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 50,
                            clipBehavior: Clip.hardEdge,
                            decoration : const BoxDecoration(
                            shape: BoxShape.circle,
                              ),
                            child: Image.asset(icDemoProfile,
                            ),
                          ),
                        ),
                        Expanded(
                          flex:3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jessica s",
                                style: styleSatoshiMedium(size: 16, color: primaryColor),),
                              Text("Sent you Connection request",
                              style: styleSatoshiMedium(size: 12, color: color828282),),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text("5 min ago",
                            style: styleSatoshiMedium(size: 12, color: color828282),),
                        ),
                      ],
                    ),
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),)

            ],
          ),
        ),
      ),
    );
  }
}
