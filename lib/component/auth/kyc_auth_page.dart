import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/auth_base_widget.dart';
import 'package:rupee_elf/widgets/can_bg_image_widget.dart';
import 'package:rupee_elf/widgets/gender_selector.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

class KYCAuthPage extends StatefulWidget {
  const KYCAuthPage({super.key});

  @override
  State<KYCAuthPage> createState() => _KYCAuthPageState();
}

class _KYCAuthPageState extends State<KYCAuthPage> {
  String? _selectedFrontImage;
  String? _selectedBackImage;
  String? _selectedPanImage;
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return AuthBaseWidget(
      'My authentication',
      totalStep: 4,
      currentStep: 1,
      contentBuilder: (context) {
        return HiddenKeyboardWrapper(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    const CommonImage(src: 'static/icons/auth_horn_icon.png'),
                    const Padding(padding: EdgeInsets.only(right: 10.0)),
                    Text(
                      'Please upload clear and original documents',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Global.seconaryTextColor,
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                CanBgImageWidget(
                  icon: 'static/icons/auth_camera_icon.png',
                  title: 'Aadhaar Card Front',
                  width: 214.0,
                  height: 120,
                  backgroundImage: _selectedFrontImage,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('authSimple')
                        .then((params) {
                      if (params != null) {
                        setState(() {
                          _selectedFrontImage =
                              'https://media.gq.com.tw/photos/5dbc27d22551d4000869e16b/3:2/w_1600%2Cc_limit/2019050674544721.jpg';
                        });
                        debugPrint('DEBUG: card Front 点击');
                      }
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Aadhaar Name',
                  keyboardType: TextInputType.name,
                  onTap: () {
                    debugPrint('DEBUG: 点击了 Aadhaar Name 选项，此处要做埋点');
                  },
                  onValueChanged: (value) {
                    debugPrint('DEBUG: Aadhaar Name 当前输入的文字是$value');
                  },
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Aadhaar Number',
                  keyboardType: TextInputType.number,
                  onTap: () {
                    debugPrint('DEBUG: 点击了 Aadhaar Number 选项，此处要做埋点');
                  },
                  onValueChanged: (value) {
                    debugPrint('DEBUG: Aadhaar Number 当前输入的文字是$value');
                  },
                ),
                CommonFormItem(
                  type: FormType.date,
                  hintText: 'Date of Birth',
                  onTap: () {
                    debugPrint('DEBUG: Date of Birth 点击，此处要做埋点');
                  },
                ),
                GenderSelector(
                  height: 50.0,
                  selectedValue: _selectedGender,
                  onTap: () {
                    debugPrint('DEBUG: 选择了性别，此处需要做埋点');
                  },
                  onValueChanged: (selectedGender) {
                    debugPrint('DEBUG: 当前选中的性别是$selectedGender');
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                CanBgImageWidget(
                  icon: 'static/icons/auth_camera_icon.png',
                  title: 'Aadhaar Card Back',
                  width: 214.0,
                  height: 120,
                  backgroundImage: _selectedBackImage,
                  onTap: () {
                    setState(() {
                      _selectedBackImage =
                          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/8a3e-hukwxnv6582111-1553152727.jpg?crop=1xw:1xh;center,top&resize=980:*';
                    });
                    debugPrint('DEBUG: card back 点击,此处需做埋点');
                  },
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Detail Address',
                  onTap: () {
                    debugPrint('DEBUG: Detail Address 点击，此处要做埋点');
                  },
                  onValueChanged: (value) {
                    debugPrint('DEBUG: Detail Address 当前输入的文字$value');
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                CanBgImageWidget(
                  icon: 'static/icons/auth_camera_icon.png',
                  title: 'Pan card Front',
                  width: 214.0,
                  height: 120,
                  backgroundImage: _selectedPanImage,
                  onTap: () {
                    setState(() {
                      _selectedPanImage =
                          'https://assets.juksy.com/files/articles/57859/800x_100_w-61bc3f2761aa2.jpg';
                    });
                    debugPrint('DEBUG: Pan card Front 点击,此处需做埋点');
                  },
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Pan Number',
                  onTap: () {
                    debugPrint('DEBUG: Pan Number 点击，此处要做埋点');
                  },
                  onValueChanged: (value) {
                    debugPrint('DEBUG: Pan Number 当前输入的文字$value');
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ThemeButton(
                  width: 252.0,
                  height: 52.0,
                  title: 'Next',
                  onPressed: () {
                    debugPrint('DEBUG: Next 按钮 点击，此处要做埋点');
                    Navigator.of(context).pushNamed('routeName');
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
