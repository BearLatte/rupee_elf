import 'package:flutter/material.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

class AuthBaseWidget extends StatelessWidget {
  final String titlel;
  final int totalStep;
  final int currentStep;
  final String? nextStepText;
  final bool isShowTrailingButton;
  final void Function()? nextStepOnPressed;
  final void Function()? trailingOnPressed;
  final Widget Function(BuildContext) contentBuilder;

  const AuthBaseWidget(
    this.titlel, {
    super.key,
    required this.totalStep,
    required this.currentStep,
    required this.contentBuilder,
    this.nextStepText,
    this.nextStepOnPressed,
    this.trailingOnPressed,
    this.isShowTrailingButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: nextStepOnPressed != null
          ? ThemeButton(
              width: 252.0,
              height: 52.0,
              title: nextStepText ?? '',
              onPressed: nextStepOnPressed == null ? () {} : nextStepOnPressed!,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              titlel,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Constants.themeTextColor,
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 10.0)),
            Text(
              '$currentStep',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Constants.themeColor,
              ),
            ),
            Text(
              '/$totalStep',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Constants.themeTextColor,
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            IconFont.icon_back,
            color: Constants.themeTextColor,
          ),
        ),
        actions: isShowTrailingButton
            ? [
                IconButton(
                  onPressed: trailingOnPressed,
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Constants.themeTextColor,
                  ),
                )
              ]
            : null,
      ),
      body: contentBuilder(context),
    );
  }
}
