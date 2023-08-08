// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationInfoModel _$CertificationInfoModelFromJson(
        Map<String, dynamic> json) =>
    CertificationInfoModel(
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
      (json['mkmactritalStatusList'] as List<dynamic>?)
          ?.map((e) => e as String)
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
      'fkmrctontImage': instance.fkmrctontImage,
      'bkmactckImage': instance.bkmactckImage,
      'ukmscterNames': instance.ukmscterNames,
      'akmactdhaarNumber': instance.akmactdhaarNumber,
      'dkmactteOfBirth': instance.dkmactteOfBirth,
      'ukmscterGender': instance.ukmscterGender,
      'mkmactrriageStatus': instance.mkmactrriageStatus,
      'ekmdctucation': instance.ekmdctucation,
      'akmdctdressDetail': instance.akmdctdressDetail,
      'ukmscterIndustry': instance.ukmscterIndustry,
      'wkmoctrkTitle': instance.wkmoctrkTitle,
      'mkmoctnthlySalary': instance.mkmoctnthlySalary,
      'ukmscterEmail': instance.ukmscterEmail,
      'wkmhctatsAppAccount': instance.wkmhctatsAppAccount,
      'fkmactcebookId': instance.fkmactcebookId,
      'pkmactnCardImg': instance.pkmactnCardImg,
      'pkmactnNumber': instance.pkmactnNumber,
      'ckmoctntactList': instance.ckmoctntactList,
      'bkmactnkCardName': instance.bkmactnkCardName,
      'bkmactnkCardNo': instance.bkmactnkCardNo,
      'bkmactnkIfscCode': instance.bkmactnkIfscCode,
      'ukmscterGenderList': instance.ukmscterGenderList,
      'ekmdctucationList': instance.ekmdctucationList,
      'mkmactritalStatusList': instance.mkmactritalStatusList,
      'wkmoctrkTitleList': instance.wkmoctrkTitleList,
      'ikmnctdustryList': instance.ikmnctdustryList,
      'mkmoctnthlySalaryList': instance.mkmoctnthlySalaryList,
      'rkmectlationList': instance.rkmectlationList,
    };
