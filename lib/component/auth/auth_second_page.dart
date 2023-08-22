import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/models/certification_info_model.dart';
import 'package:rupee_elf/models/user_auth_submit_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/adjust_track_tool.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/common_picker/index.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/hexcolor.dart';
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
  int _minAmount = 0;
  int _maxAmount = 0;
  int _currentAmount = 0;
  final TextEditingController _whatAppAccountController =
      TextEditingController();
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
        _minAmount = info.amountMin;
        _maxAmount = info.amountMax;
        _currentAmount = int.parse(info.applyAmount) == 0
            ? (info.amountMax * 0.5).toInt()
            : int.parse(info.applyAmount);
      });
    }
  }

  void amountIncrease() {
    int amount = _currentAmount + 100;
    if (amount > _maxAmount) {
      amount = _maxAmount;
    }

    setState(() {
      _currentAmount = amount;
    });
  }

  void amountDecrease() {
    int amount = _currentAmount - 100;
    if (amount < _minAmount) {
      amount = _minAmount;
    }

    setState(() {
      _currentAmount = amount;
    });
  }

  void _marriageOnTap() async {
    ADJustTrackTool.trackWith('6y32j7');
    String? selectedValue =
        await _showPickerWith(_marriageList, _marriageStatus);
    if (selectedValue != null) {
      setState(() {
        _marriageStatus = selectedValue;
      });
    }
  }

  void _educationOnTap() async {
    ADJustTrackTool.trackWith('qqvf3v');
    String? selectedValue = await _showPickerWith(_educationList, _education);
    if (selectedValue != null) {
      setState(() {
        _education = selectedValue;
      });
    }
  }

  void _industryOnTap() async {
    ADJustTrackTool.trackWith('mmxshd');
    String? selectedValue = await _showPickerWith(_industryList, _industry);
    if (selectedValue != null) {
      setState(() {
        _industry = selectedValue;
      });
    }
    debugPrint('DEBUG: Industry 点击，此处需要做埋点');
  }

  void _salaryOnTap() async {
    ADJustTrackTool.trackWith('2kvi2o');
    String? selectedValue = await _showPickerWith(_salaryList, _salary);
    if (selectedValue != null) {
      setState(() {
        _salary = selectedValue;
      });
    }
  }

  void _workTitleOnTap() async {
    ADJustTrackTool.trackWith('mmxshd');
    String? selectedValue = await _showPickerWith(_workTitleList, _workTitle);
    if (selectedValue != null) {
      setState(() {
        _workTitle = selectedValue;
      });
    }
  }

  void _nextBtnClicked() async {
    ADJustTrackTool.trackWith('hbpns1');
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
      aYYppYlyAmount: '$_currentAmount',
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
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
                margin: const EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  color: Constants.themeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Target amount',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: amountDecrease,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 4.0, bottom: 4.0, right: 16.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: HexColor('#D2CECE'), width: 1),
                                ),
                              ),
                              child: const Text(
                                '—',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            '₹ $_currentAmount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Constants.themeColor,
                            ),
                          )),
                          TextButton(
                            onPressed: amountIncrease,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 4.0, bottom: 4.0, left: 16.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: HexColor('#D2CECE'),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹ $_minAmount',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text('₹ $_maxAmount',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
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
                onTap: () {
                  ADJustTrackTool.trackWith('hpcu39');
                },
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
