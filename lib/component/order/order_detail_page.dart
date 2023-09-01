import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/home/product_item_cell.dart';
import 'package:rupee_elf/models/order_detail_model.dart';
import 'package:rupee_elf/models/order_detail_page_model.dart';
import 'package:rupee_elf/models/product_model.dart';
import 'package:rupee_elf/models/repay_model.dart';
import 'package:rupee_elf/models/space_detail_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/adjust_track_tool.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';
import 'package:rupee_elf/widgets/theme_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../util/hexcolor.dart';

enum OrderDetailPageType {
  pending,
  disbursing,
  denied,
  overfreezing,
  disbursingFailed,
  unrepay,
  overdue,
  repaied,
  repaiedOverdue
}

class OrderDetailPage extends StatefulWidget {
  final String orderNumber;
  const OrderDetailPage({super.key, required this.orderNumber});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>
    with WidgetsBindingObserver {
  String _title = '';
  OrderDetailPageType _type = OrderDetailPageType.pending;
  OrderDetailModel? _orderInfo;
  List<ProductModel>? _products;

  @override
  void initState() {
    loadOrderDetail();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        loadOrderDetail();
        break;
      default:
        break;
    }
  }

  void loadOrderDetail() async {
    OrderDetailPageModel? model =
        await NetworkService.fetchOrderDetail(widget.orderNumber);

    if (model != null) {
      OrderDetailModel orderInfo = model.orderInfo!;
      _products = model.productList;
      String title = '';
      OrderDetailPageType type = OrderDetailPageType.pending;
      switch (orderInfo.loanStatus) {
        case 1:
          title = 'Pending';
          type = OrderDetailPageType.pending;
        case 2:
          title = 'Disbursing';
          type = OrderDetailPageType.disbursing;
        case 3:
          title = 'To be Repaid';
          type = OrderDetailPageType.unrepay;
        case 4:
          title = 'Repaid';
          if (orderInfo.overdueDays! > 0) {
            type = OrderDetailPageType.repaiedOverdue;
          } else {
            type = OrderDetailPageType.repaied;
          }
        case 5:
          if (orderInfo.isPayFail == 1) {
            title = 'Disbursing Fail';
            type = OrderDetailPageType.disbursingFailed;
          }
          if (orderInfo.isPayFail == 0 && (orderInfo.freezeDays ?? 0) > 0) {
            title = 'Denied';
            type = OrderDetailPageType.denied;
          }

          if (orderInfo.isPayFail == 0 && orderInfo.freezeDays == 0) {
            title = 'Detail';
            type = OrderDetailPageType.overfreezing;
          }
        case 6:
          title = 'Overdue';
          type = OrderDetailPageType.overdue;
      }

      setState(() {
        _title = title;
        _type = type;
        _orderInfo = orderInfo;
      });
    }
  }

  void repayAction() async {
    if (_type == OrderDetailPageType.unrepay) {
      ADJustTrackTool.trackWith('pgszkb');
    }

    if (_type == OrderDetailPageType.overdue) {
      ADJustTrackTool.trackWith('bgjuhh');
    }

    if (_orderInfo == null) return;
    RepayModel? model = await NetworkService.fetchRepayPath(
        _orderInfo!.loanOrderNo, 'all', _orderInfo!.loanPayDate!);

    if (model != null) {
      if (await canLaunchUrlString(model.repayPath)) {
        await launchUrlString(model.repayPath,
            mode: LaunchMode.externalApplication);
      } else {
        await CommonToast.showToast('Can not open the repay address!');
      }
    }
  }

