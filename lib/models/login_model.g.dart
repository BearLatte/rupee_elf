// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      json['rkmectsultCode'] as int,
      json['rkmectsultMsg'] as String,
      json['lkmoctginToken'] as String?,
      json['ikmsctRegistered'] as int?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.rkmectsultCode,
      'rkmectsultMsg': instance.rkmectsultMsg,
      'lkmoctginToken': instance.lkmoctginToken,
      'ikmsctRegistered': instance.ikmsctRegistered,
    };
