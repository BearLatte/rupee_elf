import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum DragDirection { top, right, left, bottom }

class GestureDragWidget extends StatefulWidget {
  /// 拖拽组件需要展示的内容
  final Widget? child;

  /// 子内容大小
  final double childSize;

  /// 默认的偏移量
  final double originOffset;

  /// 父组件高度
  final double parentHeight;

  /// 父组件宽度
  final double parentWidth;

  /// 拖拽方向
  final DragDirection direction;

  const GestureDragWidget(
      {super.key,
      this.childSize = 0,
      this.originOffset = 0,
      this.parentHeight = 0,
      this.parentWidth = 0,
      this.direction = DragDirection.left,
      this.child});

  @override
  State<GestureDragWidget> createState() => _GestureDragWidgetState();
}

class _GestureDragWidgetState extends State<GestureDragWidget>
    with TickerProviderStateMixin {
  /// 初始化状态:设置宽度、起始偏移量、最小偏移量、中间偏移量、最大偏移量
  _initValue() {
    width = widget.childSize.abs();
    minOffset = -width / 2;
    midOffset = -width / 3;
    maxOffset = 0;

    /// 底部和右边的偏移量需要特殊计算初始值（右边和底部的值偏移量 = 父组件的宽或高 - 初始预设偏移量）
    switch (widget.direction) {
      case DragDirection.bottom:
        originOffset = widget.parentHeight - widget.originOffset;
        maxOffset = widget.parentHeight - width;
        midOffset = maxOffset + width / 3;
        minOffset = maxOffset + width / 2;
        break;
      case DragDirection.right:
        originOffset = widget.parentWidth - widget.originOffset;
        maxOffset = widget.parentWidth - width;
        midOffset = maxOffset + width / 3;
        minOffset = maxOffset + width / 2;
        break;
      default:
        originOffset = -width + widget.originOffset;
        break;
    }
    print(
        "dragdemo minOffset: $minOffset  midOffset: $midOffset  maxOffset: $maxOffset");
  }

  /// 复原动画
  _setCallBackAnimation() {
    double offset;
    switch (widget.direction) {
      //根据方向设置起始偏移值
      case DragDirection.top:
      case DragDirection.bottom:
        offset = offsetY;
        break;
      case DragDirection.left:
      case DragDirection.right:
        offset = offsetX;
        break;
    }
    print("dragdemo _setCallBackAnimation  begin: $offset, end: $originOffset");
    _animation = Tween<double>(begin: offset, end: originOffset).animate(
        CurvedAnimation(
            parent: _callbackAnimationController, curve: Curves.easeOut))
      ..addListener(() {
        print("dragdemo _setCallBackAnimation  ${_animation.value}");
        setState(() {
          switch (widget.direction) {
            case DragDirection.top:
            case DragDirection.bottom:
              offsetY = _animation.value;
              break;
            case DragDirection.left:
            case DragDirection.right:
              offsetX = _animation.value;
              break;
          }
        });
      });
  }

  /// 展开动画
  _setToMaxAnimation() {
    double offset;
    switch (widget.direction) {
      //根据方向设置起始偏移值
      case DragDirection.top:
      case DragDirection.bottom:
        offset = offsetY;
        break;
      case DragDirection.left:
      case DragDirection.right:
        offset = offsetX;
        break;
    }
    print("dragdemo _setToMaxAnimation  begin: $offset, end: $maxOffset");
    _animation = Tween<double>(begin: offset, end: maxOffset).animate(
        CurvedAnimation(
            parent: _toMaxAnimationController, curve: Curves.easeOutQuart))
      ..addListener(() {
        print("dragdemo _setToMaxAnimation    ${_animation.value}");
        setState(() {
          switch (widget.direction) {
            case DragDirection.top:
            case DragDirection.bottom:
              offsetY = _animation.value;
              break;
            case DragDirection.left:
            case DragDirection.right:
              offsetX = _animation.value;
              break;
          }
        });
      });
  }

  /// 偏移量最大值
  double maxOffset = 300;

  ///偏移量中间值
  double midOffset = 250;

  /// 偏移量最小值
  double minOffset = 200;

  /// 组件宽度
  late double width;

  /// 初始偏移量
  double originOffset = -100;

  /// 水平偏移量
  double offsetY = 0;

  /// 垂直偏移量
  double offsetX = 0;

  ///缩回动画控制器
  late AnimationController _callbackAnimationController;

  ///展开动画控制器
  late AnimationController _toMaxAnimationController;

  /// 动画对象
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _initValue();
    _callbackAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _toMaxAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    switch (widget.direction) {
      case DragDirection.top:
        offsetY = originOffset;
        break;
      case DragDirection.bottom:
        offsetY = originOffset;
        break;
      case DragDirection.left:
        offsetX = originOffset;
        break;
      case DragDirection.right:
        offsetX = originOffset;
        break;
    }
    print("dragdemo offsetY $offsetY offsetX $offsetX");
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offsetX, offsetY),
      child: RawGestureDetector(
        gestures: {
          DrawerPanGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<DrawerPanGestureRecognizer>(
            () => DrawerPanGestureRecognizer(),
            (DrawerPanGestureRecognizer instance) {
              // ignore: unused_element
              onUpdate(DragUpdateDetails details) {
                switch (widget.direction) {
                  case DragDirection.top:
                    if (offsetY <= maxOffset) {
                      setState(() {
                        offsetY = offsetY + details.delta.dy;
                      });
                    }
                    break;
                  case DragDirection.bottom:
                    if (offsetY >= maxOffset) {
                      setState(() {
                        offsetY = offsetY + details.delta.dy;
                      });
                    }
                    break;
                  case DragDirection.left:
                    if (offsetX <= maxOffset) {
                      setState(() {
                        offsetX = offsetX + details.delta.dx;
                      });
                    }
                    break;
                  case DragDirection.right:
                    if (offsetX >= maxOffset) {
                      setState(() {
                        offsetX = offsetX + details.delta.dx;
                      });
                    }
                    break;
                }
              }

              // ignore: unused_element
              onEnd(DragEndDetails details) {
                print(
                    "dragdemo onend minOffset $minOffset - offsetX $offsetX - offsetY $offsetY");
                switch (widget.direction) {
                  case DragDirection.top:
                    if (offsetY < minOffset) {
                      _setCallBackAnimation();
                      _callbackAnimationController.forward(from: offsetY);
                    } else if (offsetY > minOffset) {
                      _setToMaxAnimation();
                      _toMaxAnimationController.forward(from: offsetY);
                    }
                    break;
                  case DragDirection.bottom:
                    if (offsetY > minOffset) {
                      _setCallBackAnimation();
                      _callbackAnimationController.reset();
                      _callbackAnimationController.forward();
                    } else if (offsetY < minOffset) {
                      _setToMaxAnimation();
                      _toMaxAnimationController.reset();
                      _toMaxAnimationController.forward();
                    }
                    break;
                  case DragDirection.left:
                    if (offsetX < minOffset) {
                      _setCallBackAnimation();
                      _callbackAnimationController.forward(from: offsetX);
                    } else if (offsetX > minOffset) {
                      _setToMaxAnimation();
                      _toMaxAnimationController.forward(from: offsetX);
                    }
                    break;
                  case DragDirection.right:
                    if (offsetX > minOffset) {
                      _setCallBackAnimation();
                      _callbackAnimationController.reset();
                      _callbackAnimationController.forward();
                    } else if (offsetX < minOffset) {
                      _setToMaxAnimation();
                      _toMaxAnimationController.reset();
                      _toMaxAnimationController.forward();
                    }
                    break;
                }
              }
            },
          ),
        },
        child: SizedBox(
          width: width,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _callbackAnimationController.dispose();
    _toMaxAnimationController.dispose();
  }
}

class DrawerPanGestureRecognizer extends PanGestureRecognizer {}
