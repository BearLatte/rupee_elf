// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/component/auth/contact_relation_item.dart';
import 'package:rupee_elf/models/contact_model.dart';
import 'package:rupee_elf/models/user_auth_submit_model.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/adjust_track_tool.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/common_picker/index.dart';
import 'package:rupee_elf/util/constants.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/auth_base_widget.dart';
import 'package:rupee_elf/widgets/hidden_keyboard_wraper.dart';
import 'package:rupee_elf/widgets/theme_button.dart';

import '../../models/certification_info_model.dart';

class AuthThirdPage extends StatefulWidget {
  const AuthThirdPage({super.key});

  @override
  State<AuthThirdPage> createState() => _AuthThirdPageState();
}

class _AuthThirdPageState extends State<AuthThirdPage> {
  List<String> _relationList = [];
  List<ContactModel> _currentContactList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    CertificationInfoModel? info = await NetworkService.getCertificationInfo();
    if (info != null) {
      _relationList = info.relationList;
      List contactList =
          info.contactList.isNotEmpty ? jsonDecode(info.contactList) : [];

      setState(
        () {
          if (contactList.isEmpty) {
            for (int i = 0; i < info.contactNum; i++) {
              _currentContactList.add(ContactModel());
            }
          } else {
            _currentContactList = contactList.map((item) {
              ContactModel contact = ContactModel();
              contact.relationController.text = item['contactRelation'] ?? '';
              contact.nameController.text = item['contactName'] ?? '';
              contact.numberController.text = item['contactPhone'] ?? '';
              return contact;
            }).toList();
          }
        },
      );
    }
  }

  void rightAddBtnOnPressed() {
    setState(() {
      _currentContactList.add(ContactModel());
    });
  }

  void itemRelationOnTap(int index) async {
    switch (index) {
      case 0:
      case 1:
        break;
      case 2:
        ADJustTrackTool.trackWith('ds7028');
        break;
      case 3:
        ADJustTrackTool.trackWith('oj1h79');
        break;
      case 4:
        ADJustTrackTool.trackWith('7av4jz');
        break;
    }
    var result = await CommonPicker.showPicker(
      context: context,
      options: _relationList,
      value: 0,
    );

    if (result != null) {
      setState(() {
        _currentContactList[index].relationController.text =
            _relationList[result];
      });
    }
  }

  void itemNumberOnTap(int index) async {
    switch (index) {
      case 0:
        ADJustTrackTool.trackWith('13udb5');
        break;
      case 1:
        ADJustTrackTool.trackWith('ngctqv');
        break;
      case 2:
        ADJustTrackTool.trackWith('ds7028');
        break;
      case 3:
        ADJustTrackTool.trackWith('oj1h79');
        break;
      case 4:
        ADJustTrackTool.trackWith('8xr00x');
        break;
    }
    PermissionStatus state = await Permission.contacts.request();
    if (state == PermissionStatus.granted) {
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);
      List<String> options = contacts.map((contact) {
        String name = contact.displayName;
        String number =
            contact.phones.isEmpty ? '' : contact.phones.first.number;
        return '$name - $number';
      }).toList();
      int? selectedIndex = await CommonPicker.showPicker(
        context: context,
        options: options,
        value: 0,
      );
      if (selectedIndex != null) {
        setState(() {
          Contact contact = contacts[selectedIndex];
          _currentContactList[index].nameController.text = contact.displayName;
          _currentContactList[index].numberController.text =
              contact.phones.isEmpty ? '' : contact.phones.first.number;
        });
      }
    } else {
      await CommonToast.showToast(
          'You did not allow us to access the contacts. Allowing it will help you obtain a loan. Do you want to set up authorization.');
    }
  }

  void itemNameOnTap(int index) {
    switch (index) {
      case 0:
        ADJustTrackTool.trackWith('7yxyxm');
        break;
      case 1:
        ADJustTrackTool.trackWith('1qwzi6');
        break;
      case 2:
        ADJustTrackTool.trackWith('w19z5o');
        break;
      case 3:
        ADJustTrackTool.trackWith('7av4jz');
        break;
      case 4:
        ADJustTrackTool.trackWith('vglfpo');
        break;
    }
  }

  void nextBtnOnPressed() async {
    ADJustTrackTool.trackWith('94z8a1');

    List<Map<String, String>> contactList = [];
    for (ContactModel contact in _currentContactList) {
      String contactName = contact.contactName;
      String contactNumber = contact.contactPhone;
      String contactRelation = contact.contactRelation;
      if (contactName.trim().isEmpty ||
          contactNumber.trim().isEmpty ||
          contactRelation.trim().isEmpty) {
        await CommonToast.showToast('Please complete all the information.');
        return;
      }

      contactList.add({
        'contactRelation': contactRelation,
        'contactName': contactName,
        'contactPhone': contactNumber
      });
    }

    UserAuthSubmitModel model = UserAuthSubmitModel(
        aYYutYhStep: '3', cYYonYtactList: jsonEncode(contactList));

    NetworkService.userAuthSubmit(model, () {
      Navigator.of(context).pushNamed('/authFourth');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthBaseWidget(
      'My authentication',
      isShowTrailingButton:
          Global.instance.currentAccount != Constants.APP_STORE_AUDIT_ACCOUNT,
      totalStep: 4,
      currentStep: 3,
      trailingOnPressed: rightAddBtnOnPressed,
      contentBuilder: (context) {
        return HiddenKeyboardWrapper(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: ListView(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonImage(src: 'static/icons/auth_horn_icon.png'),
                      const Padding(padding: EdgeInsets.only(right: 10.0)),
                      Expanded(
                        child: Text(
                          'The richer the information, the easier to obtain loans.',
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Constants.seconaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...List.generate(_currentContactList.length, (index) {
                  Widget item = ContactRelationItem(
                    relationOnTap: () {
                      itemRelationOnTap(index);
                    },
                    nameOnTap: () {
                      itemNameOnTap(index);
                    },
                    phoneBookOnTap: () => itemNumberOnTap(index),
                    relationController:
                        _currentContactList[index].relationController,
                    nameController: _currentContactList[index].nameController,
                    numberController:
                        _currentContactList[index].numberController,
                    numberOnTap: Global.instance.currentAccount ==
                            Constants.APP_STORE_AUDIT_ACCOUNT
                        ? null
                        : () => itemNumberOnTap(index),
                    isNumberInputEnable: Global.instance.currentAccount ==
                        Constants.APP_STORE_AUDIT_ACCOUNT,
                  );
                  return item;
                }),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ThemeButton(
                  width: 252.0,
                  height: 52.0,
                  title: 'Next',
                  onPressed: nextBtnOnPressed,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
