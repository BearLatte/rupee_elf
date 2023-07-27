import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const ThemeButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Text(title,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
    );
  }
}
