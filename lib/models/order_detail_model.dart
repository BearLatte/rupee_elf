import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart'; 
  
part 'order_detail_model.g.dart';

@JsonSerializable()
  class OrderDetailModel extends BaseModel {

  OrderDetailModel(super.rkmectsultCode, super.rkmectsultMsg);

  factory OrderDetailModel.fromJson(Map<String, dynamic> srcJson) => _$OrderDetailModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);

}

  
