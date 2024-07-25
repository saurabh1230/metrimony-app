import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';


class CustomStyledDropdownButton extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomStyledDropdownButton({
    Key? key,
    required this.items,
    required this.onChanged,
    this.selectedValue, required this.title, this.validator,
  }) : super(key: key);

  @override
  _CustomStyledDropdownButtonState createState() => _CustomStyledDropdownButtonState();
}

class _CustomStyledDropdownButtonState extends State<CustomStyledDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      validator: widget.validator,
      decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 16,
              horizontal: 5),
          enabledBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              width: 0.5,
              color: lightGrey.withOpacity(0.30),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              width: 0.5,
              color: Colors.redAccent,
            ),
          ),

          focusedBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              width: 0.5,
              color: lightGrey.withOpacity(0.30),
            ),
          ),
          hintText: widget.title,
          focusedErrorBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              width: 0.5,
              color: lightGrey.withOpacity(0.30),
            ),
          )),
      hint:  Text(
        widget.title,
        style: styleSatoshiRegular(size: 14, color: Colors.black),
      ),
      items: widget.items
          .map((String item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: styleSatoshiLight(size: 14, color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
      )).toList(),
      value: widget.selectedValue,
      onChanged: widget.onChanged,
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
        ),
        iconSize: 20,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        // padding: EdgeInsets.symmetric(horizontal: 16),
        maxHeight: 1.sw,
        // width: 300.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        offset: const Offset(-20, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    );
    // return DropdownButtonHideUnderline(
    //   child: DropdownButton2<String>(
    //     isExpanded: true,
    //     hint:  Row(
    //       children: [
    //         Expanded(
    //           child: Text(
    //             widget.title,
    //             style: styleSatoshiRegular(size: 14, color: Colors.black),
    //           ),
    //         ),
    //       ],
    //     ),
    //     items: widget.items
    //         .map((String item) => DropdownMenuItem<String>(
    //       value: item,
    //       child: Text(
    //         item,
    //         style: styleSatoshiLight(size: 14, color: Colors.black),
    //         overflow: TextOverflow.ellipsis,
    //       ),
    //     ))
    //         .toList(),
    //     value: widget.selectedValue,
    //     onChanged: widget.onChanged,
    //     buttonStyleData: ButtonStyleData(
    //       height: 50,
    //       width: 160,
    //       padding: const EdgeInsets.only(left: 14, right: 14),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(14),
    //         border: Border.all(
    //           color: Colors.black26,
    //         ),
    //         color: Colors.white,
    //       ),
    //       elevation: 1,
    //     ),
    //     iconStyleData: const IconStyleData(
    //       icon: Icon(
    //         Icons.arrow_drop_down,
    //       ),
    //       iconSize: 14,
    //       iconEnabledColor: Colors.black,
    //       iconDisabledColor: Colors.grey,
    //     ),
    //     dropdownStyleData: DropdownStyleData(
    //       maxHeight: 1.sw,
    //       width: 300.sw,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(14),
    //         color: Colors.white,
    //       ),
    //       offset: const Offset(-20, 0),
    //       scrollbarTheme: ScrollbarThemeData(
    //         radius: const Radius.circular(40),
    //         thickness: MaterialStateProperty.all(6),
    //         thumbVisibility: MaterialStateProperty.all(true),
    //       ),
    //     ),
    //     menuItemStyleData: const MenuItemStyleData(
    //       height: 40,
    //       padding: EdgeInsets.only(left: 14, right: 14),
    //     ),
    //   ),
    // );
  }
}


