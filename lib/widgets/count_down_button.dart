import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/can_disabled_button.dart';

class CountDownButton extends StatefulWidget {
  /// 倒计时数值
  final int countDownValue;

  /// session值，保持界面绝对倒计时
  final String session;

  /// 非计时时显示的按钮文字
  final String? text;

  /// 点击后的回调
  final Function(CountDownButtonState state)? onTap;

  final double width;
  final double height;
  final bool isCircle;
  final bool isNotPadding;
  final double fontSize;
  final Color textColor;

  const CountDownButton({
    super.key,
    required this.countDownValue,
    required this.session,
    this.text,
    this.onTap,
    this.width = 60.0,
    this.height = 40.0,
    this.fontSize = 14.0,
    this.isCircle = false,
    this.isNotPadding = false,
    this.textColor = Colors.black,
  });

  @override
  State<StatefulWidget> createState() => CountDownButtonState();
}

class CountDownButtonState extends State<CountDownButton> {
  final String boolSuffix = "BOOL";
  final String intSuffix = "INT";

  /// 当前进度文本
  late String _text;

  /// 按钮是否不可用
  bool _disabled = false;

  /// 计时器
  Timer? timer;

  /// 开始计时时的时间戳
  int? _startTimeMillis;

  /// 是否是计时状态
  bool? _isStart;

  @override
  void initState() {
    super.initState();
    _text = widget.text ?? '';
    _isStart = Global.prefs?.getBool(widget.session + boolSuffix) ?? false;
    int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
    int startTimeMillis = Global.prefs?.getInt(widget.session + intSuffix) ?? 0;
    if (startTimeMillis != 0 &&
        (currentTimeMillis - startTimeMillis) / 1000 <= widget.countDownValue &&
        (_isStart ?? false)) {
      startTimer();
    }
  }

  void startTimer() {
    int count = 0;
    int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
    int startTimeMillis = Global.prefs?.getInt(widget.session + intSuffix) ?? 0;
    if (startTimeMillis == 0 ||
        (currentTimeMillis - startTimeMillis) / 1000 > widget.countDownValue) {
      _startTimeMillis = currentTimeMillis;
    } else {
      count = (currentTimeMillis - startTimeMillis) ~/ 1000;
      _startTimeMillis = startTimeMillis;
    }
    //计时器，每1秒执行一次
    const period = Duration(seconds: 1);
    timer = Timer.periodic(period, (timer) {
      count++;
      num max = widget.countDownValue;
      //计时器结束条件
      if (widget.countDownValue == 0 || count >= max) {
        timer.cancel();
        if (mounted) {
          _isStart = false;
          Global.prefs?.setBool(widget.session + boolSuffix, false);
          Global.prefs?.setInt(widget.session + intSuffix, 0);
          setState(() {
            _text = widget.text ?? '';
            _disabled = false;
          });
        }
      } else {
        if (mounted) {
          _isStart = true;
          setState(() {
            _text = '${widget.countDownValue - count} s';
            _disabled = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    //退出时关闭计时器防止内存泄露
    timer?.cancel();
    Global.prefs?.setBool(widget.session + boolSuffix, _isStart ?? false);
    Global.prefs?.setInt(widget.session + intSuffix, _startTimeMillis ?? 0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CanDisableButton(
        title: _text,
        isDisabled: _disabled,
        isCircle: widget.isCircle,
        isNotPadding: widget.isNotPadding,
        textColor: widget.textColor,
        onTap: (isDisabled) {
          if (widget.onTap != null && !isDisabled) {
            widget.onTap!(this);
          }
        },
      ),
    );
  }
}
