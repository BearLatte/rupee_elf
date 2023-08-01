import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

class ChangeBankCardPage extends StatefulWidget {
  const ChangeBankCardPage({super.key});

  @override
  State<ChangeBankCardPage> createState() => _ChangeBankCardPageState();
}

class _ChangeBankCardPageState extends State<ChangeBankCardPage> {
  String _accountNumber = '';
  String _bankName = '';
  String _ifscCode = '';
  @override
  Widget build(BuildContext context) {
    return HiddenKeyboardWrapper(
      child: Scaffold(
        floatingActionButton: ThemeButton(
          width: 252.0,
          height: 52.0,
          title: 'Submit',
          onPressed: () {
            debugPrint('DEBUG: 提交按钮点击');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text(
            'Bank Account',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Global.themeTextColor,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(IconFont.icon_back),
            color: Global.themeTextColor,
            iconSize: 16.0,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: ListView(
            children: [
              const CommonImage(
                src: 'static/images/profile_change_bank_info_img.png',
                height: 198.0,
                fit: BoxFit.fill,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 30.0)),
              CommonFormItem(
                type: FormType.input,
                hintText: 'Account Number',
                inputValue: _accountNumber,
                keyboardType: TextInputType.number,
                onValueChanged: (value) {
                  setState(() {
                    _accountNumber = value;
                  });
                },
              ),
              CommonFormItem(
                type: FormType.input,
                hintText: 'Bank Name',
                inputValue: _bankName,
                onValueChanged: (value) {
                  setState(() {
                    _bankName = value;
                  });
                },
              ),
              CommonFormItem(
                type: FormType.input,
                hintText: 'IFSC Code',
                inputValue: _ifscCode,
                onValueChanged: (value) {
                  setState(() {
                    _ifscCode = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
