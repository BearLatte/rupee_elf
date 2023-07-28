import 'package:flutter/material.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/util/global.dart';

class AuthBaseWidget extends StatelessWidget {
  final String titlel;
  final int totalStep;
  final int currentStep;
  final Widget Function(BuildContext) contentBuilder;

  const AuthBaseWidget(
    this.titlel, {
    super.key,
    required this.totalStep,
    required this.currentStep,
    required this.contentBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              titlel,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Global.themeTextColor,
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 10.0)),
            Text(
              '$currentStep',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Global.themeColor,
              ),
            ),
            Text(
              '/$totalStep',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Global.themeTextColor,
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
            color: Global.themeTextColor,
          ),
        ),
      ),
      body: contentBuilder(context),
    );
  }
}
