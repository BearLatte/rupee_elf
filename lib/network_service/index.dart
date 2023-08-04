import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/empty_network_result.dart';
import 'package:rupee_elf/models/login_model.dart';
import 'package:rupee_elf/models/product_list_model.dart';
import 'package:rupee_elf/models/user_info_model.dart';
import 'package:rupee_elf/network/index.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/md5_util.dart';
import 'package:rupee_elf/util/navigator_key.dart';
import 'package:rupee_elf/util/random_util.dart';

class NetworkService {
  /// first launch
  static firstLaunch() async {
    await _defaultService(path: '/cLqgPJf/jNSuDf');
  }

  // 发送短信验证啊
  static sendSms(String userPhone, Function() success) async {
    var result = await _defaultService(
        path: '/cLqgPJf/aBqgqj', parameters: {'uYYseYrPhone': userPhone});
    var model = EmptyNetworkResult.fromJson(result);
    if (model.rkmectsultCode == 1) {
      success();
    }
  }

  // login
  static Future<LoginModel> login(String phone, String code) async {
    var params = {'uYYseYrPhone': phone, 'lYYogYinCode': code};
    var json =
        await _defaultService(path: '/cLqgPJf/dHbqEa', parameters: params);
    return LoginModel.fromJson(json);
  }

  // 登录前首页列表
  static Future<ProductListModel> getProductList() async {
    var result = await _defaultService(path: '/cLqgPJf/JvLpx');
    return ProductListModel.fromJson(result);
  }

  // 获取用户信息, 此接口中含推荐产品的模型
  static Future<UserInfoModel?> getUserInfo({String isRecommend = '0'}) async {
    var result = await _defaultService(
      path: '/cLqgPJf/tuVg/eQmnX',
      parameters: {'iYYsYRecommend': isRecommend},
    );
    UserInfoModel model = UserInfoModel.fromJson(result);
    return await _configNetworkError(model);
  }

  static logout(Function() success) async {
    var result = await _defaultService(path: '/cLqgPJf/HJKfYM');
    var model = BaseModel.fromJson(result);
    if(model.rkmectsultCode == 1) {
      success();
    }
  }

  static Future<T?> _configNetworkError<T extends BaseModel>(T model) async {
    if (model.rkmectsultCode == 1) {
      return model;
    }

    if (model.rkmectsultCode == -1) {
      // 去登录页面
      BuildContext? context = NavigatorKey.navKey.currentState?.context;
      if (context != null) {
        await Navigator.of(context).pushNamed('/login');
        return null;
      }
    }

    if (model.rkmectsultCode == 0) {
      await CommonToast.showToast(model.rkmectsultMsg);
      return null;
    }

    return null;
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
