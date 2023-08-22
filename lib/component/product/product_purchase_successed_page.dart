import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/home/product_item_cell.dart';
import 'package:rupee_elf/models/product_model.dart';
import 'package:rupee_elf/models/space_detail_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class ProductPurchaseSuccessedPage extends StatefulWidget {
  final List<ProductModel> products;
  const ProductPurchaseSuccessedPage({super.key, this.products = const []});

  @override
  State<ProductPurchaseSuccessedPage> createState() =>
      _ProductPurchaseSuccessedPageState();
}

class _ProductPurchaseSuccessedPageState
    extends State<ProductPurchaseSuccessedPage> {
  void itemCellOnTap(String productId) async {
    SpaceDetailModel? model =
        await NetworkService.checkUserSpaceDetail(productId);
    if (model == null) return;
    if (model.spaceStatus == 2) {
      if (context.mounted) {
        Navigator.pushNamed(context, '/productDetail',
            arguments: model.loanProduct);
      }
    } else {
      if (context.mounted) {
        Navigator.of(context)
            .pushNamed('/orderDetail/${model.orderInfo?.loanOrderNo}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'Detail',
      child: Container(
        margin: const EdgeInsets.only(top: 88),
        width: MediaQuery.of(context).size.width,
        color: HexColor('F5F4F3'),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            const Positioned(
              top: -74.0,
              child: CommonImage(src: 'static/icons/alert_successed_icon.png'),
            ),
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 56.0)),
                Text(
                  'You have successfully applied',
                  style: TextStyle(
                      fontSize: 16.0, color: Constants.themeTextColor),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Constants.themeColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  margin: const EdgeInsets.only(
                    top: 14.0,
                    left: 12.0,
                    bottom: 14.0,
                    right: 12.0,
                  ),
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 34.0,
                    bottom: 16.0,
                    right: 34.0,
                  ),
                  child: const Text(
                    'You can now apply for other loan products.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                      children: widget.products
                          .map(
                            (item) => ProductItemCell(
                              isOdd: widget.products.indexOf(item) % 2 == 0,
                              product: item,
                              onTap: () {
                                itemCellOnTap(item.productId.toString());
                              },
                            ),
                          )
                          .toList()),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
