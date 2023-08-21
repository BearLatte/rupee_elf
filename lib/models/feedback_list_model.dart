import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/feedback_item_model.dart';

part 'feedback_list_model.g.dart';

@JsonSerializable()
class FeedbackListModel extends BaseModel {
  @JsonKey(name: 'fkmectedBackList')
  List<FeedbackItemModel> feedBackList;

  FeedbackListModel(this.feedBackList) : super(0, '');

  factory FeedbackListModel.frontJson(Map<String, dynamic> srcJson) =>
      _$FeedbackListModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$FeedbackListModelToJson(this);
}
