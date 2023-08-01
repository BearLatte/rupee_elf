import 'package:flutter/material.dart';
import 'package:rupee_elf/component/order/order_item_cell.dart';
import 'package:rupee_elf/component/order/order_item_data.dart';

enum OrderType {
  all,
  pending,
  disbursing,
  unrepay,
  denied,
  disbursingFail,
  overdue,
  repaied
}

class OrderItemListPage extends StatelessWidget {
  final OrderType type;

  const OrderItemListPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
      children: List.generate(
        orderItemData.length,
        (index) {
          return OrderItemCell(
            item: orderItemData[index],
            isTopCornerRadius: index == 0,
            isBottomCornerRasius: index == (orderItemData.length - 1),
            isHasDivider: index != (orderItemData.length - 1),
          );
        },
      ),
    );
  }
}
