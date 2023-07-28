import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double width;
  final double height;

  const ThemeButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = 0,
    this.height = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }
}
