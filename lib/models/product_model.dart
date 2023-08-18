import 'package:json_annotation/json_annotation.dart'; 
  
part 'product_model.g.dart';


@JsonSerializable()
  class ProductModel extends Object {

  @JsonKey(name: 'pkmrctoductId')
  int productId;

  @JsonKey(name: 'pkmrctoductLogo')
  String productLogo;

  @JsonKey(name: 'pkmrctoductName')
  String productName;

  @JsonKey(name: 'pkmrctoductDays')
  String productDays;

  @JsonKey(name: 'pkmrctoductAmount')
  String productAmount;

  @JsonKey(name: 'pkmrctoductRate')
  String productRate;

  ProductModel(this.productId,this.productLogo,this.productName,this.productDays,this.productAmount,this.productRate,);

  factory ProductModel.fromJson(Map<String, dynamic> srcJson) => _$ProductModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

}

  
