import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late List feedbackList = [];

  @override
  void initState() {
    super.initState();
    _getFeedbackList();
  }

  void _getFeedbackList() {
    debugPrint('DEBUG: 获取 Feedback 列表');
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'My feedback',
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Constants.seconaryBackgroundColor,
        child: feedbackList.isNotEmpty ? _fillChild() : _emptyChild(),
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
    return ListView();
  }
}
