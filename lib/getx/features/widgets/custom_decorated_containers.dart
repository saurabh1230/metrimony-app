import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDecoratedContainers extends StatelessWidget {
  final Widget child;
  const CustomDecoratedContainers({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5,color: Colors.black.withOpacity(0.50)),
        color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radius10),
      ),
      child: child,
    );
  }
}
