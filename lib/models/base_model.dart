import 'package:json_annotation/json_annotation.dart'; 
  
part 'base_model.g.dart';


@JsonSerializable()
  class BaseModel extends Object {

  @JsonKey(name: 'rkmectsultCode')
  int rkmectsultCode;

  @JsonKey(name: 'rkmectsultMsg')
  String rkmectsultMsg;

  BaseModel(this.rkmectsultCode,this.rkmectsultMsg,);

  factory BaseModel.fromJson(Map<String, dynamic> srcJson) => _$BaseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);

}

  
