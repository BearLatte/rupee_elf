import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/home/product_item_cell.dart';
import 'package:rupee_elf/models/product_model.dart';
import 'package:rupee_elf/models/space_detail_model.dart';
import 'package:rupee_elf/models/user_info_model.dart';
import 'package:rupee_elf/network_service/index.dart';
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

class _HomePageState extends State<HomePage> {
  var isShowMenu = false;
  List<ProductModel> _products = [];
  bool _isSendedFirstLaunchRequest = false;
  bool _isCerified = false;

  late UserInfoModel userInfo;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'Home Page',
      showBackButton: false,
      // floatingActionButton: ThemeButton(
      //   width: 152.0,
      //   height: 52.0,
      //   title: 'Test',
      //   onPressed: () {
      //     Navigator.of(context).pushNamed('/addFeedback');
      //   },
      // ),
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
    Navigator.of(context).pushNamed('/profile').then((value) {
      loadData();
    });
  }

  void itemCellOnTap(String productId) async {
    if (Global.instance.isLogin && userInfo.userStatus == 2) {
      SpaceDetailModel? model =
          await NetworkService.checkUserSpaceDetail(productId);
      if (model == null) return;
      if (model.spaceStatus == 2) {
        if (context.mounted) {
          Navigator.pushNamed(context, '/productDetail',
              arguments: model.loanProduct);
        }
      } else {
        if (context.mounted) {
          debugPrint('DEBUG: 此处跳转到订单详情页面');
        }
      }
    } else if (!Global.instance.isLogin) {
      Navigator.of(context).pushNamed('/login').then((value) {
        loadData();
      });
    } else {
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
