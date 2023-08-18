import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Object {
  @JsonKey(name: 'lkmoctanOrderNo')
  String loanOrderNo;

  @JsonKey(name: 'pkmrctoductLogo')
  String productLogo;

  @JsonKey(name: 'pkmrctoductName')
  String productName;

  @JsonKey(name: 'lkmoctanAmount')
  int loanAmount;

  @JsonKey(name: 'lkmoctanApplyDate')
  String loanApplyDate;

  @JsonKey(name: 'lkmoctanStatus')
  int loanStatus;

  @JsonKey(name: 'ikmsctPayFail')
  int? isPayFail;

  OrderModel(
    this.loanOrderNo,
    this.productLogo,
    this.productName,
    this.loanAmount,
    this.loanApplyDate,
    this.loanStatus,
    this.isPayFail,
  );

  factory OrderModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
