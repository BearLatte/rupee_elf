// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aws_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AwsParamsModel _$AwsParamsModelFromJson(Map<String, dynamic> json) =>
    AwsParamsModel(
      json['akmwctsBucket'] as String,
      json['akmwctsRegion'] as String,
      AwsCredentials.fromJson(json['ckmrctedentials'] as Map<String, dynamic>),
      json['akmwctsHttp'] as String,
    )
      ..rkmectsultCode = json['rkmectsultCode'] as int
      ..rkmectsultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$AwsParamsModelToJson(AwsParamsModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.rkmectsultCode,
      'rkmectsultMsg': instance.rkmectsultMsg,
      'akmwctsBucket': instance.akmwctsBucket,
      'akmwctsRegion': instance.akmwctsRegion,
      'ckmrctedentials': instance.ckmrctedentials,
      'akmwctsHttp': instance.akmwctsHttp,
    };