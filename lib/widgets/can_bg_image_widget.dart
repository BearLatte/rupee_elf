import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';

class CanBgImageWidget extends StatelessWidget {
  final String icon;
  final String title;
  final double width;
  final double height;
  final String? backgroundImage;
  final void Function()? onTap;

  const CanBgImageWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.width,
    required this.height,
    this.backgroundImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width,
            height: height,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: backgroundImage == null ? Global.themeColor : null,
              borderRadius: BorderRadius.circular(20),
            ),
            child: backgroundImage != null
                ? CommonImage(src: backgroundImage!, fit: BoxFit.cover)
                : null,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonImage(src: icon),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Text(
                title,
                style: const TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
