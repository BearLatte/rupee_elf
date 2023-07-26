import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/iconfont.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isChecked = true;
  var defaultTextStyle =
      TextStyle(fontSize: 14.0, color: Global.themeTextColor);
  var richTextStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: Global.themeColor);

  late TapGestureRecognizer _tapCondition;
  late TapGestureRecognizer _tapPolicy;

  @override
  void initState() {
    super.initState();
    _tapCondition = TapGestureRecognizer()
      ..onTap = () {
        debugPrint('点击了Terms & Conditions');
      };

    _tapPolicy = TapGestureRecognizer()
      ..onTap = () {
        debugPrint('点击了Policy');
      };
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // 背景
          Column(
            children: [
              CommonImage(
                src: 'static/images/login_top_img.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Global.themeColor, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              )
            ],
          ),
          // 内容
          Positioned(
            // 返回箭头按钮
            top: 60.0,
            left: 12.0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                IconFont.icon_back,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            // title
            top: 60,
            height: 44,
            width: screenWidth,
            child: const Center(
              child: Text(
                'My authentication',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            // 中间图片
            top: 230.0,
            width: screenWidth,
            child: const Center(
              child: CommonImage(
                src: 'static/images/login_in_img.png',
              ),
            ),
          ),
          Positioned(
            // 内容区域
            top: 300,
            left: 20,
            width: screenWidth - 40,
            child: Container(
              width: 335,
              height: 430.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: const Center(
                child: Text('测试文字'),
              ),
            ),
          ),
          Positioned(
            // 底部协议控件
            bottom: 30.0,
            width: screenWidth - 70,
            left: 35.0,
            child: Center(
              child: Row(
                children: [
                  if (!isChecked)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: const CommonImage(
                          src: 'static/icons/login_checkbox_normal_icon.png'),
                    ),
                  if (isChecked)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: const CommonImage(
                          src: 'static/icons/login_checkbox_selected_icon.png'),
                    ),
                  Expanded(
                      child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'By continuing you agree our ',
                            style: defaultTextStyle),
                        TextSpan(
                            text: 'Terms & Conditions ',
                            style: richTextStyle,
                            recognizer: _tapCondition),
                        TextSpan(text: 'and ', style: defaultTextStyle),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: richTextStyle,
                            recognizer: _tapPolicy),
                        TextSpan(text: '.', style: defaultTextStyle),
                      ],
                    ),
                    maxLines: 2,
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tapCondition.dispose();
    _tapPolicy.dispose();
    super.dispose();
  }
}
