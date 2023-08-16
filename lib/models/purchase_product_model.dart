import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/product_model.dart';

part 'purchase_product_model.g.dart';

@JsonSerializable()
class PurchaseProductModel extends BaseModel {
  @JsonKey(name: 'ikmsctFirstApply')
  int? isFirstApply;

  @JsonKey(name: 'pkmrctoductList')
  List<ProductModel>? productList;

  PurchaseProductModel(
    this.isFirstApply,
    this.productList,
  ) : super(0, '');

  factory PurchaseProductModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PurchaseProductModelFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$PurchaseProductModelToJson(this);
}
