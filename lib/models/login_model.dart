import 'package:json_annotation/json_annotation.dart';
  
part 'login_model.g.dart';


@JsonSerializable()
  class LoginModel extends Object {

  @JsonKey(name: 'resultCode')
  int resultCode;

  @JsonKey(name: 'resultMsg')
  String resultMsg;

  @JsonKey(name: 'loginToken')
  String loginToken;

  @JsonKey(name: 'isRegistered')
  int isRegistered;

  LoginModel(this.resultCode,this.resultMsg,this.loginToken,this.isRegistered,);

  factory LoginModel.fromJson(dynamic srcJson) => _$LoginModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

  
