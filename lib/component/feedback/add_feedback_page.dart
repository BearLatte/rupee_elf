import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_form_item.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/feedback_type_model.dart';
import 'package:rupee_elf/models/order_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/common_alert.dart';
import 'package:rupee_elf/util/common_picker/index.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';
import 'package:rupee_elf/widgets/common_image_picker.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

class AddFeedbackPage extends StatefulWidget {
  final OrderModel orderInfo;
  final List<FeedbackTypeModel> feedbackTypes;
  const AddFeedbackPage({
    super.key,
    required this.feedbackTypes,
    required this.orderInfo,
  });

  @override
  State<AddFeedbackPage> createState() => _AddFeedbackPageState();
}

class _AddFeedbackPageState extends State<AddFeedbackPage> {
  late final String _productName;
  late final String _orderNumber;
  late final String _productLogo;
  late final TextEditingController _descriptionController;

  String _questionType = '';
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    setState(() {
      _productLogo = widget.orderInfo.productLogo;
      _productName = widget.orderInfo.productName;
      _orderNumber = widget.orderInfo.loanOrderNo;
    });
  }

  void chooseQuestionTypeAction() async {
    List<String> options =
        widget.feedbackTypes.map((type) => type.feedBacktype).toList();
    var result = await CommonPicker.showPicker(
        context: context, options: options, value: 0);
    if (result != null) {
      setState(() {
        _questionType = options[result];
      });
    }
  }

  void onSubmit() async {
    if (_questionType.trim().isEmpty) {
      await CommonToast.showToast('Please choose type of question!');
      return;
    }

    if (_descriptionController.text.trim().isEmpty) {
      await CommonToast.showToast('Please describe your problem!');
      return;
    }

    BaseModel? model = await NetworkService.submitFeedback(
      orderNumber: _orderNumber,
      feedBackType: _questionType,
      feedBackContent: _descriptionController.text,
      feedBackImg: jsonEncode(_images),
    );

    if (model != null) {
      if (context.mounted) {
        CommonAlert.showAlert(
                context: context,
                type: AlertType.succesed,
                message: 'Submitted successfully')
            .then((value) {
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'Submit feedback',
      child: HiddenKeyboardWrapper(
        child: Stack(
          children: [
            // 背景
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                ),
                Expanded(
                    child: Container(
                  color: HexColor('#F5F4F3'),
                ))
              ],
            ),
            // 内容
            ListView(
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                const Center(
                  child: Text(
                    'Please describe your problem or suggestion.',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14.0, bottom: 30.0),
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: _contentView(),
                ),
                ThemeButton(
                  width: 252.0,
                  height: 52.0,
                  title: 'Submit',
                  onPressed: onSubmit,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _contentView() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: CommonImage(
                    width: 36.0,
                    height: 36.0,
                    fit: BoxFit.cover,
                    src: _productLogo),
              ),
              const Padding(padding: EdgeInsets.only(right: 8.0)),
              Text(
                _productName,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Constants.themeTextColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 6.0)),
          Row(
            children: [
              Text(
                'Order Number :',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Constants.seconaryTextColor,
                ),
              ),
              Text(
                _orderNumber,
                style:
                    TextStyle(color: Constants.themeTextColor, fontSize: 16.0),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10.0)),
          CommonFormItem(
            type: FormType.selecte,
            hintText: 'Types of question',
            padding: EdgeInsets.zero,
            inputValue: _questionType,
            onTap: chooseQuestionTypeAction,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Constants.borderColor, width: 1.0),
            ),
            child: TextField(
              controller: _descriptionController,
              style: const TextStyle(fontSize: 14.0),
              decoration: const InputDecoration(
                hintText: 'Please describe your problem.',
                border: InputBorder.none,
              ),
              maxLines: 5,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 15.0),
            child: Text(
              'Upload your pictures to show your problem.',
              style: TextStyle(fontSize: 14.0, color: Constants.themeTextColor),
            ),
          ),
          CommonImagePicker(onChanged: (value) => _images = value)
        ],
      ),
    );
  }
}
