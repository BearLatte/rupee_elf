// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['pkmrctoductId'] as String,
      json['pkmrctoductLogo'] as String,
      json['pkmrctoductName'] as String,
      json['pkmrctoductDays'] as String,
      json['pkmrctoductAmount'] as String,
      json['pkmrctoductRate'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'pkmrctoductId': instance.pkmrctoductId,
      'pkmrctoductLogo': instance.pkmrctoductLogo,
      'pkmrctoductName': instance.pkmrctoductName,
      'pkmrctoductDays': instance.pkmrctoductDays,
      'pkmrctoductAmount': instance.pkmrctoductAmount,
      'pkmrctoductRate': instance.pkmrctoductRate,
    };
