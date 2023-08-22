import 'package:adjust_sdk/adjust.dart';
import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/home/product_item_cell.dart';
import 'package:rupee_elf/models/product_model.dart';
import 'package:rupee_elf/models/space_detail_model.dart';
import 'package:rupee_elf/models/user_info_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/adjust_track_tool.dart';
import 'package:rupee_elf/util/common_alert.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';
import 'package:rupee_elf/widgets/home_menu/home_menu_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  var isShowMenu = false;
  List<ProductModel> _products = [];
  bool _isSendedFirstLaunchRequest = false;
  bool _isCerified = false;

  late UserInfoModel userInfo;

  @override
  void initState() {
    super.initState();
    loadData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        Adjust.onResume();
        break;
      case AppLifecycleState.paused:
        Adjust.onPause();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'Home Page',
      showBackButton: false,
      child: RefreshIndicator(
          onRefresh: loadData,
          child: ListView(
            children: [
              const CommonImage(
                  src: 'static/images/home_not_certified_head_img.png'),
              HomeMenuWidget(
                isCertified: _isCerified,
                bankCardChangeOnTap: () {
                  bankCardChangeItemClicked(context);
                },
                orderOnTap: () {
                  orderItemClicked(context);
                },
                profileOnTap: () {
                  profilItemClicked(context);
                },
              ),
              Column(
                children: _products.map((item) {
                  return ProductItemCell(
                    isOdd: _products.indexOf(item) % 2 == 0,
                    product: item,
                    onTap: () {
                      itemCellOnTap(item.productId.toString());
                    },
                  );
                }).toList(),
              ),
            ],
          )),
    );
  }

  void bankCardChangeItemClicked(BuildContext context) {
    ADJustTrackTool.trackWith('nnpu5i');
    if (Global.instance.isLogin) {
      Navigator.of(context).pushNamed('/changeBankInfo').then((value) {
        loadData();
      });
    } else {
      Navigator.of(context).pushNamed('/login').then((value) {
        loadData();
      });
    }
  }

  void orderItemClicked(BuildContext context) {
    ADJustTrackTool.trackWith('i1r2og');
    if (Global.instance.isLogin) {
      Navigator.of(context).pushNamed('/order').then((value) {
        loadData();
      });
    } else {
      Navigator.of(context).pushNamed('/login').then((value) {
        loadData();
      });
    }
  }

  void profilItemClicked(BuildContext context) {
    if (!_isCerified) {
      ADJustTrackTool.trackWith('jgsfy8');
    }
    Navigator.of(context).pushNamed('/profile').then((value) {
      loadData();
    });
  }

  void itemCellOnTap(String productId) async {
    if (Global.instance.isLogin && userInfo.userStatus == 2) {
      ADJustTrackTool.trackWith('3q7cqp');
      SpaceDetailModel? model =
          await NetworkService.checkUserSpaceDetail(productId);
      if (model == null) return;
      if (model.spaceStatus == 2) {
        if (context.mounted) {
          Navigator.pushNamed(context, '/productDetail',
              arguments: {'product': model.loanProduct, 'isRecommend': false});
        }
      } else {
        if (context.mounted) {
          Navigator.of(context)
              .pushNamed('/orderDetail/${model.orderInfo?.loanOrderNo}')
              .then((_) {
            loadData();
          });
        }
      }
    } else if (!Global.instance.isLogin) {
      Navigator.of(context).pushNamed('/login').then((value) {
        loadData();
      });
    } else {
      ADJustTrackTool.trackWith('3r5683');
      Navigator.pushNamed(context, 'authFirst').then((value) {
        loadData();
      });
    }
  }

  // 获取网络数据
  Future<void> loadData() async {
    // 先初始化全局对象
    await Global.instance.initConstants();

    // 保存启动时间，毫秒
    Global.instance.prefs.setInt(
        Constants.APP_LAUNCH_TIME, DateTime.now().millisecondsSinceEpoch);

    if (!_isSendedFirstLaunchRequest) {
      await NetworkService.firstLaunch();
      _isSendedFirstLaunchRequest = true;
    }

    List<ProductModel>? list;
    bool isCer = _isCerified;
    if (Global.instance.isLogin) {
      UserInfoModel? model = await NetworkService.getUserInfo();

      if (model != null) {
        userInfo = model;
        isCer = model.userStatus == 2;
      }

      list = userInfo.productList;

      if (userInfo.userPayFail == 1) {
        if (context.mounted) {
          await CommonAlert.showAlert(
              context: context, type: AlertType.dibursingFailed, model: model);
        }
      }
    } else {
      var listModel = await NetworkService.getProductList();
      list = listModel.pkmrctoductList;
      isCer = false;
    }

    setState(() {
      _isCerified = isCer;
      if (list != null) _products = list;
    });
  }
}
