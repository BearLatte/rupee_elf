import 'package:flutter/material.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';

class BaseViewWidget extends StatelessWidget {
  final String title;
  final Widget? child;
  final bool showBackButton;

  const BaseViewWidget(
      {super.key, required this.title, this.child, this.showBackButton = true});

  Widget? backButton(BuildContext context) {
    if (showBackButton) {
      return IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(IconFont.icon_back));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HiddenKeyboardWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: backButton(context),
        ),
        body: child,
        backgroundColor: Global.themeColor,
      ),
    );
  }
}
