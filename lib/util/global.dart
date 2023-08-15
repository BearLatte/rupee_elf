import 'dart:math';
import 'package:advertising_id/advertising_id.dart';
import 'package:connection_network_type/connection_network_type.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static get instance {
    _instance ??= Global._internal();
    return _instance;
  }

  static Global? _instance;

  Global._internal();

  /// 是否已经登录
  late bool isLogin;

  /// 唯一广告定位串
  late String idfa;

  // 当前登录账号
  late String currentAccount;

  /// 所有设备信息
  late IosDeviceInfo allDeviceInfo;

  /// 包信息
  late PackageInfo packageInfo;
  // 本地存储 对象
  late SharedPreferences prefs;

  Future<void> initConstants() async {
    // 初始化 userdefaults
    prefs = await SharedPreferences.getInstance();
    // 获取安装包信息
    packageInfo = await PackageInfo.fromPlatform();
    // 获取设备信息
    allDeviceInfo = await DeviceInfoPlugin().iosInfo;

    // 请求 idfa
    var status = await Permission.appTrackingTransparency.request();
    if (status == PermissionStatus.granted) {
      String idfaString = await AdvertisingId.id() ?? '';
      idfa = idfaString == '00000000-0000-0000-0000-000000000000'
          ? ''
          : idfaString;
      prefs.setString('kIDFA_KEY', idfa);
    } else {
      idfa = prefs.getString('kIDFA_KEY') ?? '';
    }

    // 获取是否已经登录
    isLogin = prefs.getBool(Constants.LOGIN_KEY) ?? false;
    currentAccount = prefs.getString(Constants.CURRENT_PHONE_KEY) ?? '';
  }

  // 获取网络状态
  Future<String> getNetworkType() async {
    final networkType = await ConnectionNetworkType().currentNetworkStatus();
    switch (networkType) {
      case NetworkStatus.wifi:
        return 'wifi';
      case NetworkStatus.mobile2G:
        return '2G';
      case NetworkStatus.mobile3G:
        return '3G';
      case NetworkStatus.mobile4G:
        return '4G';
      case NetworkStatus.mobile5G:
        return '5G';
      case NetworkStatus.otherMobile:
        return 'other';
      default:
        return 'none';
    }
  }

  // 清除信息
  void clearLocalInfo() {
    isLogin = false;
    prefs.setBool(Constants.LOGIN_KEY, false);
    prefs.remove(Constants.TOKEN_KEY);
  }

  Color randomColor = Color.fromARGB(255, Random().nextInt(256) + 0,
      Random().nextInt(256) + 0, Random().nextInt(256) + 0);
}
