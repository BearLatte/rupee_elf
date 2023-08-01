import 'package:flutter/material.dart';
import 'package:rupee_elf/component/order/order_item_list_page.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  List<String> tabs = [
    'All orders',
    'Pending',
    'Disbursing',
    'To be Repaid',
    'Denied',
    'Disbursing Fail',
    'Overdue',
    'Repaid'
  ];
  late final TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'My orders',
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 14.0,
              left: 20.0,
              bottom: 16.0,
              right: 20.0,
            ),
            child: const Text(
              'Making repayments on time and continuing\nto apply are the keys to getting a higher\namount.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 34.0),
                  color: Global.seconaryBackgroundColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: HexColor('#FFE6D8'),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      height: 60.0,
                      width: MediaQuery.of(context).size.width - 24.0,
                      child: TabBar(
                        labelColor: HexColor('#F05C09'),
                        labelStyle: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                        unselectedLabelColor: HexColor('#F05C09').withAlpha(62),
                        unselectedLabelStyle: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                        isScrollable: true,
                        tabs: tabs.map((title) => Tab(text: title)).toList(),
                        controller: _controller,
                        indicatorColor: Colors.transparent,
                        labelPadding:
                            const EdgeInsets.only(left: 9.0, right: 9.0),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _controller,
                        children: List.generate(
                          tabs.length,
                          (index) => OrderItemListPage(
                            type: OrderType.values[index],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
