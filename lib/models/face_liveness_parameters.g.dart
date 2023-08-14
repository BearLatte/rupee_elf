// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_liveness_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceLivenessParameters _$FaceLivenessParametersFromJson(
        Map<String, dynamic> json) =>
    FaceLivenessParameters(
      json['akmcctcuauthId'] as String,
      json['akmcctcuauthSecret'] as String,
      json['akmcctcuauthHostUrl'] as String,
    )
      ..rkmectsultCode = json['rkmectsultCode'] as int
      ..rkmectsultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$FaceLivenessParametersToJson(
        FaceLivenessParameters instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.rkmectsultCode,
      'rkmectsultMsg': instance.rkmectsultMsg,
      'akmcctcuauthId': instance.accuauthId,
      'akmcctcuauthSecret': instance.accuauthSecret,
      'akmcctcuauthHostUrl': instance.accuauthHostUrl,
    };
