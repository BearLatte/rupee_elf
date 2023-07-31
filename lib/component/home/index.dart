import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/home/product_item_cell.dart';
import 'package:rupee_elf/component/home/product_item_data.dart';
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
  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'Home Page',
      showBackButton: false,
      child: ListView(
        children: [
          const CommonImage(
              src: 'static/images/home_not_certified_head_img.png'),
          const HomeMenuWidget(
              isCeitified: Global.isLogin && Global.isCeitified),
          Column(
            children: productItemData.map((item) {
              return ProductItemCell(
                isOdd: productItemData.indexOf(item) % 2 == 0,
                product: item,
                onTap: () {
                  if (Global.isCeitified) {
                    // todo
                    Navigator.of(context)
                        .pushNamed('/productDetail/${item.id}');
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
}
