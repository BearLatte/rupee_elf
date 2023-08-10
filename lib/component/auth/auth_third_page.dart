import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/auth/contact_relation_item.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/auth_base_widget.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

import '../../models/certification_info_model.dart';

class AuthThirdPage extends StatefulWidget {
  const AuthThirdPage({super.key});

  @override
  State<AuthThirdPage> createState() => _AuthThirdPageState();
}

class _AuthThirdPageState extends State<AuthThirdPage> {
  List<String> _relationList = [];
  List<Map<String, String>> _contactList = [];
  int _defaultContactCount = 0;
  List<Map<String, String>> _currentContactList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    CertificationInfoModel? info = await NetworkService.getCertificationInfo();
    if (info != null) {
      setState(() {
        _relationList = info.rkmectlationList;
        if (info.ckmoctntactList.isNotEmpty) {
          _contactList = json.decode(info.ckmoctntactList);
        }

        _defaultContactCount = info.ckmoctntactNum;
      });
    }
  }

  void rightAddBtnOnPressed() {
    debugPrint('DEBUG: 添加按钮点击');
  }

  @override
  Widget build(BuildContext context) {
    return AuthBaseWidget(
      'My authentication',
      isShowTrailingButton:
          Global.instance.currentAccount != Constants.APP_STORE_AUDIT_ACCOUNT,
      totalStep: 4,
      currentStep: 3,
      trailingOnPressed: rightAddBtnOnPressed,
      contentBuilder: (context) {
        return HiddenKeyboardWrapper(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: ListView(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonImage(src: 'static/icons/auth_horn_icon.png'),
                      const Padding(padding: EdgeInsets.only(right: 10.0)),
                      Expanded(
                        child: Text(
                          'The richer the information, the easier to obtain loans.',
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Constants.seconaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_contactList.isNotEmpty)
                  _contactList.map(
                    (item) => const ContactRelationItem(),
                  ) as ContactRelationItem,
                if (_contactList.isEmpty)
                  ...List.generate(
                    _defaultContactCount,
                    (_) => const ContactRelationItem(),
                  ),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ThemeButton(
                  width: 252.0,
                  height: 52.0,
                  title: 'Next',
                  onPressed: () {
                    debugPrint('DEBUG: 此处需要做埋点');
                    Navigator.of(context).pushNamed('/authFourth');
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
