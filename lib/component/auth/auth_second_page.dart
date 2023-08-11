import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/models/certification_info_model.dart';
import 'package:rupee_elf/models/user_auth_submit_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/common_picker/index.dart';
import 'package:rupee_elf/widgets/auth_base_widget.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';

class AuthSecondPage extends StatefulWidget {
  const AuthSecondPage({super.key});

  @override
  State<AuthSecondPage> createState() => _AuthSecondPageState();
}

class _AuthSecondPageState extends State<AuthSecondPage> {
  String _marriageStatus = '';
  String _education = '';
  String _industry = '';
  String _salary = '';
  String _workTitle = '';
  final TextEditingController _whatAppAccountController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _facebookIdController = TextEditingController();

  List<String> _marriageList = [];
  List<String> _educationList = [];
  List<String> _industryList = [];
  List<String> _salaryList = [];
  List<String> _workTitleList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    CertificationInfoModel? info = await NetworkService.getCertificationInfo();
    if (info != null) {
      setState(() {
        _marriageStatus = info.marriageStatus;
        _education = info.education;
        _industry = info.userIndustry;
        _salary = info.monthlySalary;
        _workTitle = info.workTitle;
        _whatAppAccountController.text = info.whatsAppAccount;
        _emailController.text = info.userEmail;
        _facebookIdController.text = info.facebookId;
        _marriageList = info.marriageStatusList;
        _educationList = info.educationList;
        _industryList = info.industryList;
        _salaryList = info.monthlySalaryList;
        _workTitleList = info.workTitleList;
      });
    }
  }

  void _marriageOnTap() async {
    String? selectedValue =
        await _showPickerWith(_marriageList, _marriageStatus);
    if (selectedValue != null) {
      setState(() {
        _marriageStatus = selectedValue;
      });
    }

    debugPrint('DEBUG: Marriage Status 点击，此处需要做埋点');
  }

  void _educationOnTap() async {
    String? selectedValue = await _showPickerWith(_educationList, _education);
    if (selectedValue != null) {
      setState(() {
        _education = selectedValue;
      });
    }
    debugPrint('DEBUG: Education点击，此处需要做埋点');
  }

  void _industryOnTap() async {
    String? selectedValue = await _showPickerWith(_industryList, _industry);
    if (selectedValue != null) {
      setState(() {
        _industry = selectedValue;
      });
    }
    debugPrint('DEBUG: Industry 点击，此处需要做埋点');
  }

  void _salaryOnTap() async {
    String? selectedValue = await _showPickerWith(_salaryList, _salary);
    if (selectedValue != null) {
      setState(() {
        _salary = selectedValue;
      });
    }
    debugPrint('DEBUG: Monthly Salary 点击，此处需要做埋点');
  }

  void _workTitleOnTap() async {
    String? selectedValue = await _showPickerWith(_workTitleList, _workTitle);
    if (selectedValue != null) {
      setState(() {
        _workTitle = selectedValue;
      });
    }
    debugPrint('DEBUG: Work Title 点击，此处需要做埋点');
  }

  void _nextBtnClicked() async {
    debugPrint('DEBUG: Next 按钮 点击，此处要做埋点');
    if (_marriageStatus.trim().isEmpty) {
      await CommonToast.showToast('Please select your Marriage State!');
      return;
    }

    if (_education.trim().isEmpty) {
      await CommonToast.showToast('Please select your Education Level!');
      return;
    }

    if (_industry.trim().isEmpty) {
      await CommonToast.showToast('Please select your Industry!');
      return;
    }

    if (_salary.trim().isEmpty) {
      await CommonToast.showToast('Please select your Monthly Salary!');
      return;
    }

    if (_workTitle.trim().isEmpty) {
      await CommonToast.showToast('Please select your Work Title!');
      return;
    }

    if (_whatAppAccountController.text.trim().isEmpty) {
      await CommonToast.showToast('Please enter your WhatsApp Account!');
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      await CommonToast.showToast('Please enter your Email!');
      return;
    }

    UserAuthSubmitModel model = UserAuthSubmitModel(
      aYYutYhStep: '2',
      mYYarYriageStatus: _marriageStatus,
      eYYduYcation: _education,
      uYYseYrIndustry: _industry,
      mYYonYthlySalary: _salary,
      wYYorYkTitle: _workTitle,
      wYYhaYtsAppAccount: _whatAppAccountController.text,
      uYYseYrEmail: _emailController.text,
      fYYacYebookId: _facebookIdController.text,
    );

    await NetworkService.userAuthSubmit(model, () {
      if (context.mounted) {
        Navigator.of(context).pushNamed('authThird');
      }
    });
  }

  Future<String?> _showPickerWith(
      List<String> options, String currentValue) async {
    int? selectedIndex = await CommonPicker.showPicker(
      context: context,
      options: options,
      value: options.indexOf(currentValue),
    );

    if (selectedIndex != null) {
      return options[selectedIndex];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBaseWidget(
      'My authentication',
      nextStepText: 'Next',
      nextStepOnPressed: _nextBtnClicked,
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
                inputValue: _marriageStatus,
                onTap: _marriageOnTap,
              ),
              CommonFormItem(
                type: FormType.selecte,
                hintText: 'Education',
                inputValue: _education,
                onTap: _educationOnTap,
              ),
              CommonFormItem(
                type: FormType.selecte,
                hintText: 'Industry',
                inputValue: _industry,
                onTap: _industryOnTap,
              ),
              CommonFormItem(
                type: FormType.selecte,
                hintText: 'Monthly Salary',
                inputValue: _salary,
                onTap: _salaryOnTap,
              ),
              CommonFormItem(
                type: FormType.selecte,
                hintText: 'Work Title',
                inputValue: _workTitle,
                onTap: _workTitleOnTap,
              ),
              CommonFormItem(
                type: FormType.input,
                keyboardType: TextInputType.number,
                hintText: 'WhatsApp Account',
                editingController: _whatAppAccountController,
                onTap: () {},
              ),
              CommonFormItem(
                type: FormType.input,
                hintText: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                editingController: _emailController,
                onTap: () {},
              ),
              CommonFormItem(
                type: FormType.input,
                hintText: 'Facebook ID（optional）',
                editingController: _facebookIdController,
                onTap: () {},
              ),
            ]),
          ),
        );
      },
    );
  }
}
