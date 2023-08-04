import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/home/product_item_cell.dart';
import 'package:rupee_elf/models/product_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';
import 'package:rupee_elf/widgets/home_menu_widget.dart';

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
          HomeMenuWidget(isCertified: _isCerified),
          Column(
            children: _products.map((item) {
              return ProductItemCell(
                isOdd: _products.indexOf(item) % 2 == 0,
                product: item,
                onTap: () {
                  if (_isCerified) {
                    // todo
                    // Navigator.of(context)
                    //     .pushNamed('/productDetail/${item.id}');
                  } else {
                    Navigator.pushNamed(context, 'authFirst');
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 获取网络数据
  Future<void> loadData() async {
    // 先初始化全局对象
    await Global.instance.initConstants();

    if (!_isSendedFirstLaunchRequest) {
      await NetworkService.firstLaunch();
      _isSendedFirstLaunchRequest = true;
    }

    var listModel = await NetworkService.getProductList();
    setState(() {
      _products = listModel.pkmrctoductList;
    });
  }
}
