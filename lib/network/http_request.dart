import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//辅助配置
import 'http_options.dart';
import 'http_interceptor.dart';

class HttpRequest {
  // 单例模式使用Http类，
  static final HttpRequest _instance = HttpRequest._internal();

  factory HttpRequest() => _instance;

  static late final Dio dio;

  /// 内部构造方法
  HttpRequest._internal() {
    /// 初始化dio
    BaseOptions options = BaseOptions(
      baseUrl: HttpOptions.instance.baseUrl,
      connectTimeout:
          Duration(milliseconds: HttpOptions.instance.connectTimeout),
      receiveTimeout:
          Duration(milliseconds: HttpOptions.instance.receiveTimeout),
      sendTimeout: Duration(milliseconds: HttpOptions.instance.sendTimeout),
      headers: HttpOptions.instance.headers,
    );

    dio = Dio(options);

    /// 添加各种拦截器
    // dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
  }

  /// 封装request方法
  Future<dynamic> request({
    required String path, //接口地址
    required HttpMethod method, //请求方式
    dynamic data, //数据
    Map<String, dynamic>? queryParameters,
    bool showLoading = true, //加载过程
    bool showErrorMessage = true, //返回数据
  }) async {
    const Map methodValues = {
      HttpMethod.get: 'get',
      HttpMethod.post: 'post',
      HttpMethod.put: 'put',
      HttpMethod.delete: 'delete',
      HttpMethod.patch: 'patch',
      HttpMethod.head: 'head'
    };

    // 动态添加header头
    Map<String, dynamic> headers = HttpOptions.instance.headers;

    Options options = Options(
      method: methodValues[method],
      headers: headers,
    );

    try {
      if (showLoading) {
        EasyLoading.show(
          status: 'loading...',
          maskType: EasyLoadingMaskType.black,
        );
      }
      Response response = await HttpRequest.dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (error) {
      HttpException httpException = HttpException.create(error);
      if (showErrorMessage) {
        EasyLoading.showToast(httpException.msg);
      }
    } finally {
      if (showLoading) {
        EasyLoading.dismiss();
      }
    }
  }
}

enum HttpMethod {
  get,
  post,
  delete,
  put,
  patch,
  head,
}
