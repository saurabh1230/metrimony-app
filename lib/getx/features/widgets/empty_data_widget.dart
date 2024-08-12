import 'package:bureau_couple/getx/utils/assets.dart';
import 'package:bureau_couple/getx/utils/colors.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class EmptyDataWidget extends StatelessWidget {
  final String? title;
  const EmptyDataWidget({super.key,  this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16, top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                    noMatchesHolder,
                    height: 100,
                  )),
              sizedBox16(),
               Center(
                  child: Text(title ?? "No Saved Matches Yet!")),
              sizedBox16(),
              connectWithoutIconButton(
                  context: context,
                  onTap: () {
                    Get.back();
                  },
                  title: " Go back",
                  iconWidget: const Icon(
                    Icons.arrow_back,
                    color: primaryColor,
                  ))
            ],
          ),
        ));
  }
}
