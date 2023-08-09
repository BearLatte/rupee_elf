import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonPicker {
  static Future<int?> showPicker({
    required BuildContext context,
    required List<String> options,
    required int value,
    double height = 300.0,
  }) {
    return showCupertinoModalPopup<int>(
        context: context,
        builder: (context) {
          var textStyle = const TextStyle(fontWeight: FontWeight.w600);
          var controller = FixedExtentScrollController();
          return Container(
            color: Colors.white,
            height: height,
            child: Column(
              children: [
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0, color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            '取消',
                            style: textStyle,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(controller.selectedItem);
                          },
                          child: Text(
                            '确定',
                            style: textStyle,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: controller,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    itemExtent: 32.0,
                    onSelectedItemChanged: (int value) {},
                    children: options.map((option) => Text(option)).toList(),
                  ),
                )
              ],
            ),
          );
        });
  }
}
