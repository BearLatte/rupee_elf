import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';

part 'certification_info_model.g.dart';

@JsonSerializable()
class CertificationInfoModel extends BaseModel {

  @JsonKey(name: 'ikmmctageHttp')
  String ikmmctageHttp;

  @JsonKey(name: 'fkmrctontImage')
  String fkmrctontImage;

  @JsonKey(name: 'bkmactckImage')
  String bkmactckImage;

  @JsonKey(name: 'ukmscterNames')
  String ukmscterNames;

  @JsonKey(name: 'akmactdhaarNumber')
  String akmactdhaarNumber;

  @JsonKey(name: 'dkmactteOfBirth')
  String dkmactteOfBirth;

  @JsonKey(name: 'ukmscterGender')
  String ukmscterGender;

  @JsonKey(name: 'mkmactrriageStatus')
  String mkmactrriageStatus;

  @JsonKey(name: 'ekmdctucation')
  String ekmdctucation;

  @JsonKey(name: 'akmdctdressDetail')
  String akmdctdressDetail;

  @JsonKey(name: 'ukmscterIndustry')
  String ukmscterIndustry;

  @JsonKey(name: 'wkmoctrkTitle')
  String wkmoctrkTitle;

  @JsonKey(name: 'mkmoctnthlySalary')
  String mkmoctnthlySalary;

  @JsonKey(name: 'ukmscterEmail')
  String ukmscterEmail;

  @JsonKey(name: 'wkmhctatsAppAccount')
  String wkmhctatsAppAccount;

  @JsonKey(name: 'fkmactcebookId')
  String fkmactcebookId;

  @JsonKey(name: 'pkmactnCardImg')
  String pkmactnCardImg;

  @JsonKey(name: 'pkmactnNumber')
  String pkmactnNumber;

  @JsonKey(name: 'ckmoctntactList')
  String ckmoctntactList;

  @JsonKey(name: 'bkmactnkCardName')
  String bkmactnkCardName;

  @JsonKey(name: 'bkmactnkCardNo')
  String bkmactnkCardNo;

  @JsonKey(name: 'bkmactnkIfscCode')
  String bkmactnkIfscCode;

  @JsonKey(name: 'ukmscterGenderList')
  List<String> ukmscterGenderList;

  @JsonKey(name: 'ekmdctucationList')
  List<String> ekmdctucationList;

  @JsonKey(name: 'mkmactritalStatusList')
  List<String>? mkmactritalStatusList;

  @JsonKey(name: 'wkmoctrkTitleList')
  List<String> wkmoctrkTitleList;

  @JsonKey(name: 'ikmnctdustryList')
  List<String> ikmnctdustryList;

  @JsonKey(name: 'mkmoctnthlySalaryList')
  List<String> mkmoctnthlySalaryList;

  @JsonKey(name: 'rkmectlationList')
  List<String> rkmectlationList;

  CertificationInfoModel(
    this.ikmmctageHttp,
    this.fkmrctontImage,
    this.bkmactckImage,
    this.ukmscterNames,
    this.akmactdhaarNumber,
    this.dkmactteOfBirth,
    this.ukmscterGender,
    this.mkmactrriageStatus,
    this.ekmdctucation,
    this.akmdctdressDetail,
    this.ukmscterIndustry,
    this.wkmoctrkTitle,
    this.mkmoctnthlySalary,
    this.ukmscterEmail,
    this.wkmhctatsAppAccount,
    this.fkmactcebookId,
    this.pkmactnCardImg,
    this.pkmactnNumber,
    this.ckmoctntactList,
    this.bkmactnkCardName,
    this.bkmactnkCardNo,
    this.bkmactnkIfscCode,
    this.ukmscterGenderList,
    this.ekmdctucationList,
    this.mkmactritalStatusList,
    this.wkmoctrkTitleList,
    this.ikmnctdustryList,
    this.mkmoctnthlySalaryList,
    this.rkmectlationList,
  ) : super(0, '');

  factory CertificationInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CertificationInfoModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$CertificationInfoModelToJson(this);
}
