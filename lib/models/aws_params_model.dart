import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/aws_credentials.dart';
import 'package:rupee_elf/models/base_model.dart';

part 'aws_params_model.g.dart';

@JsonSerializable()
class AwsParamsModel extends BaseModel {
  @JsonKey(name: 'akmwctsBucket')
  String awsBucket;

  @JsonKey(name: 'akmwctsRegion')
  String awsRegion;

  @JsonKey(name: 'ckmrctedentials')
  AwsCredentials credentials;

  AwsParamsModel(
    this.awsBucket,
    this.awsRegion,
    this.credentials,
  ) : super(0, '');

  factory AwsParamsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AwsParamsModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$AwsParamsModelToJson(this);
}
