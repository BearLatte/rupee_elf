import 'package:flutter/material.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/iconfont.dart';

class ContactRelationItem extends StatefulWidget {
  const ContactRelationItem({super.key});

  @override
  State<ContactRelationItem> createState() => _ContactRelationItemState();
}

class _ContactRelationItemState extends State<ContactRelationItem> {
  Widget _itemContainer(String hitText, Icon? icon, bool isInputEnable) {
    return Container(
      height: 45.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Global.borderColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              // enabled: false,
              readOnly: !isInputEnable,
              onTap: () {
                debugPrint('这里点击选择关系');
              },
              decoration: InputDecoration(
                hintText: hitText,
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: Global.seconaryTextColor,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 16.0, color: Global.themeTextColor),
            ),
          ),
          if (icon != null) icon
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 15.0)),
        _itemContainer(
          'Ralation',
          Icon(
            Icons.keyboard_arrow_right,
            color: Global.arrowColor,
            size: 16.0,
          ),
          false,
        ),
        _itemContainer(
          'Name',
          Icon(
            IconFont.icon_dianhuabu,
            color: Global.themeColor,
            size: 16.0,
          ),
          true,
        ),
        _itemContainer('Number', null, true)
      ],
    );
  }
}
