import 'package:bureau_couple/getx/utils/assets.dart';
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String placeholder;
  final double? radius;
  const CustomNetworkImageWidget({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = '', this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200,
      width:width?? Get.size.width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Dimensions.radius20)
      ),
      child: CachedNetworkImage(
        imageUrl: image, height: height, width: width, fit: fit,
        placeholder: (context, url) => Image.asset(placeholder.isNotEmpty ? placeholder: icLogo, fit: fit),
        errorWidget: (context, url, error) => Image.asset(placeholder.isNotEmpty ? placeholder  : icLogo, fit: fit),
      ),
    );
  }
}
