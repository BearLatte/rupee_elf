import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

class SimpleToastPage extends StatelessWidget {
  const SimpleToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ThemeButton(
        width: 252.0,
        height: 52.0,
        title: 'I already Know',
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Global.seconaryBackgroundColor,
        title: Text(
          'Photo Tips',
          style: TextStyle(color: Global.themeTextColor),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(IconFont.icon_back),
            color: Global.themeTextColor),
      ),
      body: Container(
        color: Global.seconaryBackgroundColor,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 38.0, right: 38.0, top: 44.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Unusable',
                style: TextStyle(
                  color: HexColor('#FF4732'),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16.0)),
            errorSimpleWidget('Card shall not outside the frame.'),
            errorSimpleWidget('Photo shall not be blurred.'),
            errorSimpleWidget('No reflection light on it.'),
            const Padding(padding: EdgeInsets.only(top: 35.0)),
            const CommonImage(
              src: 'static/images/auth_simple_img.png',
              fit: BoxFit.fill,
            ),
            Center(
              child: Text(
                'Please ensure the whole cotent involved and words clear.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Global.themeTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget errorSimpleWidget(String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CommonImage(src: 'static/icons/auth_error_icon.png'),
          const Padding(padding: EdgeInsets.only(right: 18.0)),
          Text(
            text,
            style: TextStyle(fontSize: 16.0, color: Global.themeTextColor),
          )
        ],
      ),
    );
  }
}
