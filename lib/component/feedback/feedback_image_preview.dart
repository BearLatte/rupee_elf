import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/util/iconfont.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class FeedbackImagePreview extends StatefulWidget {
  final int currentIndex;
  final List<File> images;
  final void Function(int index, List<File> images) onValueChanged;
  const FeedbackImagePreview({
    super.key,
    required this.currentIndex,
    required this.images,
    required this.onValueChanged,
  });

  @override
  State<FeedbackImagePreview> createState() => _FeedbackImagePreviewState();
}

class _FeedbackImagePreviewState extends State<FeedbackImagePreview> {
  late int _currentIndex;
  late int _totalCount;
  late List<File> _images;

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget.currentIndex;
      _images = widget.images;
      _totalCount = _images.length;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int configScrollResult(FixedScrollMetrics metrics) {
    return (metrics.pixels / metrics.viewportDimension).truncate();
  }

  void deleteBtnClicked() {
    setState(() {
      _images.removeAt(_currentIndex);
      _totalCount = _images.length;

      int current =
          _currentIndex >= _images.length ? _currentIndex - 1 : _currentIndex;
      _currentIndex = current < 1 ? 0 : current;
    });

    widget.onValueChanged(_currentIndex, _images);

    if (_images.isEmpty) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width - 24.0;
    _controller =
        ScrollController(initialScrollOffset: _currentIndex * itemWidth);
    return BaseViewWidget(
      title: '${_currentIndex + 1} / $_totalCount',
      actions: [
        IconButton(
          onPressed: deleteBtnClicked,
          icon: const Icon(IconFont.icon_trash),
        )
      ],
      child: Stack(
        children: [
          // 背景
          Column(
            children: [
              Container(height: MediaQuery.of(context).size.width * 0.3),
              Expanded(child: Container(color: HexColor('#F5F4F3')))
            ],
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 35.0),
            clipBehavior: Clip.hardEdge,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
            child: NotificationListener(
              onNotification: (ScrollUpdateNotification notification) {
                setState(() {
                  _currentIndex = configScrollResult(
                      notification.metrics as FixedScrollMetrics);
                });
                return false;
              },
              child: ListView.builder(
                physics: const PageScrollPhysics(),
                itemCount: _images.length,
                scrollDirection: Axis.horizontal,
                controller: _controller,
                itemExtent: itemWidth,
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    _images[index],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width - 24.0,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
