// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['lkmoctanOrderNo'] as String,
      json['pkmrctoductLogo'] as String,
      json['pkmrctoductName'] as String,
      json['lkmoctanAmount'] as int,
      json['lkmoctanApplyDate'] as String,
      json['skmtctatus'] as int?,
      json['ikmsctPayFail'] as int?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'lkmoctanOrderNo': instance.loanOrderNo,
      'pkmrctoductLogo': instance.productLogo,
      'pkmrctoductName': instance.productName,
      'lkmoctanAmount': instance.loanAmount,
      'lkmoctanApplyDate': instance.loanApplyDate,
      'skmtctatus': instance.status,
      'ikmsctPayFail': instance.isPayFail,
    };
