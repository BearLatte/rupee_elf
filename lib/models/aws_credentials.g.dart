// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aws_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AwsCredentials _$AwsCredentialsFromJson(Map<String, dynamic> json) =>
    AwsCredentials(
      json['accessKeyId'] as String,
      json['secretAccessKey'] as String,
      json['sessionToken'] as String,
      json['expiration'] as int,
    );

Map<String, dynamic> _$AwsCredentialsToJson(AwsCredentials instance) =>
    <String, dynamic>{
      'accessKeyId': instance.accessKeyId,
      'secretAccessKey': instance.secretAccessKey,
      'sessionToken': instance.sessionToken,
      'expiration': instance.expiration,
    };
