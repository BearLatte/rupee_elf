import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/common_alert.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'Detail',
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 背景
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                color: Constants.seconaryBackgroundColor,
              )
            ],
          ),
          _contentWidget(context)
        ],
      ),
    );
  }

  Widget _contentWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(children: [
        const ClipOval(
          child: CommonImage(
            width: 66.0,
            height: 66.0,
            src:
                'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/009z-1550814812.jpg?crop=0.502xw:1.00xh;0.498xw,0&resize=640:*',
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
        const Text(
          'Rupee Star',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(
              top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              _itemCell(key: 'Amount :', value: ' ₹ 400,000.0'),
              _itemCell(key: 'Terms :', value: ' 200 Days'),
              _itemCell(key: 'Received Amount : ', value: ' ₹ 300,000.00'),
              _itemCell(key: 'Verification Fee :', value: ' ₹ 80,000.00'),
              _itemCell(key: 'GST : ', value: ' ₹ 20,000.00'),
              _itemCell(key: 'Interest :', value: ' ₹ 10,000.00'),
              _itemCell(key: 'Overdue Charge :', value: ' 3%/day'),
              _itemCell(
                key: 'Repayment Amount :',
                value: ' ₹ 401,000.00',
                valueColor: Constants.themeColor,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 50.0)),
              ThemeButton(
                width: 252.0,
                height: 52.0,
                title: 'Loan now',
                onPressed: () {
                  _loanNowBtnOnPressed(context);
                },
              )
            ],
          ),
        )
      ]),
    );
  }

  void _loanNowBtnOnPressed(BuildContext context) async {
    debugPrint('DEBUG: 此处为下单逻辑，需要做埋点');
    var isOk = await CommonAlert.showAlert(
      context: context,
      type: AlertType.tips,
      message: 'Please upload a selfie photo before continuing.',
    );
    if (isOk && context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/productPurchaseSuccessed',
          (route) {
        return route.isFirst;
      });
    }
  }

  Widget _itemCell(
      {required String key, required String value, Color? valueColor}) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        Row(
          children: [
            Text(
              key,
              style: TextStyle(color: Constants.seconaryTextColor, fontSize: 16.0),
            ),
            Text(
              value,
              style: TextStyle(
                  color: valueColor ?? Constants.themeTextColor, fontSize: 16.0),
            )
          ],
        )
      ],
    );
  }
}
