import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:bureau_couple/getx/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String hintText;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const CustomDropdownButtonFormField({
    Key? key,
    required this.value,
    required this.items,
    required this.hintText,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      borderRadius: BorderRadius.circular(Dimensions.radius15),
      value: value,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius5),
          borderSide: BorderSide(
            style: BorderStyle.solid ,
            width: 0.3,
            color: Theme.of(context).primaryColorDark.withOpacity(0.80),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius5),
          borderSide: BorderSide(
            style: BorderStyle.solid ,
            width: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius5),
          borderSide: BorderSide(
            style:  BorderStyle.solid,
            width: 0.3,
            color: Theme.of(context).primaryColorDark.withOpacity(0.80),
          ),
        ),
      ),
      hint: Text(hintText,style: satoshiRegular.copyWith(
        fontSize: Dimensions.fontSizeDefault,
        color: Theme.of(context).hintColor,
      ),),
      validator: validator,
    );
  }
}
