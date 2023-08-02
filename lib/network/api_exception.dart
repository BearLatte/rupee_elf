import 'package:dio/dio.dart';
import 'package:rupee_elf/network/api_response.dart';

class ApiException {
  static const unknownException = "unknown error";
  final String? message;
  final int? code;
  String? stackInfo;

  ApiException([this.code, this.message]);

  factory ApiException.fromDioError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.cancel:
        return BadRequestException(-1, "the request is canceled");
      case DioExceptionType.connectionTimeout:
        return BadRequestException(-1, "connection timeout");
      case DioExceptionType.sendTimeout:
        return BadRequestException(-1, "request timeout");
      case DioExceptionType.receiveTimeout:
        return BadRequestException(-1, "response timeout");
      case DioExceptionType.badResponse:
        try {
          /// http 错误码带业务错误信息
          ApiResponse apiResponse =
              ApiResponse.fromJson(exception.response?.data, exception.response?.data);
          if (apiResponse.code != null) {
            return ApiException(apiResponse.code, apiResponse.message);
          }

          int? errCode = exception.response?.statusCode;
          switch (errCode) {
            case 400:
              return BadRequestException(errCode, "request syntax error");
            case 401:
              return UnauthorisedException(errCode!, "no permission");
            case 403:
              return UnauthorisedException(errCode!, "the server refused to execute");
            case 404:
              return UnauthorisedException(errCode!, "Unable to connect to the server");
            case 405:
              return UnauthorisedException(errCode!, "the request method is prohibited");
            case 500:
              return UnauthorisedException(errCode!, "server internal error");
            case 502:
              return UnauthorisedException(errCode!, "Invalid request");
            case 503:
              return UnauthorisedException(errCode!, "server exception");
            case 505:
              return UnauthorisedException(errCode!, "HTTP protocol requests are not supported");
            default:
              return ApiException(
                  errCode, exception.response?.statusMessage ?? 'unknown error');
          }
        } on Exception catch (_) {
          return ApiException(-1, unknownException);
        }
      default:
        return ApiException(-1, exception.message);
    }
  }

  factory ApiException.from(dynamic exception) {
    if (exception is DioException) {
      return ApiException.fromDioError(exception);
    }
    if (exception is ApiException) {
      return exception;
    } else {
      var apiException = ApiException(-1, unknownException);
      apiException.stackInfo = exception?.toString();
      return apiException;
    }
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException([int? code, String? message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends ApiException {
  UnauthorisedException([int code = -1, String message = ''])
      : super(code, message);
}
