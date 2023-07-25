
import 'package:fluro/fluro.dart';
import 'package:rupee_elf/common/not_found_page.dart';
import 'package:rupee_elf/home/index.dart';

class RouterManager {
  // 定义路由名称
  static String home = '/';

  // 定义路由处理函数
  static final Handler _homeHandler = Handler(handlerFunc: (context, parametes) {
    return const HomePage();
  });

  static final Handler _notFoundHandler = Handler(handlerFunc: (context, parameters){
    return const NotFoundPage();
  });

  // 管理路由名称和处理函数
  static void defineRoutes(FluroRouter router) {
    router.define(home, handler: _homeHandler, transitionType: TransitionType.cupertino);
    router.notFoundHandler = _notFoundHandler;
  }
}