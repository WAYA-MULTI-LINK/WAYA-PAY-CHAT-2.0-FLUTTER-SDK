import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextField extends StatelessWidget {
  final Widget? suffix;
  final String? labelText;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String? initialValue;
  final double? inputWidth;
  final bool? obscureText;
  final TextInputType? textInputType;

  const BaseTextField({
    Key? key,
    this.suffix,
    this.labelText,
    this.hintText,
    this.inputFormatters,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.inputWidth,
    this.obscureText = false, this.textInputType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: width * 0.05),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: const BorderRadius.all(
          Radius.zero,
        ),
      ),
      child:  TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        onSaved: onSaved,
        validator: validator,
        obscureText: obscureText!,
        maxLines: 1,
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType:textInputType??TextInputType.number,
        decoration: InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(vertical: (inputWidth ?? width * 0.04), horizontal: height*0.007),
          border: InputBorder.none,
          labelText: labelText,
          hintText: hintText,
          labelStyle:  TextStyle(color: Colors.grey, fontSize: (height * width) * 0.000035),
          suffixIcon: suffix == null
              ? null
              : Padding(
            padding:  EdgeInsetsDirectional.only(end: width*0.001),
            child: suffix,
          ),
          errorStyle: const TextStyle(height: 0,fontSize: 0),
          isDense: true,

        ),
      ),
    );

  }
}
