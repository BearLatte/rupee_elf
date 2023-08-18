import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/order/order_item_list_page.dart';
import 'package:rupee_elf/models/order_model.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/hexcolor.dart';

class OrderItemCell extends StatelessWidget {
  final OrderModel item;
  final bool isTopCornerRadius;
  final bool isBottomCornerRasius;
  final bool isHasDivider;
  final void Function()? onTap;
  final void Function()? iconOnPressed;

  const OrderItemCell({
    super.key,
    required this.item,
    required this.isTopCornerRadius,
    required this.isBottomCornerRasius,
    required this.isHasDivider,
    this.onTap,
    this.iconOnPressed,
  });

  OrderType convertTypeWithStatus(int status) {
    if (status == 1) {
      return OrderType.pending;
    } else if (status == 2) {
      return OrderType.disbursing;
    } else if (status == 3) {
      return OrderType.unrepay;
    } else if (status == 4) {
      return OrderType.repaied;
    } else if (status == 5) {
      return OrderType.disbursingFail;
    } else if (status == 6) {
      return OrderType.overdue;
    }
    return OrderType.all;
  }

  @override
  Widget build(BuildContext context) {
    String typeString = '';
    Color typeStringColor;
    switch (convertTypeWithStatus(item.loanStatus)) {
      case OrderType.pending:
        typeString = 'Pending';
        typeStringColor = HexColor('#0994F0');
      case OrderType.disbursing:
        typeString = 'Disbursing';
        typeStringColor = HexColor('#51C181');
      case OrderType.unrepay:
        typeString = 'To be Repaid';
        typeStringColor = HexColor('#EF8E39');
      case OrderType.denied:
        typeString = 'Denied';
        typeStringColor = HexColor('#FA58E1');
      case OrderType.disbursingFail:
        typeString = 'Disbursing Fail';
        typeStringColor = HexColor('#FA58E1');
      case OrderType.overdue:
        typeString = 'Overdue';
        typeStringColor = HexColor('#F42040');
      case OrderType.repaied:
        typeString = 'Repaied';
        typeStringColor = Constants.seconaryTextColor;
      default:
        typeStringColor = Constants.seconaryTextColor;
        break;
    }
    TextStyle typeStringStyle = TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: typeStringColor);
    return Container(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isTopCornerRadius ? 20.0 : 0),
          topRight: Radius.circular(isTopCornerRadius ? 20.0 : 0),
          bottomLeft: Radius.circular(isBottomCornerRasius ? 20.0 : 0),
          bottomRight: Radius.circular(isBottomCornerRasius ? 20.0 : 0),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: CommonImage(
                    src: item.productLogo,
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10.0)),
                Text(
                  item.productName,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Constants.themeTextColor,
                  ),
                ),
                const Spacer(),
                Text(typeString, style: typeStringStyle)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      children: [
                        Text(
                          'Loan Date :',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Constants.seconaryTextColor,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10.0)),
                        Text(
                          item.loanApplyDate,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Constants.themeTextColor,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Loan amount :',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Constants.seconaryTextColor,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10.0)),
                        Text(
                          '${item.loanAmount}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Constants.themeColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: iconOnPressed,
                  child: const CommonImage(
                      src: 'static/icons/order_earphone_icon.png'),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Order Number :',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Constants.seconaryTextColor,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                Expanded(
                  child: Text(
                    item.loanOrderNo,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Constants.themeTextColor,
                    ),
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20.0)),
            if (isHasDivider) const Divider(),
          ],
        ),
      ),
    );
  }
}
