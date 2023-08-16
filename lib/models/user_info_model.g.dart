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
      json['tkmhctirdLiveness'] as String?,
      json['ukmscterPayFail'] as int?,
      json['pkmactyFailLogo'] as String?,
      json['pkmactyFailContent'] as String?,
      json['pkmactyFailLoanName'] as String?,
      json['pkmactyFailLoanNo'] as String?,
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
      'ukmscterStatus': instance.userStatus,
      'pkmhctotoContent': instance.photoContent,
      'gkmpctsContent': instance.gpsContent,
      'pkmhctoneContent': instance.phoneContent,
      'ckmoctntactNum': instance.contactNum,
      'ukmscterLiveness': instance.userLiveness,
      'tkmhctirdLiveness': instance.thirdLiveness,
      'ukmscterPayFail': instance.userPayFail,
      'pkmactyFailLogo': instance.payFailLogo,
      'pkmactyFailContent': instance.payFailContent,
      'pkmactyFailLoanName': instance.payFailLoanName,
      'pkmactyFailLoanNo': instance.payFailLoanNo,
      'pkmrctoductList': instance.productList,
      'lkmoctanProduct': instance.loanProduct,
    };
