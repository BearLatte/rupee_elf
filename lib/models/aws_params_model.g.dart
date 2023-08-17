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
      ..rkmectsultCode = json['rkmectsultCode'] as int
      ..rkmectsultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$AwsParamsModelToJson(AwsParamsModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.rkmectsultCode,
      'rkmectsultMsg': instance.rkmectsultMsg,
      'akmwctsBucket': instance.awsBucket,
      'akmwctsRegion': instance.awsRegion,
      'ckmrctedentials': instance.credentials,
    };
