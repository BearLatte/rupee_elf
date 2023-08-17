// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationInfoModel _$CertificationInfoModelFromJson(
        Map<String, dynamic> json) =>
    CertificationInfoModel(
      json['akmmctountMin'] as int,
      json['akmmctountMax'] as int,
      json['akmpctplyAmount'] as String,
      json['ckmoctntactNum'] as int,
      json['ikmmctageHttp'] as String,
      json['fkmrctontImage'] as String,
      json['bkmactckImage'] as String,
      json['ukmscterNames'] as String,
      json['akmactdhaarNumber'] as String,
      json['dkmactteOfBirth'] as String,
      json['ukmscterGender'] as String,
      json['mkmactrriageStatus'] as String,
      json['ekmdctucation'] as String,
      json['akmdctdressDetail'] as String,
      json['ukmscterIndustry'] as String,
      json['wkmoctrkTitle'] as String,
      json['mkmoctnthlySalary'] as String,
      json['ukmscterEmail'] as String,
      json['wkmhctatsAppAccount'] as String,
      json['fkmactcebookId'] as String,
      json['pkmactnCardImg'] as String,
      json['pkmactnNumber'] as String,
      json['ckmoctntactList'] as String,
      json['bkmactnkCardName'] as String,
      json['bkmactnkCardNo'] as String,
      json['bkmactnkIfscCode'] as String,
      (json['ukmscterGenderList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['ekmdctucationList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['mkmactrriageStatusList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['wkmoctrkTitleList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['ikmnctdustryList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['mkmoctnthlySalaryList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['rkmectlationList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    )
      ..rkmectsultCode = json['rkmectsultCode'] as int
      ..rkmectsultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$CertificationInfoModelToJson(
        CertificationInfoModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.rkmectsultCode,
      'rkmectsultMsg': instance.rkmectsultMsg,
      'akmmctountMin': instance.amountMin,
      'akmmctountMax': instance.amountMax,
      'akmpctplyAmount': instance.applyAmount,
      'ckmoctntactNum': instance.contactNum,
      'ikmmctageHttp': instance.imageHttp,
      'fkmrctontImage': instance.frontImage,
      'bkmactckImage': instance.backImage,
      'ukmscterNames': instance.userNames,
      'akmactdhaarNumber': instance.aadhaarNumber,
      'dkmactteOfBirth': instance.dateOfBirth,
      'ukmscterGender': instance.userGender,
      'mkmactrriageStatus': instance.marriageStatus,
      'ekmdctucation': instance.education,
      'akmdctdressDetail': instance.addressDetail,
      'ukmscterIndustry': instance.userIndustry,
      'wkmoctrkTitle': instance.workTitle,
      'mkmoctnthlySalary': instance.monthlySalary,
      'ukmscterEmail': instance.userEmail,
      'wkmhctatsAppAccount': instance.whatsAppAccount,
      'fkmactcebookId': instance.facebookId,
      'pkmactnCardImg': instance.panCardImg,
      'pkmactnNumber': instance.panNumber,
      'ckmoctntactList': instance.contactList,
      'bkmactnkCardName': instance.bankCardName,
      'bkmactnkCardNo': instance.bankCardNo,
      'bkmactnkIfscCode': instance.bankIfscCode,
      'ukmscterGenderList': instance.userGenderList,
      'ekmdctucationList': instance.educationList,
      'mkmactrriageStatusList': instance.marriageStatusList,
      'wkmoctrkTitleList': instance.workTitleList,
      'ikmnctdustryList': instance.industryList,
      'mkmoctnthlySalaryList': instance.monthlySalaryList,
      'rkmectlationList': instance.relationList,
    };
