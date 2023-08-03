import 'dart:convert';
import 'package:crypto/crypto.dart';

class MD5Util {
  static String md5String(String origin) {
    var content = const Utf8Encoder().convert(origin);
    return md5.convert(content).toString().toUpperCase();
  }
}
