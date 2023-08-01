import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  // 常量
  static const bool isLogin = true;
  static const bool isCerified = true;
  static const String currentAccount = '';
  static late final Map<String, dynamic> allDeviceInfo;
  static late final PackageInfo packageInfo;

  // 颜色值
  static Color themeColor = HexColor('#F05C09');
  static Color themeTextColor = HexColor('#333333');
  static Color seconaryTextColor = HexColor('#999999');
  static Color borderColor = HexColor('#DDDDDD');
  static Color boxBackgroundColor = HexColor('#EFEFEF');
  static Color dividerColor = HexColor('#EAEAEA');
  static Color arrowColor = HexColor('#9e9e9e');
  static Color randomColor = Color.fromARGB(255, Random().nextInt(256) + 0,
      Random().nextInt(256) + 0, Random().nextInt(256) + 0);

  // 本地存储
  static SharedPreferences? prefs;

  static initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static initConstants() async {
    var deviceInfo = await DeviceInfoPlugin().iosInfo;
    allDeviceInfo = deviceInfo.data;

    packageInfo = await PackageInfo.fromPlatform();
  }
}
