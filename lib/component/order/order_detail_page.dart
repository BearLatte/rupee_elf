import 'package:flutter/material.dart';
import 'package:rupee_elf/models/order_detail_page_model.dart';
import 'package:rupee_elf/network_service/index.dart';
// import 'package:rupee_elf/component/order/order_item_list_page.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderNumber;
  const OrderDetailPage({super.key, required this.orderNumber});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final String _title = '';
  // OrderType _type = OrderType.denied;

  @override
  void initState() {
    loadOrderDetail();
    super.initState();
  }

  void loadOrderDetail() async {
    OrderDetailPageModel? model =
        await NetworkService.getOrderDetail(widget.orderNumber);
    if (model != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(title: _title);
  }
}
