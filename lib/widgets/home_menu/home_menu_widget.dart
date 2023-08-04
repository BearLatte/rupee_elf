import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/home_menu/home_menu_item.dart';

class HomeMenuWidget extends StatefulWidget {
  final bool isCertified;
  final Function() bankCardChangeOnTap;
  final Function() orderOnTap;
  final Function() profileOnTap;

  const HomeMenuWidget({
    super.key,
    required this.isCertified,
    required this.bankCardChangeOnTap,
    required this.orderOnTap,
    required this.profileOnTap,
  });

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
            alignment: widget.isCertified
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: 363.0,
              height: 90.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    widget.isCertified
                        ? 'static/images/home_menu_rigth_bg_img.png'
                        : 'static/images/home_menu_left_bg_img.png',
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.isCertified)
                    _createBackGesture(
                      'static/icons/home_menu_arrow_right.png',
                    ),
                  HomeMenuItem(
                      title: 'Change Bank Info',
                      iconPath: 'static/icons/home_bank_card_icon.png',
                      onTap: widget.bankCardChangeOnTap),
                  HomeMenuItem(
                      title: 'My Orders',
                      iconPath: 'static/icons/home_order_icon.png',
                      onTap: widget.orderOnTap),
                  HomeMenuItem(
                      title: 'Personal center',
                      iconPath: 'static/icons/home_profile_icon.png',
                      onTap: widget.profileOnTap),
                  // _createMenuItem(
                  //   ,
                  //   iconPath: ,
                  //   needsCerifaction: true,
                  //   navigatorDestination: '/changeBankInfo',
                  // ),
                  // _createMenuItem(
                  //   ,
                  //   iconPath: ,
                  //   needsCerifaction: false,
                  //   navigatorDestination: '/order',
                  // ),
                  // _createMenuItem(
                  //   '',
                  //   iconPath: '',
                  //   navigatorDestination: '/profile',
                  //   needsLogin: false,
                  // ),
                  if (!widget.isCertified)
                    _createBackGesture(
                      'static/icons/home_menu_arrow_left.png',
                    ),
                ],
              ),
            ),
          )
        : Container(
            width: 90.0,
            height: 90.0,
            alignment: widget.isCertified
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isShowMenu = !_isShowMenu;
                });
              },
              child: CommonImage(
                src: widget.isCertified
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
}

//   GestureDetector _createMenuItem(
//     String title, {
//     required iconPath,
//     bool needsCerification = false,
//     required String navigatorDestination,
//     bool needsCerifaction = false,
//     bool needsLogin = true,
//   }) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: () {
//         if (needsLogin && !Global.instance.isLogin) {
//           Navigator.of(context).pushNamed('/login');
//           return;
//         }

//         if (needsCerification) {
//           Navigator.of(context).pushNamed('authFirst');
//           return;
//         }

//         Navigator.of(context).pushNamed(navigatorDestination);
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CommonImage(src: iconPath),
//           const Padding(padding: EdgeInsets.only(bottom: 4.0)),
//           Text(
//             title,
//             style: TextStyle(color: HexColor('#333333'), fontSize: 14.0),
//           )
//         ],
//       ),
//     );
//   }
// }
