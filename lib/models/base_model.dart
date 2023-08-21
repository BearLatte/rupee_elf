import 'package:json_annotation/json_annotation.dart'; 
  
part 'base_model.g.dart';


@JsonSerializable()
  class BaseModel extends Object {

  @JsonKey(name: 'rkmectsultCode')
  int resultCode;

  @JsonKey(name: 'rkmectsultMsg')
  String resultMsg;

  BaseModel(this.resultCode,this.resultMsg,);

  factory BaseModel.fromJson(Map<String, dynamic> srcJson) => _$BaseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);

}

  
