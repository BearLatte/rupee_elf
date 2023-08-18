import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/order_detail_model.dart';
import 'package:rupee_elf/models/product_model.dart';

part 'order_detail_page_model.g.dart';

@JsonSerializable()
class OrderDetailPageModel extends BaseModel {
  @JsonKey(name: 'pkmrctoductList')
  List<ProductModel>? productList;

  @JsonKey(name: 'okmrctderInfo')
  OrderDetailModel? orderInfo;

  OrderDetailPageModel(
    this.productList,
    this.orderInfo,
  ) : super(0, '');

  factory OrderDetailPageModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderDetailPageModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$OrderDetailPageModelToJson(this);
}
