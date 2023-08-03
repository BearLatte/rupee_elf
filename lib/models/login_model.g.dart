// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      json['resultCode'] as int,
      json['resultMsg'] as String,
      json['loginToken'] as String,
      json['isRegistered'] as int,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'resultMsg': instance.resultMsg,
      'loginToken': instance.loginToken,
      'isRegistered': instance.isRegistered,
    };
