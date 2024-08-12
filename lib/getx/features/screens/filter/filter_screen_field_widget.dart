import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterScreenField extends StatelessWidget {
  final Function() tap;
  final String title;
  final String data;
  const FilterScreenField({
    super.key, required this.tap, required this.title, required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: tap,
      child: Column(
          children : [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: kManrope16MediumBlack.copyWith(
                      fontSize: Dimensions.fontSize14,
                      color: Theme.of(context).disabledColor.withOpacity(0.99)),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(data,
                          style: kManrope16MediumBlack),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ],
            ),
            Divider(thickness: 1,color: Theme.of(context).disabledColor,),
          ]
      ),
    );
  }
}