import 'package:json_annotation/json_annotation.dart'; 
  
part 'empty_network_result.g.dart';


@JsonSerializable()
  class EmptyNetworkResult extends Object {

  @JsonKey(name: 'rkmectsultCode')
  int rkmectsultCode;

  @JsonKey(name: 'rkmectsultMsg')
  String rkmectsultMsg;

  EmptyNetworkResult(this.rkmectsultCode,this.rkmectsultMsg,);

  factory EmptyNetworkResult.fromJson(Map<String, dynamic> srcJson) => _$EmptyNetworkResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EmptyNetworkResultToJson(this);

}

  
