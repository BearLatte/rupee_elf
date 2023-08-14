import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';

part 'face_liveness_parameters.g.dart';

@JsonSerializable()
class FaceLivenessParameters extends BaseModel {
  @JsonKey(name: 'akmcctcuauthId')
  String accuauthId;

  @JsonKey(name: 'akmcctcuauthSecret')
  String accuauthSecret;

  @JsonKey(name: 'akmcctcuauthHostUrl')
  String accuauthHostUrl;

  FaceLivenessParameters(
    this.accuauthId,
    this.accuauthSecret,
    this.accuauthHostUrl,
  ) : super(0, '');

  factory FaceLivenessParameters.fromJson(Map<String, dynamic> srcJson) =>
      _$FaceLivenessParametersFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$FaceLivenessParametersToJson(this);
}
