// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel(
      json['lkmoctanOrderNo'] as String,
      json['pkmrctoductName'] as String,
      json['pkmrctoductLogo'] as String,
      json['lkmoctanApplyDate'] as String,
      json['lkmoctanAmount'] as int,
      json['lkmoctanStatus'] as int,
      json['bkmactnkCardNo'] as String,
      json['ikmsctPayFail'] as int?,
      json['fkmrcteezeDays'] as int?,
      json['lkmoctanPayAmount'] as int?,
      json['lkmoctanPayDate'] as String?,
      json['lkmoctanRepayAmount'] as int?,
      json['lkmoctanRepayDate'] as String?,
      json['ekmxcttendButton'] as int?,
      json['okmvcterdueDays'] as String?,
      json['okmvcterdueAmount'] as int?,
    );

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'lkmoctanOrderNo': instance.loanOrderNo,
      'pkmrctoductName': instance.productName,
      'pkmrctoductLogo': instance.productLogo,
      'lkmoctanApplyDate': instance.loanApplyDate,
      'lkmoctanAmount': instance.loanAmount,
      'lkmoctanStatus': instance.loanStatus,
      'bkmactnkCardNo': instance.bankCardNo,
      'ikmsctPayFail': instance.isPayFail,
      'fkmrcteezeDays': instance.freezeDays,
      'lkmoctanPayAmount': instance.loanPayAmount,
      'lkmoctanPayDate': instance.loanPayDate,
      'lkmoctanRepayAmount': instance.loanRepayAmount,
      'lkmoctanRepayDate': instance.loanRepayDate,
      'ekmxcttendButton': instance.extendButton,
      'okmvcterdueDays': instance.overdueDays,
      'okmvcterdueAmount': instance.overdueAmount,
    };
