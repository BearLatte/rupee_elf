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
    )
      ..resultCode = json['rkmectsultCode'] as int
      ..resultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$AwsParamsModelToJson(AwsParamsModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.resultCode,
      'rkmectsultMsg': instance.resultMsg,
      'akmwctsBucket': instance.awsBucket,
      'akmwctsRegion': instance.awsRegion,
      'ckmrctedentials': instance.credentials,
    };
