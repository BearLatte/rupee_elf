import 'package:flutter/material.dart';
import 'package:rupee_elf/component/order/order_item_cell.dart';
import 'package:rupee_elf/models/order_list_model.dart';
import 'package:rupee_elf/models/order_model.dart';
import 'package:rupee_elf/network_service/index.dart';

// 订单状态 1待审核  2待放款  3待还款 4已还款 5失败 6已逾期
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

class OrderItemListPage extends StatefulWidget {
  final OrderType type;

  const OrderItemListPage({super.key, required this.type});

  @override
  State<OrderItemListPage> createState() => _OrderItemListPageState();
}

class _OrderItemListPageState extends State<OrderItemListPage> {
  late final OrderType _type;
  List<OrderModel> _orders = [];

  @override
  void initState() {
    super.initState();
    _type = widget.type;
    _getOrders();
  }

  void _getOrders() async {
    OrderListModel? model = await NetworkService.fetchOrderList(_type);

    if (model != null) {
      setState(() {
        _orders = model.orderList ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
      children: List.generate(
        _orders.length,
        (index) {
          return OrderItemCell(
            item: _orders[index],
            isTopCornerRadius: index == 0,
            isBottomCornerRasius: index == (_orders.length - 1),
            isHasDivider: index != (_orders.length - 1),
          );
        },
      ),
    );
  }
}
