
import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:flutter/material.dart';



class CustomButtonWidget extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final bool isLoading;
  final bool isBold;
  final Color? fontColor;
  const CustomButtonWidget({super.key, this.onPressed, required this.buttonText, this.transparent = false, this.margin, this.width, this.height,
    this.fontSize, this.radius = 10, this.icon, this.color, this.textColor, this.isLoading = false, this.isBold = true, this.fontColor, });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null ? Theme.of(context).disabledColor : transparent
          ? Colors.transparent : color ?? Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width! : Dimensions.webMaxWidth, height != null ? height! : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: Theme.of(context).primaryColor, // Specify the color of the border
          width: 1, // Specify the width of the border
        ),
      ),
    );

    return Center(child: SizedBox(width: width ?? Dimensions.webMaxWidth, child: Padding(
      padding: margin == null ? const EdgeInsets.all(0) : margin!,
      child: TextButton(
        onPressed: isLoading ? null : onPressed as void Function()?,
        style: flatButtonStyle,
        child: isLoading ? Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 15, width: 15,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2,
            ),
          ),
          const SizedBox(width: Dimensions.paddingSize10),

          Text('Loading', style: satoshiMedium.copyWith(color: Colors.white)),
        ]),
        ) : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null ? Padding(
            padding:  const EdgeInsets.only(right: 0),
            child: Icon(icon, color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor,size: Dimensions.fontSizeDefault,),
          ) : const SizedBox(),
          sizedBoxW5(),

          Text(buttonText, textAlign: TextAlign.center,  style: isBold ? satoshiBold.copyWith(
            color: textColor ?? (transparent ? Theme.of(context).primaryColor : fontColor ?? Colors.white),
            fontSize: fontSize ?? Dimensions.fontSize18,
          ) : satoshiRegular.copyWith(
            color: textColor ?? (transparent ? Theme.of(context).primaryColor : fontColor ??  Colors.white),
            fontSize: fontSize ?? Dimensions.fontSize18,
          )
          ),

        ]),
      ),
    )));
  }
}



// class CustomIconButtonWidget extends StatelessWidget {
//   final Function? onPressed;
//   final String buttonText;
//   final bool transparent;
//   final EdgeInsets? margin;
//   final double? height;
//   final double? width;
//   final double? fontSize;
//   final double radius;
//   final IconData? icon;
//   final Color? color;
//   final Color? textColor;
//   final bool isLoading;
//   final bool isBold;
//   final Color? borderColor;
//   const CustomIconButtonWidget({super.key, this.onPressed, required this.buttonText, this.transparent = false, this.margin, this.width, this.height,
//     this.fontSize, this.radius = 10, this.icon, this.color, this.textColor, this.isLoading = false, this.isBold = true, this.borderColor, });
//
//   @override
//   Widget build(BuildContext context) {
//     final ButtonStyle flatButtonStyle = TextButton.styleFrom(
//       backgroundColor: onPressed == null ? Theme.of(context).disabledColor : transparent
//           ? Colors.transparent : color ?? Theme.of(context).primaryColor,
//       minimumSize: Size(width != null ? width! : Dimensions.webMaxWidth, height != null ? height! : 50),
//       padding: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(radius),
//         side: BorderSide(
//           color:borderColor ?? Colors.transparent, // Specify the color of the border
//           width: 1, // Specify the width of the border
//         ),
//       ),
//     );
//
//     return Center(child: SizedBox(width: width ?? Dimensions.webMaxWidth, child: Padding(
//       padding: margin == null ? const EdgeInsets.all(0) : margin!,
//       child: TextButton(
//         onPressed: isLoading ? null : onPressed as void Function()?,
//         style: flatButtonStyle,
//         child: isLoading ? Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           const SizedBox(
//             height: 15, width: 15,
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               strokeWidth: 2,
//             ),
//           ),
//           const SizedBox(width: Dimensions.paddingSize10),
//
//           Text('Loading', style: nunitoSansMedium.copyWith(color: Colors.white)),
//         ]),
//         ) : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Text(buttonText, textAlign: TextAlign.center,  style: isBold ? nunitoSansBold.copyWith(
//             color: textColor ?? (transparent ? Theme.of(context).primaryColor : Colors.white),
//             fontSize: fontSize ?? Dimensions.fontSize16,
//           ) : nunitoSansRegular.copyWith(
//             color: textColor ?? (transparent ? Theme.of(context).primaryColor : Colors.white),
//             fontSize: fontSize ?? Dimensions.fontSize16,
//           )
//           ),
//           icon != null ? Padding(
//             padding:  const EdgeInsets.only(left: Dimensions.paddingSize5),
//             child: Icon(icon, color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor,size: Dimensions.fontSize16,),
//           ) : const SizedBox(),
//         ]),
//       ),
//     )));
//   }
// }










// class CustomIconButton extends StatelessWidget {
//   final Color? color;
//   final Color? borderColor;
//   final double? height;
//   final double? width;
//   final String icon;
//   final Color? iconColor;
//   final Function() tap;
//   const CustomIconButton({super.key, this.color,  this.height,  this.width, required this.icon, this.iconColor, this.borderColor, required this.tap, });
//
//   @override
//   Widget build(BuildContext context) {
//     return  InkWell(
//       onTap: tap,
//       child: Container(
//         width: width ?? 50, // Adjust the width as needed
//         height:  height ?? 50, //
//         clipBehavior: Clip.hardEdge,
//         decoration: BoxDecoration(
//             color: color ?? Theme.of(context).primaryColor,
//             border: Border.all(
//               width: 0.5,
//               color: borderColor ?? Theme.of(context).primaryColor,
//             ),
//             borderRadius: BorderRadius.circular(Dimensions.paddingSize5)
//         ),
//         // Adjust the height as needed
//         child: Center(
//           child:SvgPicture.asset(icon,fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(iconColor ?? Theme.of(context).cardColor, BlendMode.srcIn),
//           ),
//         ),
//       ),
//     );
//   }
// }
