
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DeleteAccountDialog extends StatelessWidget {
  final String heading;
  final String subheading;
  final String titleButton1;
  final Function() click1;
  final Function() click2;
  final Widget mainButton;

  const DeleteAccountDialog({
    Key? key,
    required this.heading,
    required this.subheading,
    required this.titleButton1,
    required this.click1,
    required this.click2,
    required this.mainButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                heading,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                subheading,
              ),
              SizedBox(
                height: 44.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: elevatedButton(
                      height: 38,
                      color: Colors.white,
                      context: context,
                      onTap: click2,
                      title: titleButton1,
                      style: styleSatoshiLight(size: 14, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: mainButton,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
