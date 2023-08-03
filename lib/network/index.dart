import 'package:rupee_elf/network/http_request.dart';

class HttpUtils {
  static HttpRequest httpRequest = HttpRequest();

  /// get
  static Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) {
    return httpRequest.request(
      path: path,
      method: HttpMethod.get,
      queryParameters: queryParameters,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
  }

  /// post
  static Future post({
    required String path,
    HttpMethod method = HttpMethod.post,
    dynamic data,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) {
    return httpRequest.request(
      path: path,
      method: HttpMethod.post,
      data: data,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
  }
}
