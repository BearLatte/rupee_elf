// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackListModel _$FeedbackListModelFromJson(Map<String, dynamic> json) =>
    FeedbackListModel(
      (json['fkmectedBackList'] as List<dynamic>)
          .map((e) => FeedbackItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..resultCode = json['rkmectsultCode'] as int
      ..resultMsg = json['rkmectsultMsg'] as String;

Map<String, dynamic> _$FeedbackListModelToJson(FeedbackListModel instance) =>
    <String, dynamic>{
      'rkmectsultCode': instance.resultCode,
      'rkmectsultMsg': instance.resultMsg,
      'fkmectedBackList': instance.feedBackList,
    };
