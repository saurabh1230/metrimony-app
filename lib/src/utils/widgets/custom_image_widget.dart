import 'package:bureau_couple/src/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const CustomImageWidget({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover,});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image, height: height, width: width, fit: fit,
      placeholder: (context, url) => Image.asset(icProfilePlaceHolder, height: height, width: width, fit: fit),
      errorWidget: (context, url, error) => Image.asset(icProfilePlaceHolder,height: height, width: width, fit: fit),
    );
  }
}
