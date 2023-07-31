import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

enum AlertType { tips, succesed, error }

class CommonAlert {
  static Future<bool> showAlert({
    required BuildContext context,
    required AlertType type,
    String? message,
  }) async {
    switch (type) {
      case AlertType.error:
        return _showErrorAlert(context, message);
      case AlertType.succesed:
        return _showSuccessedAlert(context, message);
      case AlertType.tips:
        return await _showTipsAlert(context, message);
    }
  }
}

Future<bool> _showErrorAlert(BuildContext context, String? message) async {
  return await showCupertinoDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CommonImage(src: 'static/icons/alert_error_icon.png'),
                  const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  if (message != null)
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Global.themeTextColor, fontSize: 16.0),
                    ),
                  const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ThemeButton(
                        width: 130.0,
                        height: 52.0,
                        title: 'Cancel',
                        backgroundColor: HexColor('#F3925B'),
                        onPressed: () {
                          Navigator.of(context).pop('cancel');
                        },
                      ),
                      ThemeButton(
                        width: 130.0,
                        height: 52.0,
                        title: 'Ok',
                        onPressed: () {
                          Navigator.of(context).pop('ok');
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ) ==
      'ok';
}

Future<bool> _showSuccessedAlert(BuildContext context, String? message) async {
  return await showCupertinoDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 78.0, left: 20.0, bottom: 20.0, right: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (message != null)
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Global.themeTextColor, fontSize: 16.0),
                        ),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      ThemeButton(
                        width: 140.0,
                        height: 52.0,
                        title: 'Ok',
                        onPressed: () {
                          Navigator.of(context).pop('ok');
                        },
                      )
                    ],
                  ),
                ),
                const Positioned(
                  top: -66.0,
                  child:
                      CommonImage(src: 'static/icons/alert_successed_icon.png'),
                )
              ],
            ),
          );
        },
      ) ==
      'ok';
}

Future<bool> _showTipsAlert(BuildContext context, String? message) async {
  var response = await showCupertinoDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 43.0,
                bottom: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (message != null)
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Global.themeTextColor, fontSize: 16.0),
                    ),
                  const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ThemeButton(
                        width: 130.0,
                        height: 52.0,
                        title: 'Cancel',
                        backgroundColor: HexColor('#F3925B'),
                        onPressed: () {
                          Navigator.of(context).pop('cancel');
                        },
                      ),
                      ThemeButton(
                        width: 130.0,
                        height: 52.0,
                        title: 'Ok',
                        onPressed: () {
                          Navigator.of(context).pop('ok');
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            const Positioned(
                top: -36.0,
                child: CommonImage(src: 'static/icons/alert_tips_icon.png'))
          ],
        ),
      );
    },
  );

  return response == 'ok';
}