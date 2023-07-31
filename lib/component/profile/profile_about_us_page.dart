import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/global.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class ProfileAboutUsPage extends StatelessWidget {
  const ProfileAboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'About Us',
      child: Stack(children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
              top: 20.0, left: 20.0, bottom: 34.0, right: 20.0),
          child: Column(
            children: [
              const CommonImage(src: 'static/images/profile_about_us_img.png'),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Text('Version ${Global.packageInfo.version}')
            ],
          ),
        )
      ]),
    );
  }
}