  void extensionRepayAction() {
    if (_type == OrderDetailPageType.unrepay) {
      ADJustTrackTool.trackWith('aio98u');
    }

    if (_type == OrderDetailPageType.overdue) {
      ADJustTrackTool.trackWith('onsfr2');
    }
    if (_orderInfo == null) return;
    Navigator.of(context)
        .pushNamed('/extensionRepay/${_orderInfo!.loanOrderNo}')
        .then((_) {
      loadOrderDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: _title,
      child: configContentView(_type),
    );
  }

  Widget configContentView(OrderDetailPageType type) {
    switch (type) {
      case OrderDetailPageType.pending:
      case OrderDetailPageType.disbursing:
      case OrderDetailPageType.disbursingFailed:
      case OrderDetailPageType.denied:
      case OrderDetailPageType.overfreezing:
        return _banerItem(type);
      case OrderDetailPageType.repaied:
      case OrderDetailPageType.repaiedOverdue:
        return _repaiedItem(type);
      case OrderDetailPageType.overdue:
      case OrderDetailPageType.unrepay:
        return _repayItem(type);
      default:
        return Container();
    }
  }

  Widget _banerItem(OrderDetailPageType type) {
    if (_orderInfo == null) return Container();
    String banerText = '';
    switch (type) {
      case OrderDetailPageType.pending:
        banerText =
            'We have received your loan application, and we will notify you as soon as the result is obtained. You can also apply for other products.';
      case OrderDetailPageType.disbursing:
        banerText =
            'Your loan application is being disbursed, we will process it and let you know.';
      case OrderDetailPageType.disbursingFailed:
        banerText =
            'Please confirm if your bank information is correct and reapply.';
      case OrderDetailPageType.denied:
        banerText =
            'Sorry, your application could not be approved. You can only reapply this product after ${_orderInfo!.freezeDays} days, or you can apply for another product right now.';
      case OrderDetailPageType.overfreezing:
        banerText = 'Congratulations, you can now apply for a loan now.';
      default:
        banerText = '';
    }
    return Stack(
      children: [
        // 背景
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom:
                      type == OrderDetailPageType.overfreezing ? 16.0 : 78.0),
              child: Text(
                banerText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: Constants.seconaryBackgroundColor,
            ))
          ],
        ),
        Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
              child: Text(
                banerText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.transparent,
                ),
              ),
            ),
            if (type != OrderDetailPageType.overfreezing)
              Container(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: HexColor('#FFE6D8'),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: CommonImage(
                              src: _orderInfo!.productLogo,
                              width: 40.0,
                              height: 40.0,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 14.0)),
                          Text(
                            _orderInfo!.productName,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Constants.themeTextColor,
                            ),
                          )
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      Text(
                        'Loan Amount: ₹  ${_orderInfo!.loanAmount}',
                        style: TextStyle(
                            fontSize: 16.0, color: Constants.themeTextColor),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      Text(
                        'Apply date : ${_orderInfo!.loanApplyDate}',
                        style: TextStyle(
                            fontSize: 16.0, color: Constants.themeTextColor),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      Text(
                        'Account : ${_orderInfo!.bankCardNo}',
                        style: TextStyle(
                            fontSize: 16.0, color: Constants.themeTextColor),
                      ),
                      if (type == OrderDetailPageType.disbursingFailed)
                        Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Order Number : ${_orderInfo!.loanOrderNo}',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Constants.themeTextColor),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            if (type != OrderDetailPageType.disbursingFailed)
              Expanded(
                child: productListView(),
              ),
          ],
        ),
      ],
    );
  }

  Widget _repaiedItem(OrderDetailPageType type) {
    if (_orderInfo == null) return Container();
    return Container(
      color: Constants.seconaryBackgroundColor,
      // padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: CommonImage(
                        src: _orderInfo!.productLogo,
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 14.0)),
                    Text(
                      _orderInfo!.productName,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Constants.themeTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                _itemRowWith('Order Number :', _orderInfo!.loanOrderNo),
                _itemRowWith('Loan Amount : ', '₹ ${_orderInfo!.loanAmount}'),
                _itemRowWith('Apply date :', _orderInfo!.loanApplyDate),
                if (type == OrderDetailPageType.repaiedOverdue)
                  _itemRowWith(
                      'Overdue Charge : ', '₹ ${_orderInfo!.overdueAmount}'),
                if (type == OrderDetailPageType.repaiedOverdue)
                  _itemRowWith(
                      'Overdue Days :', '${_orderInfo!.overdueDays ?? 0}'),
                _itemRowWith(
                    'Received Amount : ', '₹ ${_orderInfo!.loanPayAmount}'),
                _itemRowWith(
                    'Date of loan received : ', _orderInfo!.loanPayDate ?? ''),
                _itemRowWith(
                    'Repayment Amount : ', '₹ ${_orderInfo!.loanRepayAmount}'),
                _itemRowWith(
                    'Repayment Date :', _orderInfo!.loanRepayDate ?? ''),
              ],
            ),
          ),
          Expanded(
            child: productListView(),
          )
        ],
      ),
    );
  }

  Widget _repayItem(OrderDetailPageType type) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 34),
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: CommonImage(
                  src: _orderInfo!.productLogo,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 14.0)),
              Text(
                _orderInfo!.productName,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Constants.themeTextColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          _itemRowWith('Order Number :', _orderInfo!.loanOrderNo),
          _itemRowWith('Loan Amount : ', '₹ ${_orderInfo!.loanAmount}'),
          _itemRowWith('Apply date :', _orderInfo!.loanApplyDate),
          if (type == OrderDetailPageType.overdue)
            _itemRowWith('Overdue Charge : ', '₹ ${_orderInfo!.overdueAmount}'),
          if (type == OrderDetailPageType.overdue)
            _itemRowWith('Overdue Days :', '${_orderInfo!.overdueDays ?? 0}'),
          _itemRowWith('Received Amount : ', '₹ ${_orderInfo!.loanPayAmount}'),
          _itemRowWith('Received Amount : ', '₹ ${_orderInfo!.loanPayAmount}'),
          _itemRowWith(
              'Date of loan received : ', _orderInfo!.loanPayDate ?? ''),
          _itemRowWith(
              'Repayment Amount : ', '₹ ${_orderInfo!.loanRepayAmount}'),
          _itemRowWith('Repayment Date :', _orderInfo!.loanRepayDate ?? ''),
          const Spacer(),
          ThemeButton(
            width: 252.0,
            height: 52.0,
            title: 'Repay Now',
            onPressed: repayAction,
          ),
          if (_orderInfo?.extendButton == 1)
            Container(
              margin: const EdgeInsets.only(top: 12.0),
              child: ThemeButton(
                backgroundColor: HexColor('#F3925B'),
                width: 252.0,
                height: 52.0,
                title: 'Repay Extension',
                onPressed: extensionRepayAction,
              ),
            ),
        ],
      ),
    );
  }

  Widget _itemRowWith(String key, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: Row(children: [
        Text(
          key,
          style: TextStyle(
            fontSize: 16.0,
            color: Constants.seconaryTextColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            color: Constants.themeTextColor,
          ),
        )
      ]),
    );
  }

  Widget productListView() {
    if (_products == null) return Container();
    return ListView.builder(
      itemCount: _products?.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductItemCell(
          isOdd: index / 2 == 0,
          product: _products![index],
          onTap: () {
            itemCellOnTap(_products![index].productId.toString());
          },
        );
      },
    );
  }

  void itemCellOnTap(String productId) async {
    SpaceDetailModel? model =
        await NetworkService.checkUserSpaceDetail(productId);
    if (model == null) return;
    if (model.spaceStatus == 2) {
      if (context.mounted) {
        Navigator.pushNamed(context, '/productDetail', arguments: {'product' : model.loanProduct, 'isRecommend': false});
      }
    } else {
      if (context.mounted) {
        Navigator.of(context)
            .pushNamed('/orderDetail/${model.orderInfo?.loanOrderNo}');
      }
    }
  }
}
