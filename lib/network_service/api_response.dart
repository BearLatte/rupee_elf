import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> extends Object {
  @JsonKey(name: 'data')
  T data;

  ApiResponse(
    this.data,
  );

  factory ApiResponse.fromJson(
          Map<String, dynamic> srcJson, T Function(dynamic json) fromJsonT) =>
      _$ApiResponseFromJson(srcJson, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}
