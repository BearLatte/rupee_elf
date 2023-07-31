import 'package:flutter/material.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: '',
      child: Container(
        margin: const EdgeInsets.only(top: 220.0),
        width: MediaQuery.of(context).size.width,
        color: HexColor('#F5F4F3'),
        child: Stack(),
      ),
    );
  }
}
