// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) =>
    ProductDetailModel(
      json['pkmrctoductId'] as int,
      json['pkmrctoductLogo'] as String,
      json['pkmrctoductName'] as String,
      json['lkmoctanAmount'] as int,
      json['lkmoctanOfDays'] as int,
      json['lkmoctanPayAmount'] as int,
      json['lkmoctanFeeVerify'] as int,
      json['lkmoctanFeeGst'] as int,
      json['lkmoctanInterest'] as int,
      json['lkmoctanOverdue'] as String,
      json['lkmoctanRepayAmount'] as int,
    );

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'pkmrctoductId': instance.pkmrctoductId,
      'pkmrctoductLogo': instance.pkmrctoductLogo,
      'pkmrctoductName': instance.pkmrctoductName,
      'lkmoctanAmount': instance.lkmoctanAmount,
      'lkmoctanOfDays': instance.lkmoctanOfDays,
      'lkmoctanPayAmount': instance.lkmoctanPayAmount,
      'lkmoctanFeeVerify': instance.lkmoctanFeeVerify,
      'lkmoctanFeeGst': instance.lkmoctanFeeGst,
      'lkmoctanInterest': instance.lkmoctanInterest,
      'lkmoctanOverdue': instance.lkmoctanOverdue,
      'lkmoctanRepayAmount': instance.lkmoctanRepayAmount,
    };
