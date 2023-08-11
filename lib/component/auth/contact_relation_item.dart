import 'package:flutter/material.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/iconfont.dart';

class ContactRelationItem extends StatelessWidget {
  final Function() relationOnTap;
  final Function()? numberOnTap;
  final Function()? phoneBookOnTap;
  final bool isNumberInputEnable;
  final TextEditingController relationController;
  final TextEditingController nameController;
  final TextEditingController numberController;

  const ContactRelationItem({
    super.key,
    this.isNumberInputEnable = false,
    required this.relationOnTap,
    this.numberOnTap,
    required this.relationController,
    required this.nameController,
    required this.numberController,
    this.phoneBookOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 15.0)),
        _itemContainer(
          'Ralation',
          icon: Icon(
            Icons.keyboard_arrow_right,
            color: Constants.arrowColor,
            size: 16.0,
          ),
          isInputEnable: false,
          onTap: relationOnTap,
          controller: relationController,
        ),
        _itemContainer(
          'Name',
          icon: IconButton(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 0),
            onPressed: phoneBookOnTap,
            icon: Icon(
              IconFont.icon_dianhuabu,
              color: Constants.themeColor,
              size: 16.0,
            ),
          ),
          isInputEnable: true,
          controller: nameController,
        ),
        _itemContainer(
          'Number',
          isInputEnable: isNumberInputEnable,
          onTap: numberOnTap,
          controller: numberController,
        )
      ],
    );
  }

  Widget _itemContainer(String hitText,
      {Widget? icon,
      required bool isInputEnable,
      Function()? onTap,
      required TextEditingController controller}) {
    return Container(
      height: 45.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Constants.borderColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              // enabled: false,
              readOnly: !isInputEnable,
              onTap: onTap,
              controller: controller,
              decoration: InputDecoration(
                hintText: hitText,
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: Constants.seconaryTextColor,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 16.0, color: Constants.themeTextColor),
            ),
          ),
          if (icon != null) icon
        ],
      ),
    );
  }
}
