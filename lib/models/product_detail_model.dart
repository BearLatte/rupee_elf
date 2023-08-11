import 'package:json_annotation/json_annotation.dart';

part 'product_detail_model.g.dart';

@JsonSerializable()
class ProductDetailModel extends Object {
  @JsonKey(name: 'pkmrctoductId')
  int pkmrctoductId;

  @JsonKey(name: 'pkmrctoductLogo')
  String pkmrctoductLogo;

  @JsonKey(name: 'pkmrctoductName')
  String pkmrctoductName;

  @JsonKey(name: 'lkmoctanAmount')
  int lkmoctanAmount;

  @JsonKey(name: 'lkmoctanOfDays')
  int lkmoctanOfDays;

  @JsonKey(name: 'lkmoctanPayAmount')
  int lkmoctanPayAmount;

  @JsonKey(name: 'lkmoctanFeeVerify')
  int lkmoctanFeeVerify;

  @JsonKey(name: 'lkmoctanFeeGst')
  int lkmoctanFeeGst;

  @JsonKey(name: 'lkmoctanInterest')
  int lkmoctanInterest;

  @JsonKey(name: 'lkmoctanOverdue')
  String lkmoctanOverdue;

  @JsonKey(name: 'lkmoctanRepayAmount')
  int lkmoctanRepayAmount;

  ProductDetailModel(
    this.pkmrctoductId,
    this.pkmrctoductLogo,
    this.pkmrctoductName,
    this.lkmoctanAmount,
    this.lkmoctanOfDays,
    this.lkmoctanPayAmount,
    this.lkmoctanFeeVerify,
    this.lkmoctanFeeGst,
    this.lkmoctanInterest,
    this.lkmoctanOverdue,
    this.lkmoctanRepayAmount,
  );

  factory ProductDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}
