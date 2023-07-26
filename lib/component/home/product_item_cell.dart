import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/home/product_item_data.dart';
import 'package:rupee_elf/util/global.dart';

class ProductItemCell extends StatelessWidget {
  final bool isOdd;
  final ProductItem product;
  final GestureTapCallback? onTap;

  const ProductItemCell(
      {super.key, required this.isOdd, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 174.0,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 14.0, left: 12.0, right: 12.0),
        child: Stack(
          children: [
            Positioned(
              top: 32.0,
              child: Container(
                height: 128.0,
                width: MediaQuery.of(context).size.width - 24,
                padding:
                    const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (isOdd) Container(width: 78.0),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.productName,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Global.themeTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 60.0,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Global.borderColor, width: 1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const CommonImage(
                                      src: 'static/icons/home_star_icon.png',
                                      width: 14,
                                      height: 14,
                                    ),
                                    Text(
                                      product.score,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Global.themeTextColor),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isOdd) Container(width: 78),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.loanAmount,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Global.themeColor,
                          ),
                        ),
                        Text(
                          'Loan amount',
                          style: TextStyle(
                            color: Global.seconaryTextColor,
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: isOdd ? 24 : null,
              right: isOdd ? null : 24,
              child: ClipOval(
                child: CommonImage(
                  src: product.imageUrl,
                  width: 68.0,
                  height: 68.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
