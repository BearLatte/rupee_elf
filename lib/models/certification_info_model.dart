import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';

part 'certification_info_model.g.dart';

@JsonSerializable()
class CertificationInfoModel extends BaseModel {
  @JsonKey(name: 'akmmctountMin')
  int amountMin;

  @JsonKey(name: 'akmmctountMax')
  int amountMax;

  @JsonKey(name: 'akmpctplyAmount')
  String applyAmount;

  @JsonKey(name: 'ckmoctntactNum')
  int contactNum;

  @JsonKey(name: 'ikmmctageHttp')
  String imageHttp;

  @JsonKey(name: 'fkmrctontImage')
  String frontImage;

  @JsonKey(name: 'bkmactckImage')
  String backImage;

  @JsonKey(name: 'ukmscterNames')
  String userNames;

  @JsonKey(name: 'akmactdhaarNumber')
  String aadhaarNumber;

  @JsonKey(name: 'dkmactteOfBirth')
  String dateOfBirth;

  @JsonKey(name: 'ukmscterGender')
  String userGender;

  @JsonKey(name: 'mkmactrriageStatus')
  String marriageStatus;

  @JsonKey(name: 'ekmdctucation')
  String education;

  @JsonKey(name: 'akmdctdressDetail')
  String addressDetail;

  @JsonKey(name: 'ukmscterIndustry')
  String userIndustry;

  @JsonKey(name: 'wkmoctrkTitle')
  String workTitle;

  @JsonKey(name: 'mkmoctnthlySalary')
  String monthlySalary;

  @JsonKey(name: 'ukmscterEmail')
  String userEmail;

  @JsonKey(name: 'wkmhctatsAppAccount')
  String whatsAppAccount;

  @JsonKey(name: 'fkmactcebookId')
  String facebookId;

  @JsonKey(name: 'pkmactnCardImg')
  String panCardImg;

  @JsonKey(name: 'pkmactnNumber')
  String panNumber;

  @JsonKey(name: 'ckmoctntactList')
  String contactList;

  @JsonKey(name: 'bkmactnkCardName')
  String bankCardName;

  @JsonKey(name: 'bkmactnkCardNo')
  String bankCardNo;

  @JsonKey(name: 'bkmactnkIfscCode')
  String bankIfscCode;

  @JsonKey(name: 'ukmscterGenderList')
  List<String> userGenderList;

  @JsonKey(name: 'ekmdctucationList')
  List<String> educationList;

  @JsonKey(name: 'mkmactrriageStatusList')
  List<String> marriageStatusList;

  @JsonKey(name: 'wkmoctrkTitleList')
  List<String> workTitleList;

  @JsonKey(name: 'ikmnctdustryList')
  List<String> industryList;

  @JsonKey(name: 'mkmoctnthlySalaryList')
  List<String> monthlySalaryList;

  @JsonKey(name: 'rkmectlationList')
  List<String> relationList;

  CertificationInfoModel(
    this.amountMin,
    this.amountMax,
    this.applyAmount,
    this.contactNum,
    this.imageHttp,
    this.frontImage,
    this.backImage,
    this.userNames,
    this.aadhaarNumber,
    this.dateOfBirth,
    this.userGender,
    this.marriageStatus,
    this.education,
    this.addressDetail,
    this.userIndustry,
    this.workTitle,
    this.monthlySalary,
    this.userEmail,
    this.whatsAppAccount,
    this.facebookId,
    this.panCardImg,
    this.panNumber,
    this.contactList,
    this.bankCardName,
    this.bankCardNo,
    this.bankIfscCode,
    this.userGenderList,
    this.educationList,
    this.marriageStatusList,
    this.workTitleList,
    this.industryList,
    this.monthlySalaryList,
    this.relationList,
  ) : super(0, '');

  factory CertificationInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CertificationInfoModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$CertificationInfoModelToJson(this);
}
