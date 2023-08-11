import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/models/user_auth_submit_model.dart';
import 'package:rupee_elf/models/user_info_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/common_alert.dart';
import 'package:rupee_elf/widgets/auth_base_widget.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';

class AuthFourthPage extends StatefulWidget {
  const AuthFourthPage({super.key});

  @override
  State<AuthFourthPage> createState() => _AuthFourthPageState();
}

class _AuthFourthPageState extends State<AuthFourthPage> {
  final TextEditingController _bankCardNumberController =
      TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();

  void submitBtnOnPressed(BuildContext context) async {
    if (_bankCardNumberController.text.trim().isEmpty) {
      await CommonToast.showToast('Account Number can not be empty.');
      return;
    }

    if (_bankNameController.text.trim().isEmpty) {
      await CommonToast.showToast('Bank Name can not be empty.');
      return;
    }
    if (_ifscCodeController.text.trim().isEmpty) {
      await CommonToast.showToast('IFSC Code can not be empty.');
      return;
    }

    var isOk = await CommonAlert.showAlert(
      context: context,
      type: AlertType.succesed,
      message:
          'The 1-3 steps information cannot be changed after submission. Please fill in the correct information.',
    );
    if (isOk) {
      debugPrint('DEBUG: 提交银行卡信息, 此处需要做埋点');

      UserAuthSubmitModel model = UserAuthSubmitModel(
        aYYutYhStep: '4',
        bYYanYkCardName: _bankNameController.text,
        bYYanYkCardNo: _bankCardNumberController.text,
        bYYanYkIfscCode: _ifscCodeController.text,
      );

      NetworkService.userAuthSubmit(model, () {
        recommendProductConfig();
      });
    }
  }

  void recommendProductConfig() async {
    UserInfoModel? userInfo =
        await NetworkService.getUserInfo(isRecommend: '1');
    if (userInfo == null || userInfo.lkmoctanProduct == null) {
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return;
      }
    }

    if (userInfo!.lkmoctanProduct!.pkmrctoductId == 0) {
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/productDetail',
        (route) => route.isFirst,
        arguments: userInfo.lkmoctanProduct!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBaseWidget(
      'My authentication',
      nextStepText: 'Submit',
      nextStepOnPressed: () => submitBtnOnPressed(context),
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
                  editingController: _bankCardNumberController,
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Bank Name',
                  keyboardType: TextInputType.name,
                  onTap: () {
                    debugPrint('DEBUG: 点击银行名称, 此处需要做埋点');
                  },
                  editingController: _bankNameController,
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'IFSC Code',
                  onTap: () {
                    debugPrint('DEBUG: 点击银行卡, 此处需要做埋点');
                  },
                  editingController: _ifscCodeController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
