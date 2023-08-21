import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/models/feedback_item_model.dart';
import 'package:rupee_elf/models/feedback_list_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<FeedbackItemModel> _feedbackList = [];

  @override
  void initState() {
    super.initState();
    _getFeedbackList();
  }

  void _getFeedbackList() async {
    debugPrint('DEBUG: 获取 Feedback 列表');
    FeedbackListModel? model = await NetworkService.getFeedbackList();
    if (model != null) {
      setState(() {
        _feedbackList = model.feedBackList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'My feedback',
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Constants.seconaryBackgroundColor,
        child: _feedbackList.isNotEmpty ? _fillChild() : _emptyChild(),
      ),
    );
  }

  Widget _emptyChild() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        CommonImage(src: 'static/images/feedback_img.png'),
        Padding(padding: EdgeInsets.only(bottom: 14.0)),
        Text(
          'Please tell us your problems. We\nwill solve in time.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        Spacer(),
        Spacer(),
      ],
    );
  }

  Widget _fillChild() {
    return ListView(
      children: _feedbackList.map((feedback) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.of(context)
                .pushNamed('/feedbackDetail', arguments: feedback);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: CommonImage(
                        src: feedback.productLogo,
                        width: 36.0,
                        height: 36.0,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 8.0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feedback.productName,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Constants.themeTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                        Text(feedback.feedBackTime,
                            style: TextStyle(color: HexColor('#C3C3C3')))
                      ],
                    ),
                    const Spacer(),
                    if (feedback.feedBackState == 1)
                      Container(
                        constraints: const BoxConstraints(minWidth: 28.0),
                        height: 28.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Constants.themeColor,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                Text(
                  feedback.feedBackType,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16.0, color: Constants.themeColor),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
