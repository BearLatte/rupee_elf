import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/auth_base_widget.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';

class AuthThirdPage extends StatelessWidget {
  const AuthThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBaseWidget(
      'My authentication',
      isShowTrailingButton: true,
      totalStep: 4,
      currentStep: 3,
      trailingOnPressed: () {
        debugPrint('DEBUG: 添加按钮点击');
      },
      contentBuilder: (context) {
        return HiddenKeyboardWrapper(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: ListView(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonImage(src: 'static/icons/auth_horn_icon.png'),
                      const Padding(padding: EdgeInsets.only(right: 10.0)),
                      Expanded(
                        child: Text(
                          'The richer the information, the easier to obtain loans.',
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Global.seconaryTextColor,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
