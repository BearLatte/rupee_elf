import 'package:flutter/material.dart';

class ContactModel {
  TextEditingController relationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  String get contactRelation => relationController.text;
  String get contactName => nameController.text;
  String get contactPhone => numberController.text;
}
