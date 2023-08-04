import 'package:dio/dio.dart';
import 'package:rupee_elf/models/login_model.dart';
import 'package:rupee_elf/models/product_list_model.dart';
import 'package:rupee_elf/network/index.dart';
import 'package:rupee_elf/util/md5_util.dart';
import 'package:rupee_elf/util/random_util.dart';

class NetworkService {
  /// first launch
  static firstLaunch() async {
    await _defaultService(path: '/cLqgPJf/jNSuDf');
  }

  // login
  static Future<LoginModel> login(String phone, String code) async {
    var params = {'userPhone': phone, 'loginCode': code};
    var json =
        await _defaultService(path: '/cLqgPJf/HJKfYM', parameters: params);
    return LoginModel.fromJson(json);
  }

  // 登录前首页列表
  static Future<ProductListModel> getProductList() async {
    var result = await _defaultService(path: '/cLqgPJf/JvLpx');
    return ProductListModel.fromJson(result);
  }

  static Future<dynamic> _defaultService({
    required String path,
    Map<String, dynamic>? parameters,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) async {
    var formData = FormData.fromMap(_configParameters(parameters));

    return await HttpUtils.post(
      path: path,
      data: formData,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
  }

  static Map<String, dynamic> _configParameters(
      Map<String, dynamic>? parameters) {
    Map<String, dynamic> newParams;

    if (parameters == null) {
      newParams = {'nYYonYcestr': RandomUtil.generateRandomString(30)};
    } else {
      newParams = Map.from(parameters);
      newParams['nYYonYcestr'] = RandomUtil.generateRandomString(30);
    }

    String signKey = '&signKey=iYeXsbQTefsNWaAyFSDRBnkb';
    String keyString = _sortedMapWith(newParams) + signKey;
    newParams['rYYeqYSign'] = MD5Util.md5String(keyString);
    return newParams;
  }

  static String _sortedMapWith(Map<String, dynamic> params) {
    List<String> allKeys = params.keys.toList();
    allKeys.sort(
        (left, right) => left.toLowerCase().compareTo(right.toLowerCase()));

    var mapString = '';
    for (int i = 0; i < allKeys.length; i++) {
      String key = allKeys[i];
      String value = params[key];

      if (i == 0) {
        mapString = '$key=$value';
      } else {
        mapString = '$mapString&$key=$value';
      }
    }
    return mapString;
  }
}
