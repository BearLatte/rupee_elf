import 'package:json_annotation/json_annotation.dart'; 
  
part 'feedback_item_model.g.dart';


@JsonSerializable()
  class FeedbackItemModel extends Object {

  @JsonKey(name: 'lkmoctanOrderNo')
  String loanOrderNo;

  @JsonKey(name: 'pkmrctoductLogo')
  String productLogo;

  @JsonKey(name: 'pkmrctoductName')
  String productName;

  @JsonKey(name: 'fkmectedBackType')
  String feedBackType;

  @JsonKey(name: 'fkmectedBackContent')
  String feedBackContent;

  @JsonKey(name: 'fkmectedBackImg')
  String? feedBackImg;

  @JsonKey(name: 'rkmectplyContent')
  String? replyContent;

  @JsonKey(name: 'rkmectplyTime')
  String? replyTime;

  @JsonKey(name: 'fkmectedBackState')
  int feedBackState;

  @JsonKey(name: 'fkmectedBackTime')
  String feedBackTime;

  FeedbackItemModel(this.loanOrderNo,this.productLogo,this.productName,this.feedBackType,this.feedBackContent,this.feedBackImg,this.replyContent,this.replyTime,this.feedBackState,this.feedBackTime,);

  factory FeedbackItemModel.fromJson(Map<String, dynamic> srcJson) => _$FeedbackItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackItemModelToJson(this);

}

  
