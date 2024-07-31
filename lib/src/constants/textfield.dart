

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'fonts.dart';

textBoxSuffixIcon({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required String hint,
  required int? length,
  Widget? suffixIcon,
  Function()? suffixOnTap,
  required bool,
  required void Function(String)? onChanged,
  required String? Function(String?)? validator,
  Iterable<String>? string,
}) {
  return TextFormField(
    obscureText:bool,
    autofillHints: string,
    controller: controller,
    decoration: InputDecoration(
        suffixIcon: GestureDetector(
            onTap:suffixOnTap ?? null,
            child: suffixIcon ?? SizedBox()),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16,
            horizontal: 5),
        enabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.redAccent,
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
        ),
        hintText: hint,
        hintStyle: kManrope16MediumBlack.copyWith(color: Colors.black.withOpacity(0.70)),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
        )),
    onChanged: onChanged,
    validator: validator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    inputFormatters: length != null ? [LengthLimitingTextInputFormatter(10)] : [],
  );
}

textBoxPickerField({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required String hint,
  required int? length,
  required IconData icon,
  Widget? suffixIcon,
  Function()? onTap,
  required void Function(String)? onChanged,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    onTap: onTap,
    readOnly:  true,
    controller: controller,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
        suffixIcon:  Icon(icon),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16,
            horizontal: 5),
        enabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: lightGrey.withOpacity(0.30),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.redAccent,
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: lightGrey.withOpacity(0.30),
          ),
        ),
        hintText: hint,
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: lightGrey.withOpacity(0.30),
          ),
        )),
    onChanged: onChanged,
    validator: validator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    inputFormatters: length != null ? [LengthLimitingTextInputFormatter(10)] : [],
  );
}
textBox({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required String hint,
  required int? length,
  required String? Function(String?)? validator,
  required void Function(String)? onChanged,
  Iterable<String>? string,
  double ? radius,
  TextCapitalization? capital,
  bool? read,
  Function()? tap,

}) {
  return TextFormField(
    readOnly:read ?? false,
    onTap: tap,
    autofillHints: string,
    textInputAction: TextInputAction.next,
    controller: controller,
    textCapitalization:capital ?? TextCapitalization.none,
    decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16,
            horizontal: 5),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ??10)),
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
        ),
        errorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ??10)),
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.redAccent,
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ??10)),
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
        ),
        hintText: hint,
        hintStyle: kManrope16MediumBlack.copyWith(color: Colors.black.withOpacity(0.70)),

        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ??10)),
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
        )),
    validator: validator,
    onChanged: onChanged,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    inputFormatters:  [LengthLimitingTextInputFormatter(length ?? 30)],
  );
}

textBoxPrefixIcon({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required String hint,
  required int? length,
  required String? Function(String?)? validator,
  required void Function(String)? onChanged,
}) {
  return TextFormField(
    keyboardType: TextInputType.number,
    controller: controller,
    decoration: InputDecoration(
        prefixIcon: GestureDetector(
          onTap: () {},
          child: Container(
            height: 24,
            width: 24,
            child: Center(
              child: Text("+91",
                style: kManrope14Regular4F4F4F,),
            ),
          ),),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16,
            horizontal: 5),
        enabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: lightGrey.withOpacity(0.30),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.redAccent,
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: lightGrey.withOpacity(0.30),
          ),
        ),
        hintText: hint,
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: lightGrey.withOpacity(0.30),
          ),
        )),
    onChanged: onChanged,
    validator: validator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    inputFormatters: length != null ? [LengthLimitingTextInputFormatter(10)] : [],
  );
}

