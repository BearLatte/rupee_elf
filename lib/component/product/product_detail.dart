import 'dart:convert';

import 'package:battery_plus/battery_plus.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/face_liveness_parameters.dart';
import 'package:rupee_elf/models/product_detail_model.dart';
import 'package:rupee_elf/models/purchase_product_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/common_alert.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';
import 'package:rupee_elf/widgets/theme_button.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductDetailModel productDetail;

  const ProductDetailPage({super.key, required this.productDetail});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // 与原生通信的消息对象
  final MethodChannel _methodChanel =
      const MethodChannel('com.product.detail.MethodChanel');

  @override
  void initState() {
    super.initState();

    _methodChanel.setMethodCallHandler((call) async {
      if (call.method == 'livenessCompleted') {
        BaseModel? model = await NetworkService.uploadImgAndAuthFace(
            call.arguments['imgPath'], call.arguments['score']);
        if (model != null) {
          bool isLiveness = await NetworkService.checkUserLiveness();
          if (isLiveness) {
            _configParamsAndPurchaseProduct();
          }
        }
      }
    });
  }

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
            src: widget.productDetail.pkmrctoductLogo,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
        Text(
          widget.productDetail.pkmrctoductName,
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
                  key: 'Amount :',
                  value: ' ₹ ${widget.productDetail.lkmoctanAmount}'),
              _itemCell(
                  key: 'Terms :',
                  value: ' ${widget.productDetail.lkmoctanOfDays} Days'),
              _itemCell(
                  key: 'Received Amount : ',
                  value: ' ₹ ${widget.productDetail.lkmoctanPayAmount}'),
              _itemCell(
                  key: 'Verification Fee :',
                  value: ' ₹ ${widget.productDetail.lkmoctanFeeVerify}'),
              _itemCell(
                  key: 'GST : ',
                  value: ' ₹ ${widget.productDetail.lkmoctanFeeGst}'),
              _itemCell(
                  key: 'Interest :',
                  value: ' ₹ ${widget.productDetail.lkmoctanInterest}'),
              _itemCell(
                  key: 'Overdue Charge :',
                  value: ' ${widget.productDetail.lkmoctanOverdue}/day'),
              _itemCell(
                key: 'Repayment Amount :',
                value: ' ₹ ${widget.productDetail.lkmoctanRepayAmount}',
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
          _go2Liveness();
        }
      }
    }
  }

  void _go2Liveness() async {
    PermissionStatus state = await Permission.camera.request();
    if (state == PermissionStatus.granted) {
      FaceLivenessParameters? params =
          await NetworkService.getFaceLivenessParams();
      if (params != null) {
        _methodChanel.invokeMapMethod('go2authFace', {
          'apiId': params.accuauthId,
          'hostUrl': params.accuauthHostUrl,
          'apiSecret': params.accuauthSecret
        });
      }
    } else {
      await CommonToast.showToast(
          'You did not allow us to access the camera, which will help you obtain a loan. Would you like to set up authorization.');
    }
  }

  void _configParamsAndPurchaseProduct() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);

    Map<String, dynamic> params = {
      'pYYroYductId': widget.productDetail.pkmrctoductId
    };

    Map<String, dynamic> loanData = {};
    Map<String, dynamic> userDevice = {};

    // 获取通讯录和定位
    if (Global.instance.currentAccount != Constants.CURRENT_PHONE_KEY) {
      var contactState = await Permission.contacts.request();
      if (contactState == PermissionStatus.granted) {
        List<Contact> contacts =
            await FlutterContacts.getContacts(withProperties: true);
        List<Map<String, Object>> phoneList = contacts
            .map((contact) => {
                  'number':
                      contact.phones.isEmpty ? '' : contact.phones.first.number,
                  'name': contact.displayName
                })
            .toList();

        loanData['phoneList'] = Global.instance.currentAccount == '3939393939' ? '' : phoneList;        
      } else {
        await CommonToast.showToast(
            'You did not allow us to access the contacts. Allowing it will help you obtain a loan. Do you want to set up authorization.');
        return;
      }

      var locationState = await Permission.location.request();
      if (locationState == PermissionStatus.granted) {
        userDevice['gpsEnabled'] = true;
        Position locationData = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        userDevice['latitude'] = locationData.latitude;
        userDevice['longitude'] = locationData.longitude;

        // 反地理编码原生
        var result = await _methodChanel.invokeMapMethod(
            'reverseGeocodeLocation', {
          'latitude': locationData.latitude,
          'longitude': locationData.longitude
        });
        userDevice['city'] = result?['city'];
        userDevice['state'] = result?['state'];
      } else {
        if (context.mounted) {
          bool isOk = await CommonAlert.showAlert(
            context: context,
            type: AlertType.tips,
            message:
                'This feature requires you to authorize this app to open the location service\nHow to set it: open phone Settings -> Privacy -> Location service',
          );
          if (isOk) {
            openAppSettings();
          }
        }
        return;
      }
    }

    userDevice['sysType'] = 'iOS';
    userDevice['name'] = Global.instance.packageInfo.appName;
    userDevice['applyChannel'] = 'AppStore';
    userDevice['idfa'] = Global.instance.idfa;
    userDevice['udid'] = Global.instance.allDeviceInfo.identifierForVendor;
    userDevice['idfv'] = Global.instance.allDeviceInfo.identifierForVendor;
    userDevice['appOpenTime'] =
        '${Global.instance.prefs.getInt(Constants.APP_LAUNCH_TIME)}';
    userDevice['bootTime'] =
        '${Global.instance.prefs.getInt(Constants.APP_LAUNCH_TIME)}';
    userDevice['time'] =
        '${DateTime.now().millisecondsSinceEpoch - Global.instance.prefs.getInt(Constants.APP_LAUNCH_TIME)}';
    userDevice['languageList'] = await Devicelocale.preferredLanguages;
    userDevice['timezone'] = await FlutterNativeTimezone.getLocalTimezone();
    userDevice['lowPowerModeEnabled'] = await Battery().isInBatterySaveMode;
    userDevice['autoBrightnessEnabled'] = await ScreenBrightness().isAutoReset;

    userDevice['debug'] = false;
    userDevice['networkType'] = await Global.instance.getNetworkType();
    userDevice['is4G'] = (await Global.instance.getNetworkType()) == '4G';
    userDevice['is5G'] = (await Global.instance.getNetworkType()) == '5G';

    // 从原生中获取设备存储信息
    var info = await _methodChanel.invokeMapMethod('getStoageInfo');
    userDevice['internalTotalStorage'] = info?['internalTotalStorage'];
    userDevice['internalUsableStorage'] = info?['internalUsableStorage'];
    userDevice['percentValue'] = info?['percentValue'];
    userDevice['ramTotalSize'] = info?['internalTotalStorage'];
    userDevice['ramTotalSize'] = info?['internalUsableStorage'];
    userDevice['model'] = info?['model'];
    userDevice['simulator'] = info?['model'] == 'Simulator';
    userDevice['release'] = Global.instance.allDeviceInfo.systemVersion;
    userDevice['versionCode'] = Global.instance.packageInfo.version;
    userDevice['brightness'] = info?['brightness'];
    if (context.mounted) {
      Size screenSize = MediaQuery.of(context).size;
      var ratio = MediaQuery.of(context).devicePixelRatio;
      MediaQueryData? data = MediaQuery.maybeOf(context).nonEmptySizeOrNull();

      userDevice['screenWidth'] = screenSize.width;
      userDevice['screenHeight'] = screenSize.height;
      userDevice['resolution'] =
          '${screenSize.width * ratio} * ${screenSize.height * ratio}';
      double deviceWidth = data?.size.width ?? 0;
      double deviceHeight = data?.size.height ?? 0;
      userDevice['physicalSize'] = '$deviceWidth*$deviceHeight';
    }

    userDevice['isPhone'] = Global.instance.allDeviceInfo.model == 'iPhone';
    userDevice['isTablet'] = Global.instance.allDeviceInfo.model == 'iPad';
    userDevice['batteryStatus'] = await Global.instance.getBatteryState();
    if (info?['model'] != 'Simulator') {
      int batteryLevel = await Battery().batteryLevel;
      userDevice['batteryLevel'] = batteryLevel;
      userDevice['batteryPct'] = '$batteryLevel%';
    }
    userDevice['batterySum'] = '100';
    userDevice['isCharging'] = (await Global.instance.getBatteryState()) == '2';

    loanData['userDevice'] = userDevice;
    params['lYYoaYnData'] = json.encode(loanData);

    PurchaseProductModel? model = await NetworkService.purchaseProduct(params);
    if (model != null) {
      if (model.isFirstApply == 1) {
        debugPrint('此处需要做首单埋点');
      }

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/productPurchaseSuccessed',
          (route) => route.isFirst,
          arguments: model.productList,
        );
      }
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

extension on MediaQueryData? {
  MediaQueryData? nonEmptySizeOrNull() {
    if (this?.size.isEmpty ?? true) {
      return null;
    } else {
      return this;
    }
  }
}
