import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rupee_elf/router_manager/index.dart';
import 'package:rupee_elf/util/constants.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    // 配置路由
    FluroRouter router = FluroRouter();
    RouterManager.defineRoutes(router);
    return MaterialApp(
      onGenerateRoute: router.generator,
      theme: ThemeData(
        colorScheme:
            const ColorScheme.light().copyWith(primary: Constants.themeColor),
      ),
      builder: EasyLoading.init(),
    );
  }

 
}
