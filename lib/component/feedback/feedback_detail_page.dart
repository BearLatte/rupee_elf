import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/models/feedback_item_model.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/widgets/common_image_picker.dart';

class FeedbackDetailPage extends StatelessWidget {
  final FeedbackItemModel item;
  const FeedbackDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Constants.themeTextColor,
          ),
        ),
        elevation: 0,
        backgroundColor: HexColor('#F5F4F3'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              IconFont.icon_back,
              color: Constants.themeTextColor,
              size: 16.0,
            )),
      ),
      body: Container(
        color: Constants.seconaryBackgroundColor,
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: ListView(
          children: [
            if (item.feedBackState == 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 135.0,
                    width: MediaQuery.of(context).size.width - 24.0,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      item.replyContent ?? '',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Constants.themeTextColor,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Text(
                    item.replyTime ?? '2021-12-12 12:00:00',
                    style: TextStyle(
                      color: Constants.seconaryTextColor,
                      fontSize: 12.0,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 35.0))
                ],
              ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: HexColor('#FFE6D8'),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: CommonImage(
                          src: item.productLogo,
                          width: 40.0,
                          height: 40.0,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 10.0)),
                      Text(
                        item.productName,
                        style: TextStyle(
                          color: Constants.themeTextColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Text(
                    'Order Number :${item.loanOrderNo}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Constants.themeTextColor,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Text(
                    item.feedBackType,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Constants.themeColor, fontSize: 16.0),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.only(
                  top: 16.0, left: 12.0, right: 12.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100.0,
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Text(
                      item.feedBackContent,
                      style: TextStyle(
                        color: Constants.themeTextColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                  CommonImagePicker(
                    images: _getImageList(item.feedBackImg ?? ''),
                    isUpload: false,
                  )
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Row(
              children: [
                const Spacer(),
                Text(
                  item.feedBackTime,
                  style: TextStyle(color: Constants.seconaryTextColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<String> _getImageList(String source) {
    List<dynamic> jsonObj = json.decode(source);
    return jsonObj.map((item) => item.toString()).toList();
  }
}
