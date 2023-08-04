import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/hexcolor.dart';

class HomeMenuItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function() onTap;

  const HomeMenuItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonImage(src: iconPath),
          const Padding(padding: EdgeInsets.only(bottom: 4.0)),
          Text(
            title,
            style: TextStyle(color: HexColor('#333333'), fontSize: 14.0),
          )
        ],
      ),
    );
  }
}
