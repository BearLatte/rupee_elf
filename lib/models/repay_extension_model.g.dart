// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repay_extension_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepayExtensionModel _$RepayExtensionModelFromJson(Map<String, dynamic> json) =>
    RepayExtensionModel(
      json['lkmoctanOrderNo'] as String,
      json['pkmrctoductLogo'] as String,
      json['pkmrctoductName'] as String,
      json['lkmoctanRepayDate'] as String,
      (json['ekmxcttendFee'] as num?)?.toDouble(),
      json['ekmxcttendDays'] as int,
      json['ekmxcttendRepayDate'] as String,
      (json['lkmoctanRepayAmount'] as num).toDouble(),
    )
      ..resultCode = json['rkmectsultCode'] as int
      ..resultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$RepayExtensionModelToJson(
        RepayExtensionModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.resultCode,
      'rkmectsultMsg': instance.resultMsg,
      'lkmoctanOrderNo': instance.loanOrderNo,
      'pkmrctoductName': instance.productName,
      'pkmrctoductLogo': instance.productLogo,
      'lkmoctanRepayDate': instance.loanRepayDate,
      'ekmxcttendFee': instance.extendFee,
      'ekmxcttendDays': instance.extendDays,
      'ekmxcttendRepayDate': instance.extendRepayDate,
      'lkmoctanRepayAmount': instance.loanRepayAmount,
    };
