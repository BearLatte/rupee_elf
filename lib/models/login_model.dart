import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Object {
  @JsonKey(name: 'rkmectsultCode')
  int rkmectsultCode;

  @JsonKey(name: 'rkmectsultMsg')
  String rkmectsultMsg;

  @JsonKey(name: 'lkmoctginToken')
  String? lkmoctginToken;

  @JsonKey(name: 'ikmsctRegistered')
  int? ikmsctRegistered;

  LoginModel(
    this.rkmectsultCode,
    this.rkmectsultMsg,
    this.lkmoctginToken,
    this.ikmsctRegistered,
  );

  factory LoginModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}