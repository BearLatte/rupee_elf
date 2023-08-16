import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/product_model.dart';
import 'product_detail_model.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel extends BaseModel {
  @JsonKey(name: 'ukmscterStatus')
  int? userStatus;

  @JsonKey(name: 'pkmhctotoContent')
  String? photoContent;

  @JsonKey(name: 'gkmpctsContent')
  String? gpsContent;

  @JsonKey(name: 'pkmhctoneContent')
  String? phoneContent;

  @JsonKey(name: 'ckmoctntactNum')
  int? contactNum;

  @JsonKey(name: 'ukmscterLiveness')
  int? userLiveness;

  @JsonKey(name: 'tkmhctirdLiveness')
  String? thirdLiveness;

  @JsonKey(name: 'ukmscterPayFail')
  int? userPayFail;

  @JsonKey(name: 'pkmactyFailLogo')
  String? payFailLogo;

  @JsonKey(name: 'pkmactyFailContent')
  String? payFailContent;

  @JsonKey(name: 'pkmactyFailLoanName')
  String? payFailLoanName;

  @JsonKey(name: 'pkmactyFailLoanNo')
  String? payFailLoanNo;

  @JsonKey(name: 'pkmrctoductList')
  List<ProductModel>? productList;

  @JsonKey(name: 'lkmoctanProduct')
  ProductDetailModel? loanProduct;

  UserInfoModel(
    this.userStatus,
    this.photoContent,
    this.gpsContent,
    this.phoneContent,
    this.contactNum,
    this.userLiveness,
    this.thirdLiveness,
    this.userPayFail,
    this.payFailLogo,
    this.payFailContent,
    this.payFailLoanName,
    this.payFailLoanNo,
    this.productList,
    this.loanProduct,
  ) : super(0, '');

  factory UserInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
