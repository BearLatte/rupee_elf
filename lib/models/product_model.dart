import 'package:json_annotation/json_annotation.dart'; 
  
part 'product_model.g.dart';


@JsonSerializable()
  class ProductModel extends Object {

  @JsonKey(name: 'pkmrctoductId')
  int pkmrctoductId;

  @JsonKey(name: 'pkmrctoductLogo')
  String pkmrctoductLogo;

  @JsonKey(name: 'pkmrctoductName')
  String pkmrctoductName;

  @JsonKey(name: 'pkmrctoductDays')
  String pkmrctoductDays;

  @JsonKey(name: 'pkmrctoductAmount')
  String pkmrctoductAmount;

  @JsonKey(name: 'pkmrctoductRate')
  String pkmrctoductRate;

  ProductModel(this.pkmrctoductId,this.pkmrctoductLogo,this.pkmrctoductName,this.pkmrctoductDays,this.pkmrctoductAmount,this.pkmrctoductRate,);

  factory ProductModel.fromJson(Map<String, dynamic> srcJson) => _$ProductModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

}

  
