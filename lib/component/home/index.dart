import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/home/product_item_cell.dart';
import 'package:rupee_elf/models/product_model.dart';
import 'package:rupee_elf/models/user_info_model.dart';
import 'package:rupee_elf/network_service/index.dart';
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
                  productCellClicked(context);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void bankCardChangeItemClicked(BuildContext context) async {
    if (Global.instance.isLogin) {
    } else {
      var result = await Navigator.of(context).pushNamed('/login');
      if (result != null) await loadData();
    }
  }

  void orderItemClicked(BuildContext context) async {
    if (Global.instance.isLogin) {
    } else {
      var result = await Navigator.of(context).pushNamed('/login');
      if (result != null) await loadData();
    }
  }

  void profilItemClicked(BuildContext context) {
    Navigator.of(context).pushNamed('/profile').then((value) {
      loadData();
    });
  }

  void productCellClicked(BuildContext context) {
    if (!Global.instance.isLogin) {
      Navigator.of(context).pushNamed('/login').then((value) {
        loadData();
      });
    }

    if (_isCerified) {
    } else {
      Navigator.of(context).pushNamed('/authFirst').then((value) {
        loadData();
      });
    }
  }

  // 获取网络数据
  Future<void> loadData() async {
    // 先初始化全局对象
    await Global.instance.initConstants();

    if (!_isSendedFirstLaunchRequest) {
      await NetworkService.firstLaunch();
      _isSendedFirstLaunchRequest = true;
    }

    List<ProductModel>? list;
    bool isCer;
    if (Global.instance.isLogin) {
      UserInfoModel? model = await NetworkService.getUserInfo();
      list = model?.pkmrctoductList;
      isCer = model?.ukmscterStatus == 2;
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
