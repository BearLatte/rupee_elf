import 'package:fluro/fluro.dart';
import 'package:rupee_elf/component/auth/auth_fourth_page.dart';
import 'package:rupee_elf/component/auth/auth_second_page.dart';
import 'package:rupee_elf/component/auth/auth_third_page.dart';
import 'package:rupee_elf/component/auth/face_auth_page.dart';
import 'package:rupee_elf/component/auth/simple_toast_page.dart';
import 'package:rupee_elf/component/product/product_purchase_successed_page.dart';
import 'package:rupee_elf/component/profile/profile_about_us_page.dart';
import 'package:rupee_elf/component/profile/profile_page.dart';
import 'package:rupee_elf/widgets/not_found_page.dart';
import 'package:rupee_elf/component/auth/auth_first_page.dart';
import 'package:rupee_elf/component/home/index.dart';
import 'package:rupee_elf/component/login/index.dart';
import 'package:rupee_elf/component/product/product_detail.dart';

class RouterManager {
  // 定义路由名称
  static String home = '/';
  static String login = '/login';

  // 身份认证
  static String authFirst = '/authFirst';
  static String authSecond = '/authSecond';
  static String authThird = '/authThird';
  static String authFourth = '/authFourth';
  static String authSimple = '/authSimple';
  static String authFace = '/faceAuth';

  // 产品相关
  static String productDetail = '/productDetail/:productId';
  static String productPurchaseSuccessed = '/productPurchaseSuccessed';

  // profile
  static String profile = '/profile';
  static String aboutUs = '/aboutUs';

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

  static final Handler _authFirstHandler =
      Handler(handlerFunc: (context, parametes) {
    return const AuthFirstPage();
  });

  static final Handler _authSecondHandler =
      Handler(handlerFunc: (context, parametes) {
    return const AuthSecondPage();
  });

  static final Handler _authThirdHandler =
      Handler(handlerFunc: (context, parametes) {
    return const AuthThirdPage();
  });

  static final Handler _authFourthHandler =
      Handler(handlerFunc: (context, parametes) {
    return const AuthFourthPage();
  });

  static final Handler _authSimpleHandler =
      Handler(handlerFunc: (context, parametes) {
    return const SimpleToastPage();
  });

  static final Handler _authFaceHandler =
      Handler(handlerFunc: (context, parametes) {
    return const FaceAuthPage();
  });

  // 产品详情
  static final Handler _productDetailHandler =
      Handler(handlerFunc: (context, parametes) {
    return ProductDetailPage(
      productId: parametes['productId']![0],
    );
  });

  static final Handler _productPurchaseSuccessedHandler =
      Handler(handlerFunc: (context, parametes) {
    return const ProductPurchaseSuccessedPage();
  });

  static final Handler _profileHandler =
      Handler(handlerFunc: (context, parametes) {
    return const ProfilePage();
  });
  static final Handler _aboutUsHandler =
      Handler(handlerFunc: (context, parametes) {
    return const ProfileAboutUsPage();
  });

  static final Handler _notFoundHandler =
      Handler(handlerFunc: (context, parameters) {
    return const NotFoundPage();
  });

  // 管理路由名称和处理函数
  static void defineRoutes(FluroRouter router) {
    router.define(
      home,
      handler: _homeHandler,
      transitionType: TransitionType.cupertino,
    );

    router.define(
      login,
      handler: _loginHandler,
    );

    router.define(
      authFirst,
      handler: _authFirstHandler,
    );

    router.define(
      authSimple,
      handler: _authSimpleHandler,
    );

    router.define(
      authSecond,
      handler: _authSecondHandler,
      transitionType: TransitionType.cupertino,
    );

    router.define(
      authThird,
      handler: _authThirdHandler,
      transitionType: TransitionType.cupertino,
    );

    router.define(
      authFourth,
      handler: _authFourthHandler,
      transitionType: TransitionType.cupertino,
    );

    router.define(
      authFace,
      handler: _authFaceHandler,
      transitionType: TransitionType.cupertino,
    );

    router.define(
      productPurchaseSuccessed,
      handler: _productPurchaseSuccessedHandler,
      transitionType: TransitionType.cupertino,
    );

    router.define(
      profile,
      handler: _profileHandler,
    );

    router.define(
      aboutUs,
      handler: _aboutUsHandler,
      transitionType: TransitionType.cupertino,
    );

    router.define(
      productDetail,
      handler: _productDetailHandler,
      transitionType: TransitionType.cupertino,
    );

    router.notFoundHandler = _notFoundHandler;
  }
}
