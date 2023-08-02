import 'package:rupee_elf/util/global.dart';

class NetworkConfig {
  static NetworkConfig? _instance;

  NetworkConfig._internal() {
    _instance = this;
  }

  static get instance => _instance ?? NetworkConfig._internal();

  String baseUrl = 'https://api.newapisys.com/';
  int connectTimeout = 15000;
  int successCode = 200;

  get headers {
    Map<String, String?> headers = {};
    headers['lang']  = 'en';
    headers['token'] = Global.prefs?.getString(Global.TOKEN_KEY);

    Map<String, String?> deviceInfo = {};
    deviceInfo['appVersion'] = Global.packageInfo.version;
    deviceInfo['bag'] = Global.packageInfo.packageName;
    deviceInfo['brand'] = 'Apple';
    deviceInfo['channel'] = 'App Store';
    deviceInfo['deviceModel'] = Global.allDeviceInfo.model;
    deviceInfo['mac'] = '';
    deviceInfo['operationSys'] = 'iOS';
    deviceInfo['osVersion'] = Global.allDeviceInfo.systemVersion;
    deviceInfo['androidIdOrUdid'] = Global.allDeviceInfo.identifierForVendor;
    deviceInfo['gaidOrIdfa'] = Global.idfa;
    return headers;
  }
}
