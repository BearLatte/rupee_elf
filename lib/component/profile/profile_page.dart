import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLogin = Global.instance.isLogin;
  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: '',
      floatingActionButton: _isLogin
          ? Container(
              width: 228.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: HexColor('#F4BD9F'),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: TextButton(
                onPressed: _logoutAction,
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 220.0),
            color: Constants.seconaryBackgroundColor,
          ),
          Column(
            children: [
              CommonImage(
                src: Global.instance.isLogin
                    ? 'static/icons/profile_logo_did_login_icon.png'
                    : 'static/icons/profile_logo_not_login_icon.png',
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Text(
                Global.instance.isLogin
                    ? Global.instance.currentAccount
                    : 'Please log in',
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.only(
                    top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    _itemCell(
                        title: 'Feedback',
                        onTap: () {
                          _feedbackOnPressed(context);
                        }),
                    _itemCell(
                        title: 'Privacy Policy', onTap: _privacyOnPressed),
                    _itemCell(
                        title: 'About Us',
                        onTap: () {
                          _aboutUsOnPressed(context);
                        }),
                    if (Global.instance.isLogin)
                      _itemCell(
                        title: 'Delete account',
                        onTap: _deleteAccountOnPressed,
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40.0,
                child: const CommonImage(
                  src: 'static/images/profile_img.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _logoutAction() async {
    await NetworkService.logout(() {
      Global.instance.clearLocalInfo();
      setState(() {
        _isLogin = false;
      });
    });
  }

  void _feedbackOnPressed(BuildContext context) {
    Navigator.of(context)
        .pushNamed(Global.instance.isLogin ? '/feedback' : '/login')
        .then((value) {
      setState(() {
        _isLogin = Global.instance.isLogin;
      });
    });
  }

  void _privacyOnPressed() {
    debugPrint('DEBUG: 点击 privacy');
  }

  void _aboutUsOnPressed(BuildContext context) {
    Navigator.of(context).pushNamed('/aboutUs');
  }

  void _deleteAccountOnPressed() {
    _logoutAction();
  }

  Widget _itemCell({required String title, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Constants.themeTextColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              size: 12.0,
              color: HexColor('#C8C8C8'),
            ),
          ],
        ),
      ),
    );
  }
}
