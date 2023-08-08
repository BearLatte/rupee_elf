import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/aws_credentials.dart';
import 'package:rupee_elf/models/base_model.dart';

part 'aws_params_model.g.dart';

@JsonSerializable()
class AwsParamsModel extends BaseModel {
  @JsonKey(name: 'akmwctsBucket')
  String akmwctsBucket;

  @JsonKey(name: 'akmwctsRegion')
  String akmwctsRegion;
  
  @JsonKey(name: 'ckmrctedentials')
  AwsCredentials ckmrctedentials;

  @JsonKey(name: 'akmwctsHttp')
  String akmwctsHttp;

  AwsParamsModel(
    this.akmwctsBucket,
    this.akmwctsRegion,
    this.ckmrctedentials,
    this.akmwctsHttp,
  ) : super(0, '');

  factory AwsParamsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AwsParamsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AwsParamsModelToJson(this);
}

  


  


