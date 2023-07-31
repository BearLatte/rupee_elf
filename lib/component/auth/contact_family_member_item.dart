import 'package:flutter/material.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/util/iconfont.dart';

class ContactFamilyMemberItem extends StatefulWidget {
  final String title;

  const ContactFamilyMemberItem({super.key, required this.title});

  @override
  State<ContactFamilyMemberItem> createState() =>
      _ContactFamilyMemberItemState();
}

class _ContactFamilyMemberItemState extends State<ContactFamilyMemberItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: 40.0)),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Global.themeTextColor,
          ),
        ),
        Container(
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
                    hintStyle: TextStyle(
                      fontSize: 16.0,
                      color: Global.seconaryTextColor,
                    ),
                  ),
                ),
              ),
              Icon(
                IconFont.icon_dianhuabu,
                color: Global.themeColor,
                size: 16.0,
              )
            ],
          ),
        ),
        Container(
          height: 45.0,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Global.borderColor),
            ),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Number',
              hintStyle:
                  TextStyle(fontSize: 16.0, color: Global.seconaryTextColor),
            ),
          ),
        )
      ],
    );
  }
}
