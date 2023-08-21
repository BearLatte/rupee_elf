// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpaceDetailModel _$SpaceDetailModelFromJson(Map<String, dynamic> json) =>
    SpaceDetailModel(
      json['skmpctaceStatus'] as int,
      json['lkmoctanProduct'] == null
          ? null
          : ProductDetailModel.fromJson(
              json['lkmoctanProduct'] as Map<String, dynamic>),
      (json['pkmrctoductList'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['okmrctderInfo'] == null
          ? null
          : OrderDetailModel.fromJson(
              json['okmrctderInfo'] as Map<String, dynamic>),
    )
      ..resultCode = json['rkmectsultCode'] as int
      ..resultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$SpaceDetailModelToJson(SpaceDetailModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.resultCode,
      'rkmectsultMsg': instance.resultMsg,
      'skmpctaceStatus': instance.spaceStatus,
      'lkmoctanProduct': instance.loanProduct,
      'pkmrctoductList': instance.productList,
      'okmrctderInfo': instance.orderInfo,
    };
