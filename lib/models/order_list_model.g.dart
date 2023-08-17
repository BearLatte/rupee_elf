// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListModel _$OrderListModelFromJson(Map<String, dynamic> json) =>
    OrderListModel(
      OrderStatisticsModel.fromJson(
          json['okmrctderGroup'] as Map<String, dynamic>),
      (json['okmrctderList'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['fkmectedBackTypes'] as List<dynamic>)
          .map((e) => FeedbackTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..rkmectsultCode = json['rkmectsultCode'] as int
      ..rkmectsultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$OrderListModelToJson(OrderListModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.rkmectsultCode,
      'rkmectsultMsg': instance.rkmectsultMsg,
      'okmrctderGroup': instance.orderGroup,
      'okmrctderList': instance.orderList,
      'fkmectedBackTypes': instance.feedBackTypes,
    };
