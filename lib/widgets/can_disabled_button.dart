import 'package:flutter/material.dart';

class CanDisableButton extends StatelessWidget {
  final bool isDisabled;
  final String title;
  final ValueChanged<bool>? onTap;
  final bool isCircle;
  final bool isNotPadding;
  final double fontSize;
  final Color textColor;

  const CanDisableButton({
    super.key,
    required this.title,
    this.isDisabled = true,
    this.onTap,
    this.fontSize = 14.0,
    this.isCircle = false,
    this.isNotPadding = false,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: isCircle
              ? MaterialStateProperty.all(
                  const CircleBorder(
                    side: BorderSide(color: Colors.transparent),
                  ),
                )
              : null,
          padding:
              isNotPadding ? MaterialStateProperty.all(EdgeInsets.zero) : null),
      onPressed: isDisabled
          ? null
          : () {
              onTap!(false);
            },
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }
}
