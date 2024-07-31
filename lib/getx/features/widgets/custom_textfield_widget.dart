import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/dimensions.dart';
import '../../utils/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixImage;
  final IconData? prefixIcon;
  final bool divider;
  final bool showTitle;
  final bool isAmount;
  final bool isNumber;
  final bool isPhone;
  final String? countryDialCode;
  final bool showBorder;
  final double iconSize;
  final bool isRequired;
  final bool readOnly;
  final Function()? onTap;
  final FormFieldValidator<String>? validation;
  final String? label; // New parameter
  final int? maximumInput; // New parameter
  final Color? fillColor;
  final Color? hintColor;

  const CustomTextField({
    Key? key,
    this.hintText = 'Write something...',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSubmit,
    this.onChanged,
    this.prefixImage,
    this.prefixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.divider = false,
    this.showTitle = false,
    this.isAmount = false,
    this.isNumber = false,
    this.isPhone = false,
    this.countryDialCode,
    this.showBorder = true,
    this.iconSize = 18,
    this.isRequired = false,
    this.readOnly = false,
    this.onTap,
    this.validation,
    this.label, // Initialize new parameter
    this.maximumInput, this.fillColor, this.hintColor, // Initialize new parameter
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showTitle
            ? Text(
          widget.hintText,
          style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12),
        )
            : const SizedBox(),
        SizedBox(height: widget.showTitle ? Dimensions.paddingSize5 : 0),
        widget.label != null // Add conditional rendering for label
            ? Text(
          widget.label!,
          style: satoshiRegular.copyWith(fontSize: Dimensions.fontSize12),
        )
            : const SizedBox(),
        TextFormField(
          readOnly: widget.readOnly,
          validator: widget.validation,
          onTap: widget.onTap,
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: satoshiRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
          textInputAction: widget.inputAction,
          keyboardType: widget.isAmount ? TextInputType.number : widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          autofillHints: widget.inputType == TextInputType.name
              ? [AutofillHints.name]
              : widget.inputType == TextInputType.emailAddress
              ? [AutofillHints.email]
              : widget.inputType == TextInputType.phone
              ? [AutofillHints.telephoneNumber]
              : widget.inputType == TextInputType.streetAddress
              ? [AutofillHints.fullStreetAddress]
              : widget.inputType == TextInputType.url
              ? [AutofillHints.url]
              : widget.inputType == TextInputType.visiblePassword
              ? [AutofillHints.password]
              : null,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: [
            if (widget.inputType == TextInputType.phone)
              FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
            if (widget.isAmount)
              FilteringTextInputFormatter.allow(RegExp(r'\d')),
            if (widget.isNumber)
              FilteringTextInputFormatter.allow(RegExp(r'\d')),
            if (widget.isNumber)
              LengthLimitingTextInputFormatter(10),
            if (widget.maximumInput != null)
              LengthLimitingTextInputFormatter(widget.maximumInput!), // Set maximum input length
          ],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius5),
              borderSide: BorderSide(
                style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                width: 0.3,
                color: Theme.of(context).primaryColorDark.withOpacity(0.80),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius5),
              borderSide: BorderSide(
                style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius5),
              borderSide: BorderSide(
                style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                width: 0.3,
                color: Theme.of(context).primaryColorDark.withOpacity(0.80),
              ),
            ),
            isDense: true,
            hintText: widget.hintText,
            fillColor: widget.fillColor ?? Theme.of(context).cardColor,
            hintStyle: satoshiRegular.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: widget.hintColor ?? Theme.of(context).hintColor,
            ),
            filled: true,
            prefixIcon: widget.isPhone
                ? SizedBox(
              width: 95,
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 2,
                    color: Theme.of(context).disabledColor,
                  )
                ],
              ),
            )
                : widget.prefixImage != null && widget.prefixIcon == null
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
              child: Image.asset(widget.prefixImage!, height: 20, width: 20),
            )
                : widget.prefixImage == null && widget.prefixIcon != null
                ? Icon(widget.prefixIcon, size: widget.iconSize)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: widget.hintColor ?? Theme.of(context).hintColor.withOpacity(0.3),
              ),
              onPressed: _toggle,
            )
                : null,
          ),
          onChanged: widget.onChanged as void Function(String)?,
        ),
        widget.divider ? const Divider() : const SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}