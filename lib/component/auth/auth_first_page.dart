// ignore_for_file: constant_identifier_names

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/models/certification_info_model.dart';
import 'package:rupee_elf/models/ocr_model.dart';
import 'package:rupee_elf/models/user_auth_submit_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/common_alert.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/widgets/auth_base_widget.dart';
import 'package:rupee_elf/widgets/can_bg_image_widget.dart';
import 'package:rupee_elf/widgets/gender_selector.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

enum OcrType { AADHAAR_FRONT, AADHAAR_BACK, PAN_FRONT }

class AuthFirstPage extends StatefulWidget {
  const AuthFirstPage({super.key});

  @override
  State<AuthFirstPage> createState() => _AuthFirstPageState();
}

class _AuthFirstPageState extends State<AuthFirstPage> {
  String? _selectedFrontImage;
  String? _selectedBackImage;
  String? _selectedPanImage;
  String _selectedGender = '';
  String _selectedBirth = '';

  TextEditingController aadhaarNameController = TextEditingController();
  TextEditingController aadhaarNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();

  // 后台需要的数据
  OcrModel? aadhaarFrontModel;
  OcrModel? aadhaarBackModel;
  OcrModel? panFrontModel;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    CertificationInfoModel? info = await NetworkService.getCertificationInfo();
    if (info != null) {
      setState(() {
        _selectedFrontImage = '${info.imageHttp}/${info.frontImage}';
        _selectedBackImage = '${info.imageHttp}/${info.backImage}';
        _selectedPanImage = '${info.imageHttp}/${info.panCardImg}';
        aadhaarNameController.text = info.userNames;
        aadhaarNumberController.text = info.aadhaarNumber;
        _selectedBirth = info.dateOfBirth;
        _selectedGender = info.userGender;
        addressController.text = info.addressDetail;
        panNumberController.text = info.panNumber;
      });
    }
  }

  void cardFrontOnTap() async {
    var result = await Navigator.of(context).pushNamed('authSimple');
    if (result != null) {
      configCameraParams(OcrType.AADHAAR_FRONT);
    }
  }

  void cardBackOnTap() {
    configCameraParams(OcrType.AADHAAR_BACK);
  }

  void panCardOnTap() {
    configCameraParams(OcrType.PAN_FRONT);
  }

  void birthItemOnTap() async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 80),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedBirth =
            formatDate(selectedDate, ['yyyy', '-', 'mm', '-', 'dd']);
      });
    }

    debugPrint('DEBUG: Date of Birth 点击，此处要做埋点');
  }

  void nextOnTap() async {
    var status = await Permission.locationWhenInUse.request();
    if (status != PermissionStatus.granted) {
      if (context.mounted) {
        bool isOk = await CommonAlert.showAlert(
          context: context,
          type: AlertType.tips,
          message:
              'This feature requires you to authorize this app to open the location service\nHow to set it: open phone Settings -> Privacy -> Location service',
        );
        if (isOk) {
          openAppSettings();
        }
        return;
      }
    }

    if (_selectedBackImage == null) {
      await CommonToast.showToast('Please upload your Aadhaar!');
      return;
    }

    if (_selectedBackImage == null) {
      await CommonToast.showToast('Please upload your Aadhaar!');
      return;
    }

    if (_selectedPanImage == null) {
      await CommonToast.showToast('Please upload your Pan card!');
      return;
    }

    if (aadhaarNameController.text.trim().isEmpty) {
      await CommonToast.showToast('Aadhaar Name can not be empty!');
      return;
    }

    if (aadhaarNumberController.text.trim().isEmpty) {
      await CommonToast.showToast('Aadhaar Number can not be empty!');
      return;
    }

    if (_selectedBirth.trim().isEmpty) {
      await CommonToast.showToast('Date of Birth can not be empty!');
      return;
    }

    if (_selectedGender.trim().isEmpty) {
      await CommonToast.showToast('Gender can not be empty!');
      return;
    }

    if (addressController.text.trim().isEmpty) {
      await CommonToast.showToast('Detail Address can not be empty!');
      return;
    }

    if (panNumberController.text.trim().isEmpty) {
      await CommonToast.showToast('Pan Number can not be empty!');
      return;
    }

    // 截取图片的路径
    String frontImage =
        _selectedFrontImage!.substring(_selectedFrontImage!.indexOf('india'));
    String backImage =
        _selectedBackImage!.substring(_selectedBackImage!.indexOf('india'));
    String panImage =
        _selectedPanImage!.substring(_selectedPanImage!.indexOf('india'));

    UserAuthSubmitModel submitModel = UserAuthSubmitModel(
      aYYutYhStep: '1',
      fYYroYntImage: frontImage,
      bYYacYkImage: backImage,
      pYYanYCardImg: panImage,
      uYYseYrNames: aadhaarNameController.text,
      aYYadYhaarNumber: aadhaarNumberController.text,
      dYYatYeOfBirth: _selectedBirth,
      uYYseYrGender: _selectedGender,
      aYYddYressDetail: addressController.text,
      pYYanYNumber: panNumberController.text,
    );

    await NetworkService.userAuthSubmit(submitModel, () {
      if (context.mounted) {
        Navigator.of(context).pushNamed('authSecond');
      }
    });

    debugPrint('DEBUG: Next 按钮 点击，此处要做埋点');
  }

  void configCameraParams(OcrType type) async {
    var status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      // 有相机权限，打开相机拍照
      ImagePicker picker = ImagePicker();
      XFile? img = await picker.pickImage(source: ImageSource.camera);

      if (img != null) {
        selectedImage(type, img.path);
      }
    } else {
      await CommonToast.showToast(
          'You did not allow us to access the camera, which will help you obtain a loan. Would you like to set up authorization.');
    }
  }

  void selectedImage(OcrType type, String src) async {
    OcrModel? model = await NetworkService.ocrRecgonizer(src, type.name);

    switch (type) {
      case OcrType.AADHAAR_FRONT:
        aadhaarFrontModel = model;
        break;
      case OcrType.AADHAAR_BACK:
        aadhaarBackModel = model;
        break;
      case OcrType.PAN_FRONT:
        panFrontModel = model;
        break;
    }

    setState(() {
      if (aadhaarFrontModel != null) {
        _selectedFrontImage =
            '${aadhaarFrontModel?.ikmmctageHttp}/${aadhaarFrontModel?.ikmmctagePath}';
        aadhaarNameController.text = aadhaarFrontModel?.ukmscterNames ?? '';
        aadhaarNumberController.text =
            aadhaarFrontModel?.akmactdhaarNumber ?? '';
        _selectedBirth = aadhaarFrontModel?.dkmactteOfBirth ?? '';
        _selectedGender = aadhaarFrontModel?.ukmscterGender ?? '';
      }

      if (aadhaarBackModel != null) {
        _selectedBackImage =
            '${aadhaarBackModel?.ikmmctageHttp}/${aadhaarBackModel?.ikmmctagePath}';
        addressController.text = aadhaarBackModel?.akmdctdressDetail ?? '';
      }

      if (panFrontModel != null) {
        _selectedPanImage =
            '${panFrontModel?.ikmmctageHttp}/${panFrontModel?.ikmmctagePath}';
        panNumberController.text = panFrontModel?.pkmactnNumber ?? '';
      }
    });
  }

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
                    Expanded(
                      child: Text(
                        'Please upload clear and original documents.',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Constants.seconaryTextColor,
                        ),
                        maxLines: null,
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
                  onTap: cardFrontOnTap,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Aadhaar Name',
                  keyboardType: TextInputType.name,
                  editingController: aadhaarNameController,
                  onTap: () {
                    debugPrint('DEBUG: 点击了 Aadhaar Name 选项，此处要做埋点');
                  },
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Aadhaar Number',
                  keyboardType: TextInputType.number,
                  editingController: aadhaarNumberController,
                  onTap: () {
                    debugPrint('DEBUG: 点击了 Aadhaar Number 选项，此处要做埋点');
                  },
                ),
                CommonFormItem(
                  type: FormType.date,
                  hintText: 'Date of Birth',
                  inputValue: _selectedBirth,
                  onTap: birthItemOnTap,
                ),
                GenderSelector(
                  height: 50.0,
                  selectedValue: _selectedGender,
                  onTap: () {
                    debugPrint('DEBUG: 选择了性别，此处需要做埋点');
                  },
                  onValueChanged: (selectedGender) {
                    _selectedGender = selectedGender;
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
                  onTap: cardBackOnTap,
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Detail Address',
                  editingController: addressController,
                  isMultiLine: true,
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
                  onTap: panCardOnTap,
                ),
                CommonFormItem(
                  type: FormType.input,
                  hintText: 'Pan Number',
                  editingController: panNumberController,
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
                  onPressed: nextOnTap,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
