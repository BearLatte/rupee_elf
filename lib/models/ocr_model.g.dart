// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcrModel _$OcrModelFromJson(Map<String, dynamic> json) => OcrModel(
      json['ikmmctageHttp'] as String,
      json['ikmmctagePath'] as String,
      json['ukmscterNames'] as String?,
      json['akmactdhaarNumber'] as String?,
      json['ukmscterGender'] as String?,
      json['dkmactteOfBirth'] as String?,
      json['akmdctdressDetail'] as String?,
      json['pkmactnNumber'] as String?,
    )
      ..resultCode = json['rkmectsultCode'] as int
      ..resultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$OcrModelToJson(OcrModel instance) => <String, dynamic>{
      'rkmectsultCode': instance.resultCode,
      'rkmectsultMsg': instance.resultMsg,
      'ikmmctageHttp': instance.ikmmctageHttp,
      'ikmmctagePath': instance.ikmmctagePath,
      'ukmscterNames': instance.ukmscterNames,
      'akmactdhaarNumber': instance.akmactdhaarNumber,
      'ukmscterGender': instance.ukmscterGender,
      'dkmactteOfBirth': instance.dkmactteOfBirth,
      'akmdctdressDetail': instance.akmdctdressDetail,
      'pkmactnNumber': instance.pkmactnNumber,
    };
