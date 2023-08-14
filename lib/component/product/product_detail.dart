import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/models/product_detail_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/common_alert.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductDetailModel productDetail;

  const ProductDetailPage({super.key, required this.productDetail});

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
        ClipOval(
          child: CommonImage(
            width: 66.0,
            height: 66.0,
            src: productDetail.pkmrctoductLogo,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
        Text(
          productDetail.pkmrctoductName,
          style: const TextStyle(
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
              _itemCell(
                  key: 'Amount :', value: ' ₹ ${productDetail.lkmoctanAmount}'),
              _itemCell(
                  key: 'Terms :',
                  value: ' ${productDetail.lkmoctanOfDays} Days'),
              _itemCell(
                  key: 'Received Amount : ',
                  value: ' ₹ ${productDetail.lkmoctanPayAmount}'),
              _itemCell(
                  key: 'Verification Fee :',
                  value: ' ₹ ${productDetail.lkmoctanFeeVerify}'),
              _itemCell(
                  key: 'GST : ', value: ' ₹ ${productDetail.lkmoctanFeeGst}'),
              _itemCell(
                  key: 'Interest :',
                  value: ' ₹ ${productDetail.lkmoctanInterest}'),
              _itemCell(
                  key: 'Overdue Charge :',
                  value: ' ${productDetail.lkmoctanOverdue}/day'),
              _itemCell(
                key: 'Repayment Amount :',
                value: ' ₹ ${productDetail.lkmoctanRepayAmount}',
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
    bool isLiveness = await NetworkService.checkUserLiveness();
    if (isLiveness) {
      _configParamsAndPurchaseProduct();
    } else {
      if (context.mounted) {
        var isOk = await CommonAlert.showAlert(
          context: context,
          type: AlertType.tips,
          message: 'Please upload a selfie photo before continuing.',
        );
        if (isOk && context.mounted) {
          _go2Liveness(context);
        }
      }
    }
  }

  void _go2Liveness(BuildContext context) async {
    PermissionStatus state = await Permission.camera.request();
    if (state == PermissionStatus.granted && context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/faceAuth', (route) {
        return route.isFirst;
      });
    } else {
      await CommonToast.showToast(
          'You did not allow us to access the camera, which will help you obtain a loan. Would you like to set up authorization.');
    }
  }

  void _configParamsAndPurchaseProduct() async {}

  Widget _itemCell(
      {required String key, required String value, Color? valueColor}) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        Row(
          children: [
            Text(
              key,
              style:
                  TextStyle(color: Constants.seconaryTextColor, fontSize: 16.0),
            ),
            Text(
              value,
              style: TextStyle(
                  color: valueColor ?? Constants.themeTextColor,
                  fontSize: 16.0),
            )
          ],
        )
      ],
    );
  }
}
