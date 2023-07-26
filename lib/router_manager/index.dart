import 'package:fluro/fluro.dart';
import 'package:rupee_elf/common/not_found_page.dart';
import 'package:rupee_elf/component/home/index.dart';
import 'package:rupee_elf/component/login/index.dart';
import 'package:rupee_elf/component/product/product_detail.dart';

class RouterManager {
  // 定义路由名称
  static String home = '/';
  static String login = '/login';
  static String productDetail = '/productDetail/:productId';

  // 定义路由处理函数

  /// 主页
  static final Handler _homeHandler =
      Handler(handlerFunc: (context, parametes) {
    return const HomePage();
  });

  static final Handler _loginHandler =
      Handler(handlerFunc: (context, parametes) {
    return const LoginPage();
  });

  // 产品详情
  static final Handler _productDetailHandler =
      Handler(handlerFunc: (context, parametes) {
    return ProductDetailPage(
      productId: parametes['productId']![0],
    );
  });

  static final Handler _notFoundHandler =
      Handler(handlerFunc: (context, parameters) {
    return const NotFoundPage();
  });

  // 管理路由名称和处理函数
  static void defineRoutes(FluroRouter router) {
    router.define(home,
        handler: _homeHandler, transitionType: TransitionType.cupertino);
    router.define(login, handler: _loginHandler);
    router.define(productDetail,
        handler: _productDetailHandler,
        transitionType: TransitionType.cupertino);
    router.notFoundHandler = _notFoundHandler;
  }
}
