// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['pkmrctoductId'] as int,
      json['pkmrctoductLogo'] as String,
      json['pkmrctoductName'] as String,
      json['pkmrctoductDays'] as String,
      json['pkmrctoductAmount'] as String,
      json['pkmrctoductRate'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'pkmrctoductId': instance.productId,
      'pkmrctoductLogo': instance.productLogo,
      'pkmrctoductName': instance.productName,
      'pkmrctoductDays': instance.productDays,
      'pkmrctoductAmount': instance.productAmount,
      'pkmrctoductRate': instance.productRate,
    };
