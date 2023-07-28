import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/widgets/auth_base_widget.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';

class AuthFourthPage extends StatelessWidget {
  const AuthFourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBaseWidget(
      'My authentication',
      nextStepText: 'Submit',
      nextStepOnPressed: () {
        debugPrint('DEBUG: 提交银行卡信息, 此处需要做埋点');
      },
      totalStep: 4,
      currentStep: 4,
      contentBuilder: (context) {
        return HiddenKeyboardWrapper(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: ListView(
              children: [
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Account Number',
                  keyboardType: TextInputType.number,
                  onTap: () {
                    debugPrint('DEBUG: 点击银行卡, 此处需要做埋点');
                  },
                  onValueChanged: (value) {
                    debugPrint('DEBUG: 银行卡号$value');
                  },
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Bank Name',
                  keyboardType: TextInputType.name,
                  onTap: () {
                    debugPrint('DEBUG: 点击银行名称, 此处需要做埋点');
                  },
                  onValueChanged: (value) {
                    debugPrint('DEBUG: 银行卡名称$value');
                  },
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'IFSC Code',
                  onTap: () {
                    debugPrint('DEBUG: 点击银行卡, 此处需要做埋点');
                  },
                  onValueChanged: (value) {
                    debugPrint('DEBUG: IFSC Code $value');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
