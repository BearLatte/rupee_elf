import 'dart:convert';

import 'package:rupee_elf/util/global.dart';

class HttpOptions {
  static HttpOptions? _instance;

  HttpOptions._internal() {
    _instance = this;
  }

  static get instance => _instance ?? HttpOptions._internal();

  String baseUrl = 'https://api.newapisys.com/';
  int connectTimeout = 1500;
  int receiveTimeout = 1500;
  int sendTimeout = 1500;
  get headers {
    Map<String, String?> headers = {};
    headers['lang'] = 'en';
    headers['token'] = Global.prefs?.getString(Global.TOKEN_KEY);

    Map<String, String?> deviceInfo = {};
    deviceInfo['appVersion'] = Global.packageInfo.version;
    deviceInfo['bag'] = Global.packageInfo.packageName;
    deviceInfo['brand'] = 'Apple';
    deviceInfo['channel'] = 'App Store';
    deviceInfo['deviceModel'] = Global.allDeviceInfo.name;
    deviceInfo['mac'] = '';
    deviceInfo['operationSys'] = 'iOS';
    deviceInfo['osVersion'] = Global.allDeviceInfo.systemVersion;
    deviceInfo['androidIdOrUdid'] = Global.allDeviceInfo.identifierForVendor;
    deviceInfo['gaidOrIdfa'] = Global.idfa;
    headers['deviceInfo'] = jsonEncode(deviceInfo);
    return headers;
  }
}
