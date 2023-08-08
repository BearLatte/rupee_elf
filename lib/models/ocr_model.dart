import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart'; 
  
part 'ocr_model.g.dart';


@JsonSerializable()
  class OcrModel extends BaseModel {

  @JsonKey(name: 'ukmscterNames')
  String ukmscterNames;

  @JsonKey(name: 'akmactdhaarNumber')
  String akmactdhaarNumber;

  @JsonKey(name: 'ukmscterGender')
  String ukmscterGender;

  @JsonKey(name: 'dkmactteOfBirth')
  String dkmactteOfBirth;

  @JsonKey(name: 'akmdctdressDetail')
  String akmdctdressDetail;

  @JsonKey(name: 'pkmactnNumber')
  String pkmactnNumber;

  OcrModel(this.ukmscterNames,this.akmactdhaarNumber,this.ukmscterGender,this.dkmactteOfBirth,this.akmdctdressDetail,this.pkmactnNumber,) : super(0, '');

  factory OcrModel.fromJson(Map<String, dynamic> srcJson) => _$OcrModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OcrModelToJson(this);

}

  
