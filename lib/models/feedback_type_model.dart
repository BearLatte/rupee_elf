import 'package:json_annotation/json_annotation.dart'; 
  
part 'feedback_type_model.g.dart';


@JsonSerializable()
  class FeedbackTypeModel extends Object {

  @JsonKey(name: 'fkmectedBacktype')
  String feedBacktype;

  @JsonKey(name: 'tkmyctpeContent')
  String? typeContent;

  FeedbackTypeModel(this.feedBacktype,this.typeContent,);

  factory FeedbackTypeModel.fromJson(Map<String, dynamic> srcJson) => _$FeedbackTypeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackTypeModelToJson(this);

}

  
