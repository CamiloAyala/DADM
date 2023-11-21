// Flutter imports:
import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double padding;
  final bool disabled;
  final String? initialValue;

  final Function(String)? onChanged;
  final TextInputType textType;

  const EntryField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.padding,
    this.disabled = false,
    this.initialValue,
    this.onChanged,
    this.textType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build (BuildContext context){
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: padding),
        child: TextFormField(
            obscureText: isPassword,
            keyboardType: textType,
            onChanged: onChanged,
            readOnly: disabled,
            initialValue: initialValue,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: "Lato",
              fontWeight: FontWeight.w700
            ),
            decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: labelText,
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            contentPadding: const EdgeInsets.only(top: 2),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: "Lato",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: "Lato",
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)
            ),
          ),
        )
      ),
    );
  }

}