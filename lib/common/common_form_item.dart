import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';

enum FormType { input, date, selecte }

class CommonFormItem extends StatelessWidget {
  final double minHeight;
  final FormType type;
  final String hintText;
  final String? inputValue;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final void Function(String)? onValueChanged;
  final TextEditingController? editingController;

  const CommonFormItem({
    super.key,
    this.minHeight = 50,
    required this.type,
    required this.hintText,
    this.inputValue,
    this.keyboardType,
    this.onTap,
    this.onValueChanged,
    this.editingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      constraints: BoxConstraints(
          minHeight: minHeight,
          maxWidth: MediaQuery.of(context).size.width - 40),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Global.dividerColor),
        ),
      ),
      child: _getCurrentChild(),
    );
  }

  Widget _getCurrentChild() {
    switch (type) {
      case FormType.input:
        return _inputWidget();
      case FormType.date:
        return _dateWidget();
      case FormType.selecte:
        return _selectWidget();
    }
  }

  Widget _inputWidget() {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 16.0, color: Global.seconaryTextColor),
      ),
      keyboardType: keyboardType,
      onChanged: onValueChanged,
      style: TextStyle(fontSize: 16.0, color: Global.themeTextColor),
      onTap: onTap,
      maxLines: null,
    );
  }

  Widget _dateWidget() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Text(
              inputValue ?? hintText,
              style: TextStyle(
                fontSize: 16.0,
                color: inputValue == null
                    ? Global.seconaryTextColor
                    : Global.themeTextColor,
              ),
            ),
          ),
        ),
        const CommonImage(src: 'static/icons/auth_calendar_icon.png')
      ],
    );
  }

  Widget _selectWidget() {
    return Container();
  }
}
