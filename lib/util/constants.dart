// ignore_for_file: constant_identifier_names

import 'dart:ui';
import 'package:rupee_elf/util/hexcolor.dart';

class Constants {
  // 颜色值
  static Color themeColor = HexColor('#F05C09');
  static Color themeTextColor = HexColor('#333333');
  static Color seconaryTextColor = HexColor('#999999');
  static Color borderColor = HexColor('#DDDDDD');
  static Color boxBackgroundColor = HexColor('#EFEFEF');
  static Color dividerColor = HexColor('#EAEAEA');
  static Color arrowColor = HexColor('#9e9e9e');
  static Color seconaryBackgroundColor = HexColor('#F5F4F3');

  // 常量
  static const String TOKEN_KEY = 'kACCESS_TOKEN';
  static const String LOGIN_KEY = 'kLOGIN_KEY';
  static const String CURRENT_PHONE_KEY = 'kCURRENT_PHONE_KEY';
  /// 苹果应用商店审核账号，上线前需要填写
  static const String APP_STORE_AUDIT_ACCOUNT = '';
}
