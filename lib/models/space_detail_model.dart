import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/order_detail_model.dart';
import 'package:rupee_elf/models/product_detail_model.dart';
import 'package:rupee_elf/models/product_model.dart';
  
part 'space_detail_model.g.dart';


@JsonSerializable()
  class SpaceDetailModel extends BaseModel {

  @JsonKey(name: 'skmpctaceStatus')
  int spaceStatus;

  @JsonKey(name: 'lkmoctanProduct')
  ProductDetailModel? loanProduct;

  @JsonKey(name: 'pkmrctoductList')
  List<ProductModel>? productList;

  @JsonKey(name: 'okmrctderInfo')
  OrderDetailModel? orderInfo;

  SpaceDetailModel(this.spaceStatus,this.loanProduct,this.productList,this.orderInfo,) : super(0, '');

  factory SpaceDetailModel.fromJson(Map<String, dynamic> srcJson) => _$SpaceDetailModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$SpaceDetailModelToJson(this);
}

  
