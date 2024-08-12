import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:flutter/material.dart';
class EditDetailsTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function()? onTap;
  final bool? isNonEditable;
  final bool readOnly;

  const EditDetailsTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.onTap,
    this.readOnly = false, this.isNonEditable = false, // Default value for readOnly is false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${title}',
              style: satoshiLight.copyWith(fontSize: 12),
            ),
            isNonEditable! ?
            Text(
              '  [non editable]' ,
              style: satoshiLight.copyWith(fontSize: 12,color: Colors.redAccent),
            ) : SizedBox()
          ],
        ),
        TextFormField(
          controller: controller,
          onTap: onTap, // onTap is optional
          readOnly: readOnly, // Conditional readOnly behavior
          decoration: InputDecoration(
            hintText: title,
            labelStyle: satoshiLight,
            enabledBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColorDark.withOpacity(0.80)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
