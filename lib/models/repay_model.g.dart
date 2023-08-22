// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepayModel _$RepayModelFromJson(Map<String, dynamic> json) => RepayModel(
      json['wkmectbviewType'] as int,
      json['rkmectpayPath'] as String,
    )
      ..resultCode = json['rkmectsultCode'] as int
      ..resultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$RepayModelToJson(RepayModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.resultCode,
      'rkmectsultMsg': instance.resultMsg,
      'wkmectbviewType': instance.webviewType,
      'rkmectpayPath': instance.repayPath,
    };
