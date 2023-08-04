import 'package:fluttertoast/fluttertoast.dart';

class CommonToast {
  static showToast(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.CENTER);
  }
}
