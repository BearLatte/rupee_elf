import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/models/login_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/adjust_track_tool.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/widgets/count_down_button.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isChecked = true;
  var defaultTextStyle =
      TextStyle(fontSize: 14.0, color: Constants.themeTextColor);
  var richTextStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: Constants.themeColor);

  late TapGestureRecognizer _tapCondition;
  late TapGestureRecognizer _tapPolicy;

  bool _isShowBoder = false;

  FocusNode? _phoneFocusNode = FocusNode();

  bool _isShowCodeWidget = false;

  String currentPhoneNumber = '';
  String currentSmsCode = '';

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

  void _phoneInputFieldValueChenged(String phoneNumber) {
    setState(() {
      if (phoneNumber.isNotEmpty) {
        _isShowBoder = true;
      } else {
        _isShowBoder = false;
      }
    });

    if (phoneNumber.length == 10) {
      _phoneFocusNode?.unfocus();
    }

    currentPhoneNumber = phoneNumber;
  }

  void _codeInputFieldValuechanged(String code) {
    currentSmsCode = code;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return HiddenKeyboardWrapper(
      child: Scaffold(
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
                        colors: [Constants.themeColor, Colors.white],
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

            // 内容滚动视图
            Positioned(
              top: 110.0,
              left: 0,
              width: screenWidth,
              height: screenHeight - 110,
              child: ListView(
                padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
                children: [
                  const CommonImage(src: 'static/images/login_in_img.png'),
                  _loginPageContentWidget(),
                  const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  _policyWidget()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 内容区域
  Widget _loginPageContentWidget() {
    return Container(
      width: 335,
      height: 430.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 30.0)),
          Text(
            'Mobile number',
            style: TextStyle(color: Constants.themeTextColor, fontSize: 20),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10.0)),
          Container(
            width: 300.0,
            height: 52.0,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Constants.boxBackgroundColor,
              border: Border.all(
                  color:
                      _isShowBoder ? Constants.themeColor : Colors.transparent,
                  width: 1.0),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 52.0,
                  height: 52.0,
                  decoration: BoxDecoration(
                    color: Constants.themeColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: const CommonImage(
                      src: 'static/icons/login_phone_icon.png'),
                ),
                const Padding(padding: EdgeInsets.only(right: 10.0)),
                Expanded(
                  child: TextField(
                    focusNode: _phoneFocusNode,
                    style: TextStyle(
                        color: Constants.themeTextColor, fontSize: 20.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Mobile number',
                      hintStyle: TextStyle(
                          color: Constants.seconaryTextColor, fontSize: 20),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    onChanged: _phoneInputFieldValueChenged,
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 30.0)),
          CountDownButton(
            countDownValue: 60,
            session: 'login_view',
            text: 'Get OTP',
            fontSize: 16.0,
            textColor: Colors.white,
            width: 68.0,
            height: 68.0,
            isCircle: true,
            isNotPadding: true,
            onTap: countDownButtonClicked,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 16.0)),
          if (_isShowCodeWidget)
            Text(
              'One-time-Password',
              style: TextStyle(
                fontSize: 20,
                color: Constants.themeTextColor,
              ),
            ),
          if (_isShowCodeWidget)
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: PinCodeTextField(
                onTap: () {
                  ADJustTrackTool.trackWith('ovbicn');
                },
                length: 6,
                appContext: context,
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: Constants.themeTextColor,
                ),
                cursorColor: Constants.themeColor,
                onChanged: _codeInputFieldValuechanged,
                pinTheme: PinTheme(
                  fieldWidth: 44.0,
                  fieldHeight: 52.0,
                  shape: PinCodeFieldShape.box,
                  activeColor: Constants.themeColor,
                  inactiveColor: Constants.boxBackgroundColor,
                  activeFillColor: Constants.themeColor,
                  activeBorderWidth: 1.0,
                  selectedColor: Constants.themeColor,
                  selectedBorderWidth: 1.0,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
            ),
          ThemeButton(
            width: 252.0,
            height: 52.0,
            title: 'Login now',
            onPressed: () {
              onLogin(context);
            },
          )
        ],
      ),
    );
  }

  // 底部协议视图
  Widget _policyWidget() {
    return Center(
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
    );
  }

  void countDownButtonClicked(CountDownButtonState state) async {
    ADJustTrackTool.trackWith('fkk3qc');
    if (currentPhoneNumber.length < 10) {
      await CommonToast.showToast('Please enter a 10-digit mobile number');
      return;
    }

    NetworkService.sendSms(currentPhoneNumber, () {
      state.startTimer();
      setState(() {
        _isShowCodeWidget = true;
      });
    });
  }

  void onLogin(BuildContext context) async {
    if (currentPhoneNumber.length < 10) {
      await CommonToast.showToast('Please enter a 10-digit mobile number');
      return;
    }

    if (currentSmsCode.isEmpty) {
      await CommonToast.showToast('Please enter OTP');
      return;
    }

    ADJustTrackTool.trackWith('qjcgnq');

    // 发送登录请求
    LoginModel model =
        await NetworkService.login(currentPhoneNumber, currentSmsCode);

    if (model.rkmectsultCode == 0) {
      await CommonToast.showToast(model.rkmectsultMsg);
      return;
    }

    if (model.ikmsctRegistered == 1) {
      debugPrint('DEBUG: 注册，此处需要做埋点');
    }

    // 保存登录数据
    Global.instance.isLogin = true;
    Global.instance.prefs.setBool(Constants.LOGIN_KEY, true);
    Global.instance.prefs.setString(Constants.TOKEN_KEY, model.lkmoctginToken);
    Global.instance.prefs
        .setString(Constants.CURRENT_PHONE_KEY, currentPhoneNumber);

    if (context.mounted) {
      Navigator.of(context).pop('successed');
    }
  }

  @override
  void dispose() {
    _tapCondition.dispose();
    _tapPolicy.dispose();
    _phoneFocusNode?.dispose();
    _phoneFocusNode = null;
    super.dispose();
  }
}
