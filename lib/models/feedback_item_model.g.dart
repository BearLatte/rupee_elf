// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackItemModel _$FeedbackItemModelFromJson(Map<String, dynamic> json) =>
    FeedbackItemModel(
      json['lkmoctanOrderNo'] as String,
      json['pkmrctoductLogo'] as String,
      json['pkmrctoductName'] as String,
      json['fkmectedBackType'] as String,
      json['fkmectedBackContent'] as String,
      json['fkmectedBackImg'] as String?,
      json['rkmectplyContent'] as String?,
      json['rkmectplyTime'] as String?,
      json['fkmectedBackState'] as int,
      json['fkmectedBackTime'] as String,
    );

Map<String, dynamic> _$FeedbackItemModelToJson(FeedbackItemModel instance) =>
    <String, dynamic>{
      'lkmoctanOrderNo': instance.loanOrderNo,
      'pkmrctoductLogo': instance.productLogo,
      'pkmrctoductName': instance.productName,
      'fkmectedBackType': instance.feedBackType,
      'fkmectedBackContent': instance.feedBackContent,
      'fkmectedBackImg': instance.feedBackImg,
      'rkmectplyContent': instance.replyContent,
      'rkmectplyTime': instance.replyTime,
      'fkmectedBackState': instance.feedBackState,
      'fkmectedBackTime': instance.feedBackTime,
    };
