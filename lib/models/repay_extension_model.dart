import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';

part 'repay_extension_model.g.dart';

@JsonSerializable()
class RepayExtensionModel extends BaseModel {
  @JsonKey(name: 'lkmoctanOrderNo')
  String loanOrderNo;

  @JsonKey(name: 'pkmrctoductName')
  String productName;

  @JsonKey(name: 'pkmrctoductLogo')
  String productLogo;

  @JsonKey(name: 'lkmoctanRepayDate')
  String loanRepayDate;

  @JsonKey(name: 'ekmxcttendFee')
  double? extendFee;

  @JsonKey(name: 'ekmxcttendDays')
  int extendDays;

  @JsonKey(name: 'ekmxcttendRepayDate')
  String extendRepayDate;

  @JsonKey(name: 'lkmoctanRepayAmount')
  double loanRepayAmount;

  RepayExtensionModel(
    this.loanOrderNo,
    this.productLogo,
    this.productName,
    this.loanRepayDate,
    this.extendFee,
    this.extendDays,
    this.extendRepayDate,
    this.loanRepayAmount,
  ) : super(0, '');

  factory RepayExtensionModel.fromJson(Map<String, dynamic> srcJson) =>
      _$RepayExtensionModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$RepayExtensionModelToJson(this);
}
