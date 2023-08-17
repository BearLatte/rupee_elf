// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatisticsModel _$OrderStatisticsModelFromJson(
        Map<String, dynamic> json) =>
    OrderStatisticsModel(
      json['lkmoctanAllNum'] as int,
      json['lkmoctanAuditNum'] as int,
      json['lkmoctanPayNum'] as int,
      json['lkmoctanRepayNum'] as int,
      json['lkmoctanFinishedNum'] as int,
      json['lkmoctanFailNum'] as int,
      json['lkmoctanOverdueNum'] as int,
    );

Map<String, dynamic> _$OrderStatisticsModelToJson(
        OrderStatisticsModel instance) =>
    <String, dynamic>{
      'lkmoctanAllNum': instance.loanAllNum,
      'lkmoctanAuditNum': instance.loanAuditNum,
      'lkmoctanPayNum': instance.loanPayNum,
      'lkmoctanRepayNum': instance.loanRepayNum,
      'lkmoctanFinishedNum': instance.loanFinishedNum,
      'lkmoctanFailNum': instance.loanFailNum,
      'lkmoctanOverdueNum': instance.loanOverdueNum,
    };
