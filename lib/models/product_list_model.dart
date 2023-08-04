import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_elf/models/product_model.dart'; 
  
part 'product_list_model.g.dart';


@JsonSerializable()
  class ProductListModel extends Object {

  @JsonKey(name: 'rkmectsultCode')
  int rkmectsultCode;

  @JsonKey(name: 'rkmectsultMsg')
  String rkmectsultMsg;

  @JsonKey(name: 'pkmrctoductList')
  List<ProductModel> pkmrctoductList;

  ProductListModel(this.rkmectsultCode,this.rkmectsultMsg,this.pkmrctoductList,);

  factory ProductListModel.fromJson(Map<String, dynamic> srcJson) => _$ProductListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductListModelToJson(this);

}

  


  
