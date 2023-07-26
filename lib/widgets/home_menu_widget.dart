import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/hexcolor.dart';

class HomeMenuWidget extends StatefulWidget {
  final bool isCeitified;

  const HomeMenuWidget({super.key, required this.isCeitified});

  @override
  State<HomeMenuWidget> createState() => _HomeMenuWidgetState();
}

class _HomeMenuWidgetState extends State<HomeMenuWidget> {
  var _isShowMenu = false;
  @override
  Widget build(BuildContext context) {
    return _isShowMenu
        ? Container(
            width: 363.0,
            height: 90.0,
            alignment: widget.isCeitified
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: 363.0,
              height: 90.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    widget.isCeitified
                        ? 'static/images/home_menu_rigth_bg_img.png'
                        : 'static/images/home_menu_left_bg_img.png',
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.isCeitified
                    ? [
                        _createBackGesture(
                            'static/icons/home_menu_arrow_right.png'),
                        _createMenuItem(
                          'Change Bank Info',
                          'static/icons/home_bank_card_icon.png',
                          Global.isLogin ? '/changeBankInfo' : '/login',
                        ),
                        _createMenuItem(
                          'My Orders',
                          'static/icons/home_order_icon.png',
                          Global.isLogin ? '/orderList' : '/login',
                        ),
                        _createMenuItem(
                          'Personal center',
                          'static/icons/home_profile_icon.png',
                          '/profile',
                        ),
                      ]
                    : [
                        _createMenuItem(
                          'Change Bank Info',
                          'static/icons/home_bank_card_icon.png',
                          Global.isLogin ? '/orderList' : '/login',
                        ),
                        _createMenuItem(
                          'My Orders',
                          'static/icons/home_order_icon.png',
                          Global.isLogin ? '/orderList' : '/login',
                        ),
                        _createMenuItem(
                          'Personal center',
                          'static/icons/home_profile_icon.png',
                          '/profile',
                        ),
                        _createBackGesture(
                            'static/icons/home_menu_arrow_left.png'),
                      ],
              ),
            ),
          )
        : Container(
            width: 90.0,
            height: 90.0,
            alignment: widget.isCeitified
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isShowMenu = !_isShowMenu;
                });
              },
              child: CommonImage(
                src: widget.isCeitified
                    ? 'static/icons/arrow_left_bg_icon.png'
                    : 'static/icons/arrow_right_bg_icon.png',
              ),
            ),
          );
  }

  GestureDetector _createBackGesture(String iconPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isShowMenu = !_isShowMenu;
        });
      },
      child: CommonImage(
        src: iconPath,
        width: 32.0,
        height: 90.0,
      ),
    );
  }

  GestureDetector _createMenuItem(
      String title, String iconPath, String navigatorDestination) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(navigatorDestination);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonImage(src: iconPath),
          const Padding(padding: EdgeInsets.only(bottom: 4.0)),
          Text(
            title,
            style: TextStyle(color: HexColor('#333333'), fontSize: 14.0),
          )
        ],
      ),
    );
  }
}
