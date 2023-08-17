import 'package:json_annotation/json_annotation.dart'; 
  
part 'order_statistics_model.g.dart';


@JsonSerializable()
  class OrderStatisticsModel extends Object {

  @JsonKey(name: 'lkmoctanAllNum')
  int loanAllNum;

  @JsonKey(name: 'lkmoctanAuditNum')
  int loanAuditNum;

  @JsonKey(name: 'lkmoctanPayNum')
  int loanPayNum;

  @JsonKey(name: 'lkmoctanRepayNum')
  int loanRepayNum;

  @JsonKey(name: 'lkmoctanFinishedNum')
  int loanFinishedNum;

  @JsonKey(name: 'lkmoctanFailNum')
  int loanFailNum;

  @JsonKey(name: 'lkmoctanOverdueNum')
  int loanOverdueNum;

  OrderStatisticsModel(this.loanAllNum,this.loanAuditNum,this.loanPayNum,this.loanRepayNum,this.loanFinishedNum,this.loanFailNum,this.loanOverdueNum,);

  factory OrderStatisticsModel.fromJson(Map<String, dynamic> srcJson) => _$OrderStatisticsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderStatisticsModelToJson(this);

}

  
