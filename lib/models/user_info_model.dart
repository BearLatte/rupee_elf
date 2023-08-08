import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/product_model.dart';
import 'product_detail_model.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel extends BaseModel {
  @JsonKey(name: 'ukmscterStatus')
  int? ukmscterStatus;

  @JsonKey(name: 'pkmhctotoContent')
  String? pkmhctotoContent;

  @JsonKey(name: 'gkmpctsContent')
  String? gkmpctsContent;

  @JsonKey(name: 'pkmhctoneContent')
  String? pkmhctoneContent;

  @JsonKey(name: 'ckmoctntactNum')
  int? ckmoctntactNum;

  @JsonKey(name: 'ukmscterLiveness')
  int? ukmscterLiveness;

  @JsonKey(name: 'tkmhctirdLiveness')
  String tkmhctirdLiveness;

  @JsonKey(name: 'ukmscterPayFail')
  int? ukmscterPayFail;

  @JsonKey(name: 'pkmactyFailLogo')
  String pkmactyFailLogo;

  @JsonKey(name: 'pkmactyFailContent')
  String pkmactyFailContent;

  @JsonKey(name: 'pkmactyFailLoanName')
  String pkmactyFailLoanName;

  @JsonKey(name: 'pkmactyFailLoanNo')
  String pkmactyFailLoanNo;

  @JsonKey(name: 'pkmrctoductList')
  List<ProductModel>? pkmrctoductList;

  @JsonKey(name: 'lkmoctanProduct')
  ProductDetailModel? lkmoctanProduct;

  UserInfoModel(
    this.ukmscterStatus,
    this.pkmhctotoContent,
    this.gkmpctsContent,
    this.pkmhctoneContent,
    this.ckmoctntactNum,
    this.ukmscterLiveness,
    this.tkmhctirdLiveness,
    this.ukmscterPayFail,
    this.pkmactyFailLogo,
    this.pkmactyFailContent,
    this.pkmactyFailLoanName,
    this.pkmactyFailLoanNo,
    this.pkmrctoductList,
    this.lkmoctanProduct,
  ) : super(0, '');

  factory UserInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
