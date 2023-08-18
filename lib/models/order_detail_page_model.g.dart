// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailPageModel _$OrderDetailPageModelFromJson(
        Map<String, dynamic> json) =>
    OrderDetailPageModel(
      (json['pkmrctoductList'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['okmrctderInfo'] == null
          ? null
          : OrderDetailModel.fromJson(
              json['okmrctderInfo'] as Map<String, dynamic>),
    )
      ..rkmectsultCode = json['rkmectsultCode'] as int
      ..rkmectsultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$OrderDetailPageModelToJson(
        OrderDetailPageModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.rkmectsultCode,
      'rkmectsultMsg': instance.rkmectsultMsg,
      'pkmrctoductList': instance.productList,
      'okmrctderInfo': instance.orderInfo,
    };
