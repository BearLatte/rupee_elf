// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      json['ukmscterStatus'] as int?,
      json['pkmhctotoContent'] as String?,
      json['gkmpctsContent'] as String?,
      json['pkmhctoneContent'] as String?,
      json['ckmoctntactNum'] as int?,
      json['ukmscterLiveness'] as int?,
      json['tkmhctirdLiveness'] as String,
      json['ukmscterPayFail'] as int?,
      json['pkmactyFailLogo'] as String,
      json['pkmactyFailContent'] as String,
      json['pkmactyFailLoanName'] as String,
      json['pkmactyFailLoanNo'] as String,
      (json['pkmrctoductList'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['lkmoctanProduct'] == null
          ? null
          : ProductDetailModel.fromJson(
              json['lkmoctanProduct'] as Map<String, dynamic>),
    )
      ..rkmectsultCode = json['rkmectsultCode'] as int
      ..rkmectsultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.rkmectsultCode,
      'rkmectsultMsg': instance.rkmectsultMsg,
      'ukmscterStatus': instance.ukmscterStatus,
      'pkmhctotoContent': instance.pkmhctotoContent,
      'gkmpctsContent': instance.gkmpctsContent,
      'pkmhctoneContent': instance.pkmhctoneContent,
      'ckmoctntactNum': instance.ckmoctntactNum,
      'ukmscterLiveness': instance.ukmscterLiveness,
      'tkmhctirdLiveness': instance.tkmhctirdLiveness,
      'ukmscterPayFail': instance.ukmscterPayFail,
      'pkmactyFailLogo': instance.pkmactyFailLogo,
      'pkmactyFailContent': instance.pkmactyFailContent,
      'pkmactyFailLoanName': instance.pkmactyFailLoanName,
      'pkmactyFailLoanNo': instance.pkmactyFailLoanNo,
      'pkmrctoductList': instance.pkmrctoductList,
      'lkmoctanProduct': instance.lkmoctanProduct,
    };
