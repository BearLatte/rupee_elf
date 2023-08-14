import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/util/hexcolor.dart';
import 'package:rupee_elf/widgets/base_view_widget.dart';

class FaceAuthPage extends StatefulWidget {
  const FaceAuthPage({super.key});

  @override
  State<FaceAuthPage> createState() => _FaceAuthPageState();
}

class _FaceAuthPageState extends State<FaceAuthPage>
    with WidgetsBindingObserver {
  bool _isShowIndicator = true;
  bool _isShowBottomBar = false;

  // 可用摄像头列表
  List<CameraDescription> _cameras = [];
  // 相机控制器
  CameraController? _controller;
  // 是否已初始化相机
  bool _isCameraInitialized = false;
  // 当前拍的照片对象
  XFile? _currentImgFile;

  @override
  void initState() {
    _configCamera();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // 配置相机
  _configCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();

    // 上一次使用的controller
    final previousCameraController = _controller;
    // 实例化控制器
    final CameraController cameraController = CameraController(
      _cameras[1],
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // 注销掉上一次使用的控制器
    await previousCameraController?.dispose();

    // 替换为新的控制器
    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    // 更新UI页面
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    // 初始化相机控制器
    await cameraController.initialize();
    if (mounted) {
      setState(() {
        _isCameraInitialized = _controller?.value.isInitialized ?? false;
      });
    }
  }

  // 监听app的生命周期
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _configCamera();
    }

    super.didChangeAppLifecycleState(state);
  }

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
            _isCameraInitialized
                ? ClipOval(
                    child: Transform.scale(
                      scale: 1 +
                          (MediaQuery.of(context).size.width - 40) /
                              MediaQuery.of(context).size.width,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Center(
                          child: CameraPreview(_controller!),
                        ),
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 2 * 20.0,
                    height: MediaQuery.of(context).size.width - 2 * 20.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                            MediaQuery.of(context).size.width * 0.5),
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

  void _takePhoto() async {
    final CameraController? cameraController = _controller;

    if (cameraController!.value.isTakingPicture) {
      return;
    }

    XFile imgFile = await cameraController.takePicture();
    _currentImgFile = imgFile;
    cameraController.pausePreview();

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

    _controller?.resumePreview();
  }

  void _selectButtonOnPressed() {
    if (_currentImgFile == null) {
      _controller?.resumePreview();
      return;
    }

    
  }

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
