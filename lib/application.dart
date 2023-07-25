import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:rupee_elf/router_manager/index.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    // 配置路由
    FluroRouter router = FluroRouter();
    RouterManager.defineRoutes(router);
    return MaterialApp(
      onGenerateRoute: router.generator,
    );
  }
}