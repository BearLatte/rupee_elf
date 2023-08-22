import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';

part 'repay_model.g.dart';

@JsonSerializable()
class RepayModel extends BaseModel {
  @JsonKey(name: 'wkmectbviewType')
  int webviewType;

  @JsonKey(name: 'rkmectpayPath')
  String repayPath;

  RepayModel(
    this.webviewType,
    this.repayPath,
  ) : super(0, '');

  factory RepayModel.fromJson(Map<String, dynamic> srcJson) =>
      _$RepayModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$RepayModelToJson(this);
}
