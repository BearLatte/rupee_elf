import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event_success.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rupee_elf/router_manager/index.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/navigator_key.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    // 配置路由
    FluroRouter router = FluroRouter();
    RouterManager.defineRoutes(router);
    initAdjust();
    return MaterialApp(
      onGenerateRoute: router.generator,
      theme: ThemeData(
        colorScheme:
            const ColorScheme.light().copyWith(primary: Constants.themeColor),
      ),
      builder: EasyLoading.init(),
      navigatorKey: NavigatorKey.navKey,
    );
  }

  void initAdjust() {
    AdjustConfig config =
        AdjustConfig('z2j1wwnpt3i8', AdjustEnvironment.production);
    config.logLevel = AdjustLogLevel.verbose;
    config.defaultTracker = 'AppStore';
    config.allowAdServicesInfoReading = true;
    config.allowIdfaReading = true;
    config.deactivateSKAdNetworkHandling();
    config.linkMeEnabled = true;
    config.urlStrategy = AdjustConfig.UrlStrategyChina;

    config.eventSuccessCallback = (AdjustEventSuccess eventSuccessData) {
      debugPrint('[Adjust]: Event tracking success!');

      if (eventSuccessData.eventToken != null) {
        debugPrint('[Adjust]: Event token: ${eventSuccessData.eventToken}');
      }
      if (eventSuccessData.message != null) {
        debugPrint('[Adjust]: Message: ${eventSuccessData.message}');
      }
      if (eventSuccessData.timestamp != null) {
        debugPrint('[Adjust]: Timestamp: ${eventSuccessData.timestamp}');
      }
      if (eventSuccessData.adid != null) {
        debugPrint('[Adjust]: Adid: ${eventSuccessData.adid}');
      }
      if (eventSuccessData.callbackId != null) {
        debugPrint('[Adjust]: Callback ID: ${eventSuccessData.callbackId}');
      }
      if (eventSuccessData.jsonResponse != null) {
        debugPrint('[Adjust]: JSON response: ${eventSuccessData.jsonResponse}');
      }
    };
    Adjust.start(config);
  }
}
