import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rupee_elf/network/api_exception.dart';
import 'package:rupee_elf/network/api_response.dart';
import 'package:rupee_elf/network/raw_data.dart';
import 'network_config.dart';

NetworkClient requestClient = NetworkClient();

class NetworkClient {
  late Dio _dio;

  NetworkClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: NetworkConfig.instance.baseUrl,
        connectTimeout:
            Duration(milliseconds: NetworkConfig.instance.connectTimeout),
      ),
    );
  }

  Future<T?> request<T>(
    String url, {
    String method = 'POST',
    Map<String, dynamic>? parameters,
    data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
  }) async {
    try {
      Options options = Options()
        ..method = method
        ..headers = headers;
      data = _convertRequestData(data);
      Response response = await _dio.request(url,
          queryParameters: parameters, data: data, options: options);
      return _handleResponse(response);
    } catch (error) {
      var exception = ApiException.from(error);
      if (onError?.call(exception) != true) {
        throw exception;
      }
    }

    return null;
  }

  ///请求响应内容处理
  T? _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      if (T.toString() == (RawData).toString()) {
        RawData raw = RawData();
        return raw as T;
      } else {
        ApiResponse<T> apiResponse =
            ApiResponse<T>.fromJson(response.data, response.data);
        return _handleBusinessResponse<T>(apiResponse);
      }
    } else {
      var exception =
          ApiException(response.statusCode, ApiException.unknownException);
      throw exception;
    }
  }

  ///业务内容处理
  T? _handleBusinessResponse<T>(ApiResponse<T> response) {
    if (response.code == NetworkConfig.instance.successCode) {
      return response.data;
    } else {
      return null;
    }
  }

  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }
}
