import 'package:json_annotation/json_annotation.dart'; 
  
part 'product_detail_model.g.dart';


@JsonSerializable()
  class ProductDetailModel extends Object {

  @JsonKey(name: 'pkmrctoductId')
  String pkmrctoductId;

  @JsonKey(name: 'pkmrctoductLogo')
  String pkmrctoductLogo;

  @JsonKey(name: 'pkmrctoductName')
  String pkmrctoductName;

  @JsonKey(name: 'lkmoctanAmount')
  String lkmoctanAmount;

  @JsonKey(name: 'lkmoctanOfDays')
  String lkmoctanOfDays;

  @JsonKey(name: 'lkmoctanPayAmount')
  String lkmoctanPayAmount;

  @JsonKey(name: 'lkmoctanFeeVerify')
  String lkmoctanFeeVerify;

  @JsonKey(name: 'lkmoctanFeeGst')
  String lkmoctanFeeGst;

  @JsonKey(name: 'lkmoctanInterest')
  String lkmoctanInterest;

  @JsonKey(name: 'lkmoctanOverdue')
  String lkmoctanOverdue;

  @JsonKey(name: 'lkmoctanRepayAmount')
  String lkmoctanRepayAmount;

  ProductDetailModel(this.pkmrctoductId,this.pkmrctoductLogo,this.pkmrctoductName,this.lkmoctanAmount,this.lkmoctanOfDays,this.lkmoctanPayAmount,this.lkmoctanFeeVerify,this.lkmoctanFeeGst,this.lkmoctanInterest,this.lkmoctanOverdue,this.lkmoctanRepayAmount,);

  factory ProductDetailModel.fromJson(Map<String, dynamic> srcJson) => _$ProductDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);

}

  
