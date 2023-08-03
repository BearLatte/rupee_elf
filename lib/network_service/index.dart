import 'package:dio/dio.dart';
import 'package:rupee_elf/network/index.dart';
import 'package:rupee_elf/util/md5_util.dart';
import 'package:rupee_elf/util/random_util.dart';

class NetworkService {
  /// first launch
  static firstLaunch() async {
    await _defaultService(path: '/cLqgPJf/jNSuDf');
  }

  /// login
  // static login() async {
  //   HttpUtils.post(path: path)
  // }

  static Future<dynamic> _defaultService(
      {required String path, Map<String, dynamic>? parameters}) async {
    var formData = FormData.fromMap(_configParameters(parameters));
    return await HttpUtils.post(
      path: path,
      data: formData,
      showLoading: true,
      showErrorMessage: true,
    );
  }

  static Map<String, dynamic> _configParameters(
      Map<String, dynamic>? parameters) {
    Map<String, dynamic> newParams;

    if (parameters == null) {
      newParams = {'noncestr': RandomUtil.generateRandomString(30)};
    } else {
      newParams = Map.from(parameters);
      newParams['noncestr'] = RandomUtil.generateRandomString(30);
    }

    String signKey = '&signKey=iYeXsbQTefsNWaAyFSDRBnkb';
    String keyString = _sortedMapWith(newParams) + signKey;
    newParams['sign'] = MD5Util.md5String(keyString);
    return newParams;
  }

  static String _sortedMapWith(Map<String, dynamic> params) {
    List<String> allKeys = params.keys.toList();
    allKeys.sort(
        (left, right) => left.toLowerCase().compareTo(right.toLowerCase()));

    Map<String, dynamic> newMap = {};
    for (var key in allKeys) {
      newMap[key] = params[key];
    }

    return newMap.toString();
  }
}
