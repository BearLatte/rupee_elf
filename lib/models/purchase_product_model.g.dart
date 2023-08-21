// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseProductModel _$PurchaseProductModelFromJson(
        Map<String, dynamic> json) =>
    PurchaseProductModel(
      json['ikmsctFirstApply'] as int?,
      (json['pkmrctoductList'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..resultCode = json['rkmectsultCode'] as int
      ..resultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$PurchaseProductModelToJson(
        PurchaseProductModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.resultCode,
      'rkmectsultMsg': instance.resultMsg,
      'ikmsctFirstApply': instance.isFirstApply,
      'pkmrctoductList': instance.productList,
    };
