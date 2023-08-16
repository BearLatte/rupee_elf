import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/models/user_auth_submit_model.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

import '../../models/certification_info_model.dart';
import '../../network_service/index.dart';

class ChangeBankCardPage extends StatefulWidget {
  const ChangeBankCardPage({super.key});

  @override
  State<ChangeBankCardPage> createState() => _ChangeBankCardPageState();
}

class _ChangeBankCardPageState extends State<ChangeBankCardPage> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    CertificationInfoModel? info = await NetworkService.getCertificationInfo();
    if (info != null) {
      setState(() {
        _numberController.text = info.bankCardNo;
        _nameController.text = info.bankCardName;
        _ifscController.text = info.bankIfscCode;
      });
    }
  }

  submitOnPressed() async {
    UserAuthSubmitModel model = UserAuthSubmitModel(
      aYYutYhStep: '4',
      bYYanYkCardName: _nameController.text,
      bYYanYkCardNo: _numberController.text,
      bYYanYkIfscCode: _ifscController.text,
    );

    NetworkService.userAuthSubmit(model, () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return HiddenKeyboardWrapper(
      child: Scaffold(
        floatingActionButton: ThemeButton(
          width: 252.0,
          height: 52.0,
          title: 'Submit',
          onPressed: submitOnPressed,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text(
            'Bank Account',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Constants.themeTextColor,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(IconFont.icon_back),
            color: Constants.themeTextColor,
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
                keyboardType: TextInputType.number,
                editingController: _numberController,
              ),
              CommonFormItem(
                type: FormType.input,
                hintText: 'Bank Name',
                editingController: _nameController,
              ),
              CommonFormItem(
                type: FormType.input,
                hintText: 'IFSC Code',
                editingController: _ifscController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
