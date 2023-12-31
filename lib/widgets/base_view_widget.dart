import 'package:flutter/material.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';

class BaseViewWidget extends StatelessWidget {
  final String title;
  final Widget? child;
  final bool showBackButton;
  final Function()? backButtonAction;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const BaseViewWidget({
    super.key,
    required this.title,
    this.child,
    this.showBackButton = true,
    this.backButtonAction,
    this.floatingActionButton,
    this.actions,
  });

  Widget? backButton(BuildContext context) {
    if (showBackButton) {
      return IconButton(
          onPressed: () {
            if (backButtonAction != null) {
              backButtonAction!();
            }
            Navigator.of(context).pop();
          },
          icon: const Icon(
            IconFont.icon_back,
            size: 16.0,
          ));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HiddenKeyboardWrapper(
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButton != null
            ? FloatingActionButtonLocation.centerFloat
            : null,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: backButton(context),
          actions: actions,
        ),
        body: child,
        backgroundColor: Constants.themeColor,
      ),
    );
  }
}
