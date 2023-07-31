import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class FaceAuthPage extends StatefulWidget {
  const FaceAuthPage({super.key});

  @override
  State<FaceAuthPage> createState() => _FaceAuthPageState();
}

class _FaceAuthPageState extends State<FaceAuthPage> {
  bool _isShowIndicator = true;
  bool _isShowBottomBar = false;
  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      title: 'Detail',
      child: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 20.0,
          bottom: 34.0,
          right: 20.0,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 44.0,
              child: _isShowIndicator
                  ? const Text(
                      'Please keep all faces in the viewfinder and must upload clear photos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    )
                  : null,
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 2 * 20.0,
              height: MediaQuery.of(context).size.width - 2 * 20.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.5),
                ),
              ),
            ),
            const Spacer(),
            // 底部按钮
            _isShowBottomBar ? _bottomBar() : _takePhotoButton(),
          ],
        ),
      ),
    );
  }

  void _takePhoto() {
    debugPrint('DEBUG: 拍照上传');
    setState(() {
      _isShowIndicator = !_isShowIndicator;
      _isShowBottomBar = !_isShowBottomBar;
    });
  }

  void _cancelButtonOnPressed() {
    setState(() {
      _isShowIndicator = !_isShowIndicator;
      _isShowBottomBar = !_isShowBottomBar;
    });
  }

  void _selectButtonOnPressed() {}

  Widget _bottomBar() {
    return SizedBox(
      height: 52.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 162.0,
            height: 52.0,
            decoration: BoxDecoration(
              color: HexColor('#F4BD9F'),
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: TextButton(
              onPressed: _cancelButtonOnPressed,
              child: const Text(
                'Retry',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Container(
            width: 162.0,
            height: 52.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: TextButton(
              onPressed: _selectButtonOnPressed,
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _takePhotoButton() {
    return Container(
      width: 252.0,
      height: 52.0,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: TextButton(
        onPressed: _takePhoto,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonImage(src: 'static/icons/take_photo_camera_icon.png'),
            Padding(padding: EdgeInsets.only(right: 10.0)),
            Text(
              'Photograph',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
