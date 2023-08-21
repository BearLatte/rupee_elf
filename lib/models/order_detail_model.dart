import 'package:json_annotation/json_annotation.dart';

part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel extends Object {
  @JsonKey(name: 'lkmoctanOrderNo')
  String loanOrderNo;

  @JsonKey(name: 'pkmrctoductName')
  String productName;

  @JsonKey(name: 'pkmrctoductLogo')
  String productLogo;

  @JsonKey(name: 'lkmoctanApplyDate')
  String loanApplyDate;

  @JsonKey(name: 'lkmoctanAmount')
  int loanAmount;

  @JsonKey(name: 'lkmoctanStatus')
  int loanStatus;

  @JsonKey(name: 'bkmactnkCardNo')
  String? bankCardNo;

  @JsonKey(name: 'ikmsctPayFail')
  int? isPayFail;

  @JsonKey(name: 'fkmrcteezeDays')
  int? freezeDays;

  @JsonKey(name: 'lkmoctanPayAmount')
  double? loanPayAmount;

  @JsonKey(name: 'lkmoctanPayDate')
  String? loanPayDate;

  @JsonKey(name: 'lkmoctanRepayAmount')
  double? loanRepayAmount;

  @JsonKey(name: 'lkmoctanRepayDate')
  String? loanRepayDate;

  @JsonKey(name: 'ekmxcttendButton')
  int? extendButton;

  @JsonKey(name: 'okmvcterdueDays')
  int? overdueDays;

  @JsonKey(name: 'okmvcterdueAmount')
  double? overdueAmount;

  OrderDetailModel(
    this.loanOrderNo,
    this.productName,
    this.productLogo,
    this.loanApplyDate,
    this.loanAmount,
    this.loanStatus,
    this.bankCardNo,
    this.isPayFail,
    this.freezeDays,
    this.loanPayAmount,
    this.loanPayDate,
    this.loanRepayAmount,
    this.loanRepayDate,
    this.extendButton,
    this.overdueDays,
    this.overdueAmount,
  );

  factory OrderDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}
