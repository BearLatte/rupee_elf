import 'dart:math';
import 'package:advertising_id/advertising_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static final Global _instance = Global._internal();

  factory Global() => _instance;

  Global._internal() {}

  static const bool isLogin = true;
  static const bool isCerified = true;
  static const String currentAccount = '';

  static late String idfa;
  static late IosDeviceInfo? allDeviceInfo;
  static late PackageInfo? packageInfo;


  static Color randomColor = Color.fromARGB(255, Random().nextInt(256) + 0,
      Random().nextInt(256) + 0, Random().nextInt(256) + 0);

  // 本地存储
  static SharedPreferences? prefs;

  static initConstants() async {
    // 初始化 userdefaults
    prefs ??= await SharedPreferences.getInstance();

    // 获取安装包信息
    packageInfo ??= await PackageInfo.fromPlatform();
    // 获取设备信息
    allDeviceInfo ??= await DeviceInfoPlugin().iosInfo;

    // 请求 idfa
    var status = await Permission.appTrackingTransparency.request();
    if (status == PermissionStatus.granted) {
      String idfaString = await AdvertisingId.id() ?? '';
      idfa = idfaString == '00000000-0000-0000-0000-000000000000'
          ? ''
          : idfaString;
      prefs?.setString('kIDFA_KEY', idfa);
    } else {
      idfa = prefs?.getString('kIDFA_KEY') ?? '';
    }

    await NetworkService.firstLaunch();
  }
}
