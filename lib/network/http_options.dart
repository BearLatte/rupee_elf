import 'dart:convert';

import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/global.dart';

class HttpOptions {
  static HttpOptions? _instance;

  HttpOptions._internal() {
    _instance = this;
  }

  static get instance => _instance ?? HttpOptions._internal();

  // String baseUrl = 'https://api.newapisys.com/';
  String baseUrl = 'http://8.215.46.156:1360';
  int connectTimeout = 15000;
  int receiveTimeout = 15000;
  int sendTimeout = 15000;
  get headers {
    Map<String, String?> headers = {};
    headers['lang'] = 'en';
    headers['token'] = Global.instance.prefs.getString(Constants.TOKEN_KEY);

    Map<String, String?> deviceInfo = {};
    deviceInfo['appVersion'] = Global.instance.packageInfo?.version;
    deviceInfo['bag'] = Global.instance.packageInfo?.packageName;
    deviceInfo['brand'] = 'Apple';
    deviceInfo['channel'] = 'App Store';
    deviceInfo['deviceModel'] = Global.instance.allDeviceInfo?.name;
    deviceInfo['mac'] = '';
    deviceInfo['operationSys'] = 'iOS';
    deviceInfo['osVersion'] = Global.instance.allDeviceInfo?.systemVersion;
    deviceInfo['androidIdOrUdid'] =
        Global.instance.allDeviceInfo?.identifierForVendor;
    deviceInfo['gaidOrIdfa'] = Global.instance.idfa;
    headers['deviceInfo'] = jsonEncode(deviceInfo);
    return headers;
  }
}
