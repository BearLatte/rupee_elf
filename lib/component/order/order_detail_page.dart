import 'package:flutter/material.dart';
// import 'package:rupee_elf/component/order/order_item_list_page.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderNumber;
  const OrderDetailPage({super.key, required this.orderNumber});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late String _title;
  // OrderType _type = OrderType.denied;
  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(title: _title);
  }
}
