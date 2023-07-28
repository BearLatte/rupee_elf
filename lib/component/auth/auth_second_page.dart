import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/widgets/auth_base_widget.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';

class AuthSecondPage extends StatelessWidget {
  const AuthSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBaseWidget(
      'My authentication',
      nextStepText: 'Next',
      nextStepOnPressed: () {
        debugPrint('DEBUG: Next 按钮 点击，此处要做埋点');
        Navigator.of(context).pushNamed('authThird');
      },
      totalStep: 4,
      currentStep: 2,
      contentBuilder: (context) {
        return HiddenKeyboardWrapper(
          child: Container(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            color: Colors.white,
            child: ListView(children: [
              CommonFormItem(
                type: FormType.selecte,
                hintText: 'Marriage Status',
                onTap: () {
                  debugPrint('DEBUG: Marriage Status 点击，此处需要做埋点');
                },
              ),
              CommonFormItem(
                type: FormType.selecte,
                hintText: 'Education',
                onTap: () {
                  debugPrint('DEBUG: Education点击，此处需要做埋点');
                },
              ),
              CommonFormItem(
                type: FormType.selecte,
                hintText: 'Industry',
                onTap: () {
                  debugPrint('DEBUG: Industry 点击，此处需要做埋点');
                },
              ),
              CommonFormItem(
                type: FormType.selecte,
                hintText: 'Monthly Salary',
                onTap: () {
                  debugPrint('DEBUG: Monthly Salary 点击，此处需要做埋点');
                },
              ),
              CommonFormItem(
                type: FormType.selecte,
                hintText: 'Work Title',
                onTap: () {
                  debugPrint('DEBUG: Work Title 点击，此处需要做埋点');
                },
              ),
              CommonFormItem(
                type: FormType.input,
                hintText: 'WhatsApp Account',
                onTap: () {},
                onValueChanged: (value) {},
              ),
              CommonFormItem(
                type: FormType.input,
                hintText: 'E-mail',
                onTap: () {},
                onValueChanged: (value) {},
              ),
              CommonFormItem(
                type: FormType.input,
                hintText: 'Facebook ID（optional）',
                onTap: () {},
                onValueChanged: (value) {},
              ),
            ]),
          ),
        );
      },
    );
  }
}
