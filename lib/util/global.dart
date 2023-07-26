import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rupee_elf/util/hexcolor.dart';

class Global {
  static Color themeColor = HexColor('#F05C09');
  static Color themeTextColor = HexColor('#333333');
  static Color seconaryTextColor = HexColor('#999999');
  static Color borderColor = HexColor('#DDDDDD');
  static Color randomColor = Color.fromARGB(255, Random().nextInt(256) + 0,
      Random().nextInt(256) + 0, Random().nextInt(256) + 0);
}
