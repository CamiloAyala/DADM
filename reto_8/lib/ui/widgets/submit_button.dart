// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:reto_8/utils/constraints.dart' as constraints;

class SubmitButton extends StatelessWidget {

  final String text;
  final Function()? onPressed;
  final Color textColor;
  final Color buttonColor;
  final bool? withSuffixIcon;
  final Widget? suffixIcon;

  const SubmitButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.textColor,
    required this.buttonColor,
    this.withSuffixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(constraints.btnRadius),
        ),
        textStyle: TextStyle(
          color: textColor,
          fontFamily: "Lato",
          fontSize: constraints.btnFontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Ink(
        child: Container(
          width: double.infinity,
          height: constraints.btnHeight,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontFamily: "Lato",
                  fontSize: constraints.btnFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (withSuffixIcon != null && withSuffixIcon == true)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: suffixIcon,
                ),
            ],
          ),
          ),
        ),
    );
  }
}