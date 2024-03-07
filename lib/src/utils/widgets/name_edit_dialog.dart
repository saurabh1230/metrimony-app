
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class NameEditDialogWidget extends StatelessWidget {
  final String title;
  final Widget addTextField;
  const NameEditDialogWidget({
    Key? key,
    required this.title,
    required this.addTextField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              SizedBox(height: 10.h),
              addTextField,

              SizedBox(height: 20.h),

            ],
          ),
        ),
      ),
    );
  }
}


class EditDialogWidget extends StatelessWidget {
  // final String title;
  final Widget addTextField;
  const EditDialogWidget({
    Key? key,
    // required this.title,
    required this.addTextField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

             /* Text(
                title,
              ),*/
              SizedBox(height: 16.h),
              addTextField,

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
