import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/feedback_type_model.dart';
import 'package:rupee_elf/models/order_model.dart';
import 'package:rupee_elf/models/order_statistics_model.dart'; 
  
part 'order_list_model.g.dart';


@JsonSerializable()
  class OrderListModel extends BaseModel {

  @JsonKey(name: 'okmrctderGroup')
  OrderStatisticsModel orderGroup;

  @JsonKey(name: 'okmrctderList')
  List<OrderModel> orderList;

  @JsonKey(name: 'fkmectedBackTypes')
  List<FeedbackTypeModel> feedBackTypes;

  OrderListModel(this.orderGroup,this.orderList,this.feedBackTypes,) : super(0, '');

  factory OrderListModel.fromJson(Map<String, dynamic> srcJson) => _$OrderListModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$OrderListModelToJson(this);

}