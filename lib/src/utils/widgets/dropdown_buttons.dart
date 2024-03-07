import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomStyledDropdownButton extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;

  const CustomStyledDropdownButton({
    Key? key,
    required this.items,
    required this.onChanged,
    this.selectedValue, required this.title,
  }) : super(key: key);

  @override
  _CustomStyledDropdownButtonState createState() => _CustomStyledDropdownButtonState();
}

class _CustomStyledDropdownButtonState extends State<CustomStyledDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint:  Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: styleSatoshiRegular(size: 14, color: Colors.black),
              ),
            ),
          ],
        ),
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: styleSatoshiLight(size: 14, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ))
            .toList(),
        value: widget.selectedValue,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.white,
          ),
          elevation: 1,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 1.sw,
          width: 300.sw,
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
      ),
    );
  }
}