textBoxPreIcon({
  required BuildContext context,
  required String label,
  required String img,
  required TextEditingController controller,
  required String hint,
  required int? length,
  required String? Function(String?)? validator,
  required void Function(String)? onChanged,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        prefixIcon: GestureDetector(
          onTap: () {},
          child: Container(
            height: 16,
            width: 16,
            padding: EdgeInsets.all(12),
            child: Image.asset(img),
          ),),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16,
            horizontal: 5),
        enabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: lightGrey.withOpacity(0.30),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.redAccent,
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: lightGrey.withOpacity(0.30),
          ),
        ),
        hintText: hint,
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.5,
            color: lightGrey.withOpacity(0.30),
          ),
        )),
    onChanged: onChanged,
    validator: validator,
    autovalidateMode: AutovalidateMode.onUserInteraction,

  );
}
//
// pickerTextBox({
//   required BuildContext context,
//   required String label,
//   required String suffixIcon,
//   required TextEditingController controller,
//   required String hint,
//   required int? length,
//   required Function() click,
//   required String? Function(String?)? validator,
// }) {
//   return TextFormField(
//     controller: controller,
//     readOnly: true,
//     onTap: click,
//
//     decoration: InputDecoration(
//         suffixIcon: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//             onTap: click,
//
//             child: SvgPicture.asset(
//                 suffixIcon,
//                 height: 16.0,
//                 color: defaultColor),
//           ),
//         ),
//         enabledBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(
//             width: 1,
//             color: lightGrey,
//           ),
//         ),
//         errorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(
//             width: 1,
//             color: defaultColor,
//           ),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(
//             width: 1,
//             color: lightGrey,
//           ),
//         ),
//         labelText: hint,
//         focusedErrorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(
//             width: 1,
//             color: lightGrey,
//           ),
//         )),
//     onChanged: (value) {
//       controller.value = TextEditingValue(text: value, selection: TextSelection(baseOffset: value.length, extentOffset: value.length));
//       // controller.value = value.trim() as TextEditingValue;
//     },
//     validator: validator,
//     autovalidateMode: AutovalidateMode.onUserInteraction,
//     inputFormatters: length != null ? [LengthLimitingTextInputFormatter(10)] : [],
//   );
// }
//
//
// underLineFieldSimple({
//   required BuildContext context,
//   required String label,
//   required TextEditingController controller,
//   required String hint,
//   required int? length,
//   required String? Function(String?)? validator,
// }) {
//   return TextFormField(
//     controller: controller,
//     decoration: InputDecoration(
//       enabledBorder: const UnderlineInputBorder(
//         borderSide: BorderSide(color: lightGrey),
//       ),
//       errorBorder: const UnderlineInputBorder(
//         borderSide: BorderSide(color: defaultColor),
//       ),
//       focusedBorder: const UnderlineInputBorder(
//         borderSide: BorderSide(color: lightGrey),
//       ),
//       focusedErrorBorder: const UnderlineInputBorder(
//         borderSide: BorderSide(color: lightGrey),
//       ),
//       hintText: hint,
//       hintStyle: styleInterRegular(
//         size: 14,
//         color: colorDarkGrey,
//       ),
//     ),
//     onChanged: (value) {
//       controller.value = TextEditingValue(
//         text: value,
//         selection: TextSelection(
//           baseOffset: value.length,
//           extentOffset: value.length,
//         ),
//       );
//     },
//     validator: validator,
//     autovalidateMode: AutovalidateMode.onUserInteraction,
//     inputFormatters: length != null ? [LengthLimitingTextInputFormatter(10)] : [],
//   );
// }
//
//
// whiteTextBox({
//   required BuildContext context,
//   required String label,
//   required TextEditingController controller,
//   required String hint,
//   required int? length,
//   required String? Function(String?)? validator,
// }) {
//   return Container(
//     color: Colors.white,
//     child: TextFormField(
//       controller: controller,
//       maxLines: 3,
//       decoration: InputDecoration(
//         hintStyle: styleInterThin(size: 13,
//             color: Colors.grey),
//         labelStyle: styleInterThin(size: 13,
//             color: Colors.grey),
//         contentPadding: EdgeInsets.symmetric(horizontal: 5),
//         fillColor: Colors.white,
//         hintText: hint,
//         border: InputBorder.none, // Remove border
//         focusedBorder: InputBorder.none, // Remove focused border
//         enabledBorder: InputBorder.none, // Remove enabled border
//         errorBorder: InputBorder.none, // Remove error border
//         focusedErrorBorder: InputBorder.none, // Remove focused error border
//       ),
//       onChanged: (value) {
//         controller.value = TextEditingValue(
//           text: value,
//           selection: TextSelection(baseOffset: value.length, extentOffset: value.length),
//         );
//       },
//       validator: validator,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       inputFormatters: length != null ? [LengthLimitingTextInputFormatter(10)] : [],
//     ),
//   );
//
// }
//
//
//
// class DropdownFieldBox extends StatefulWidget {
//   final BuildContext context;
//   final String label;
//   final TextEditingController controller;
//   final int? length;
//   final String? Function(String?)? validator;
//   final VoidCallback? onTap;
//
//   const DropdownFieldBox({
//     Key? key,
//     required this.context,
//     required this.label,
//     required this.controller,
//     required this.length,
//     required this.validator,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   State<DropdownFieldBox> createState() => _DropdownFieldBoxState();
// }
//
// class _DropdownFieldBoxState extends State<DropdownFieldBox> {
//   bool isDropdownOpen = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       readOnly: true,
//       onTap: () {
//         widget.onTap!();
//         isDropdownOpen = !isDropdownOpen;
//       },
//       decoration: InputDecoration(
//         suffixIcon: GestureDetector(
//           onTap: () {
//             widget.onTap!();
//           },
//           child: Icon(
//             isDropdownOpen ?
//             Icons.arrow_drop_up_outlined :
//             Icons.arrow_drop_down,
//           ),
//         ),
//         enabledBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(
//             width: 1,
//             color: Colors.grey, // Assuming lightGrey is defined somewhere
//           ),
//         ),
//         errorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(
//             width: 1,
//             color: Colors.red, // Assuming defaultColor is defined somewhere
//           ),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(
//             width: 1,
//             color: Colors.grey, // Assuming lightGrey is defined somewhere
//           ),
//         ),
//         labelText: widget.label,
//         labelStyle: const TextStyle(
//           fontSize: 14,
//           color: Colors.black,
//         ),
//         focusedErrorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           borderSide: BorderSide(
//             width: 1,
//             color: Colors.grey, // Assuming lightGrey is defined somewhere
//           ),
//         ),
//       ),
//       onChanged: (value) {
//         widget.controller.value = TextEditingValue(
//           text: value,
//           selection: TextSelection(
//             baseOffset: value.length,
//             extentOffset: value.length,
//           ),
//         );
//       },
//       validator: widget.validator,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       inputFormatters: widget.length != null ? [LengthLimitingTextInputFormatter(10)] : [],
//     );
//   }
// }
//
//
//
//
//
//
// styleInterThin({required double size, required Color color}) {
//   return TextStyle(fontSize: size, color: color, fontFamily: InterThin,
//   );
// }
// styleInterBlack({required double size, required Color color}) {
//   return TextStyle(fontSize: size, color: color, fontFamily: InterBlack);
// }
//
// styleInterBold({required double size, required Color color}) {
//   return TextStyle(fontSize: size, color: color, fontFamily: InterBold, fontWeight: FontWeight.bold);
// }
//
// styleInterExtraBold({required double size, required Color color}) {
//   return TextStyle(fontSize: size, color: color, fontFamily: InterExtraBold, fontWeight: FontWeight.bold);
// }
//
// styleInterExtraLite({required double size, required Color color}) {
//   return TextStyle(fontSize: size, color: color, fontFamily: InterExtraLight);
// }
//
// styleInterMedium({required double size, required Color color}) {
//   return TextStyle(fontSize: size, color: color, fontFamily: InterMedium);
// }
//
// styleInterRegular({required double? size, required Color color}) {
//   return TextStyle(fontSize: size ?? null, color: color, fontFamily: InterRegular, fontWeight: FontWeight.w400);
// }
//
// styleInterSemiBold({required double size, required Color color}) {
//   return TextStyle(fontSize: size, color: color, fontFamily: InterSemiBold);
// }
//
//
//
//
// // class DropDownFieldBox extends StatefulWidget {
// //   final BuildContext context;
// //   final String label;
// //   final TextEditingController controller;
// //   final Function() click;
// //   final int? length;
// //   final String? Function(String?)? validator;
// //
// //   const DropDownFieldBox({
// //     Key? key,
// //     required this.context,
// //     required this.label,
// //     required this.controller,
// //     this.length,
// //     this.validator,
// //     required this.click,
// //   }) : super(key: key);
// //
// //   @override
// //   _DropDownFieldBoxState createState() => _DropDownFieldBoxState();
// // }
// //
// // class _DropDownFieldBoxState extends State<DropDownFieldBox> {
// //   bool isDropdownOpen = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return TextFormField(
// //       controller: widget.controller,
// //       readOnly: true,
// //       onTap: () {
// //
// //         widget.click();
// //         setState(() {
// //           isDropdownOpen = !isDropdownOpen;
// //         });
// //       },
// //       decoration: InputDecoration(
// //           suffixIcon: GestureDetector(
// //             onTap: () {
// //               setState(() {
// //                 isDropdownOpen = !isDropdownOpen;
// //               });
// //             },
// //             child: Icon(isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
// //           ),
// //           enabledBorder: const OutlineInputBorder(
// //             borderRadius: BorderRadius.all(Radius.circular(4)),
// //             borderSide: BorderSide(
// //               width: 1,
// //               color: lightGrey,
// //             ),
// //           ),
// //           errorBorder: const OutlineInputBorder(
// //             borderRadius: BorderRadius.all(Radius.circular(4)),
// //             borderSide: BorderSide(
// //               width: 1,
// //               color: defaultColor,
// //             ),
// //           ),
// //           focusedBorder: const OutlineInputBorder(
// //             borderRadius: BorderRadius.all(Radius.circular(4)),
// //             borderSide: BorderSide(
// //               width: 1,
// //               color: lightGrey,
// //             ),
// //           ),
// //           labelText: widget.label,
// //           labelStyle: styleInterThin(size: 14,
// //               color: Colors.black),
// //           focusedErrorBorder: const OutlineInputBorder(
// //             borderRadius: BorderRadius.all(Radius.circular(4)),
// //             borderSide: BorderSide(
// //               width: 1,
// //               color: lightGrey,
// //             ),
// //           )),
// //       onChanged: (value) {
// //         setState(() {
// //           widget.controller.value = TextEditingValue(text: value, selection: TextSelection(baseOffset: value.length, extentOffset: value.length));
// //         });
// //       },
// //       validator: widget.validator,
// //       autovalidateMode: AutovalidateMode.onUserInteraction,
// //       inputFormatters: widget.length != null ? [LengthLimitingTextInputFormatter(widget.length!)] : [],
// //     );
// //   }
// // }
//
//
// class CustomDropDown extends StatefulWidget {
//   final String label;
//   final int listCount;
//   final Function(String) onItemSelected; // Change parameter name
//   final List<String> dataList;
//   final TextEditingController textFieldController; // TextField controller
//
//   const CustomDropDown({
//     Key? key,
//     required this.label,
//     required this.listCount,
//     required this.onItemSelected, // Change parameter name
//     required this.dataList,
//     required this.textFieldController, // TextField controller
//   }) : super(key: key);
//
//   @override
//   State<CustomDropDown> createState() => _CustomDropDownState();
// }
//
// class _CustomDropDownState extends State<CustomDropDown> {
//   bool isDropdownOpen = false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         DropdownFieldBox(
//           context: context,
//           label: widget.label,
//           controller: widget.textFieldController, // Pass the TextField controller
//           length: null,
//           validator: (val) {
//             return null;
//           },
//           onTap: () {
//             setState(() {
//               isDropdownOpen = !isDropdownOpen;
//             });
//           },
//         ),
//         isDropdownOpen
//             ? customCard(
//           context: context,
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: widget.listCount,
//             itemBuilder: (_, i) {
//               return AnimatedContainer(
//                 padding: const EdgeInsets.all(16),
//                 duration: const Duration(microseconds: 800),
//                 child: GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     setState(() {
//                       isDropdownOpen =false;
//                     });
//                     widget.onItemSelected(widget.dataList[i]); // Call onItemSelected
//                   },
//                   child: Text(
//                     widget.dataList[i],
//                     style: styleInterExtraLite(
//                       size: 14,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         )
//             : const SizedBox(),
//       ],
//     );
//   }
// }
//
//
//
// labelTextField({
//   required BuildContext context,
//   required String label,
//   required TextEditingController controller,
//   required int? length,
//   required String? Function(String?)? validator,
// }) {
//   return TextFormField(
//     controller:controller,
//     decoration: InputDecoration(
//       enabledBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         borderSide: BorderSide(
//           width: 1,
//           color: Colors.grey, // Assuming lightGrey is defined somewhere
//         ),
//       ),
//       errorBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         borderSide: BorderSide(
//           width: 1,
//           color: Colors.red, // Assuming defaultColor is defined somewhere
//         ),
//       ),
//       focusedBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         borderSide: BorderSide(
//           width: 1,
//           color: Colors.grey, // Assuming lightGrey is defined somewhere
//         ),
//       ),
//       labelText: label,
//       labelStyle: const TextStyle(
//         fontSize: 14,
//         color: Colors.black,
//       ),
//       focusedErrorBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//         borderSide: BorderSide(
//           width: 1,
//           color: Colors.grey, // Assuming lightGrey is defined somewhere
//         ),
//       ),
//     ),
//     onChanged: (value) {
//       controller.value = TextEditingValue(
//         text: value,
//         selection: TextSelection(
//           baseOffset: value.length,
//           extentOffset: value.length,
//         ),
//       );
//     },
//     validator: validator,
//     autovalidateMode: AutovalidateMode.onUserInteraction,
//     inputFormatters: length != null ? [LengthLimitingTextInputFormatter(10)] : [],
//   );
// }