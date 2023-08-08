import 'package:json_annotation/json_annotation.dart'; 
  
part 'aws_credentials.g.dart';


@JsonSerializable()
  class AwsCredentials extends Object {

  @JsonKey(name: 'accessKeyId')
  String accessKeyId;

  @JsonKey(name: 'secretAccessKey')
  String secretAccessKey;

  @JsonKey(name: 'sessionToken')
  String sessionToken;

  @JsonKey(name: 'expiration')
  int expiration;

  AwsCredentials(this.accessKeyId,this.secretAccessKey,this.sessionToken,this.expiration,);

  factory AwsCredentials.fromJson(Map<String, dynamic> srcJson) => _$AwsCredentialsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AwsCredentialsToJson(this);

}

  
