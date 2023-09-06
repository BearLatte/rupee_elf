import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/models/repay_extension_model.dart';
import 'package:rupee_elf/models/repay_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/adjust_track_tool.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';
import 'package:rupee_elf/widgets/theme_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExtensionRepayPage extends StatefulWidget {
  final String orderNumber;
  const ExtensionRepayPage({super.key, required this.orderNumber});

  @override
  State<ExtensionRepayPage> createState() => _ExtensionRepayPageState();
}

class _ExtensionRepayPageState extends State<ExtensionRepayPage>
    with WidgetsBindingObserver {
  RepayExtensionModel? _extensionDetail;
  @override
  void initState() {
    loadExtensionDetail();
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
        Navigator.of(context).pop();
        break;
      default:
        break;
    }
  }

  void loadExtensionDetail() async {
    RepayExtensionModel? model =
        await NetworkService.fetchExtensionRepayDetail(widget.orderNumber);
    if (model != null) {
      setState(() {
        _extensionDetail = model;
      });
    }
  }

  void go2extension() async {
    ADJustTrackTool.trackWith('ks0x5b');
    if (_extensionDetail == null) return;
    RepayModel? model = await NetworkService.fetchRepayPath(
      _extensionDetail!.loanOrderNo,
      'extend',
      _extensionDetail!.loanRepayDate,
    );
    if (model != null) {
      if (await canLaunchUrlString(model.repayPath)) {
        await launchUrlString(model.repayPath,
            mode: model.webviewType == 1
                ? LaunchMode.inAppWebView
                : LaunchMode.externalApplication);
      } else {
        await CommonToast.showToast('Can not open the repay address!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'Repay Extension',
      child: _extensionDetail == null
          ? Container()
          : Stack(
              children: [
                // 背景
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                    ),
                    Expanded(
                        child: Container(
                      color: Constants.seconaryBackgroundColor,
                    ))
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 34.0),
                  child: Column(
                    children: [
                      const Text(
                        'Pay extension fee to make repayment later',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: HexColor('#FFE6D8'),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: CommonImage(
                                    src: _extensionDetail!.productLogo,
                                    width: 40.0,
                                    height: 40.0,
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 14.0)),
                                Text(
                                  _extensionDetail!.productName,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: Constants.themeTextColor,
                                  ),
                                )
                              ],
                            ),
                            _itemRowWith('Extension Fee : ',
                                '₹ ${_extensionDetail!.extendFee}'),
                            _itemRowWith('Extension Term : ',
                                '${_extensionDetail!.extendDays} days'),
                            _itemRowWith('Next Repayment Date : ',
                                _extensionDetail!.extendRepayDate),
                            _itemRowWith('Repayment Amount : ',
                                '₹ ${_extensionDetail!.loanRepayAmount}'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ThemeButton(
                        width: 252.0,
                        height: 52.0,
                        title: 'Extension now',
                        onPressed: go2extension,
                      )
                    ],
                  ),
                )
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
}
