import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class MD5Util {
  static String md5String(String origin) {
    debugPrint('DEBUG: 加密前 $origin');
    var content = const Utf8Encoder().convert(origin);
    var degit = md5.convert(content).toString().toUpperCase();
    debugPrint('DEBUG: 加密后 $degit');
    return degit;
  }

}
