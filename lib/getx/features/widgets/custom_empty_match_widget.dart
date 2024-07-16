import 'package:bureau_couple/getx/utils/assets.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:flutter/material.dart';

class CustomEmptyMatchScreen extends StatelessWidget {
  final String? title;
  final bool? isBackButton;
  const CustomEmptyMatchScreen({super.key, this.title,  this.isBackButton = false});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16,top: 100),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(noMatchesHolder,height: 100,)),
          sizedBox16(),
           Center(child: Text(title ??"No Match Found Yet!")),
          sizedBox16(),
          if (isBackButton!) const SizedBox() else connectWithoutIconButton(context: context, onTap: () {
            Navigator.pop(context);
          }, title: " Go back",iconWidget: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,))
        ],
      ),
    );
  }
}
