import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_elf/common/common_image.dart';
import 'package:rupee_elf/network_service/index.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/constants.dart';

class CommonImagePicker extends StatefulWidget {
  final bool isUpload;
  final List<String>? images;
  final ValueChanged<List<String>>? onChanged;

  const CommonImagePicker({
    super.key,
    this.onChanged,
    this.isUpload = true,
    this.images,
  });

  @override
  State<CommonImagePicker> createState() => _CommonImagePickerState();
}

class _CommonImagePickerState extends State<CommonImagePicker> {
  List<File> files = [];
  List<String> uploadedImages = [];

  _pickImage() async {
    var status = await Permission.photos.request();
    if (status == PermissionStatus.granted) {
      ImagePicker picker = ImagePicker();
      var image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      EasyLoading.show(
          status: 'uploading...', maskType: EasyLoadingMaskType.black);
      String imgUrl = await NetworkService.awsImageUpload(image.path);
      EasyLoading.dismiss();
      uploadedImages.add(imgUrl);
      if (widget.onChanged != null) {
        widget.onChanged!(uploadedImages);
      }
      setState(() {
        files = files..add(File(image.path));
      });
    } else {
      CommonToast.showToast(
          'You did not allow us to access the Photo Library, which will help you obtain a loan. Would you like to set up authorization.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 2 * 24 - 2 * 8) / 3;
    var height = width / (104 / 100);
    Widget addButton = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _pickImage,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.borderColor),
        ),
        child:
            const CommonImage(src: 'static/icons/take_photo_camera_icon.png'),
      ),
    );

    Widget wrapper(File file, {Function()? onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: Image.file(
            file,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    void imageOnTap(int index) {
      void imagesChanged(int deletedIndex, List<File> imageFils) {
        setState(() {
          files = imageFils;
        });
        uploadedImages.removeAt(deletedIndex);
        if (widget.onChanged != null) {
          widget.onChanged!(uploadedImages);
        }
      }

      Navigator.of(context).pushNamed('/photoPreview', arguments: {
        'currentIndex': index,
        'images': files,
        'valueChanged': imagesChanged
      });
    }

    List<Widget> getList() {
      if (widget.isUpload) {
        List<Widget> widgets = files
            .map(
              (file) => wrapper(
                file,
                onTap: () {
                  imageOnTap(files.indexOf(file));
                },
              ),
            )
            .toList();

        if (widgets.length < 9) {
          widgets = widgets..add(addButton);
        }

        return widgets;
      } else {
        return widget.images
                ?.map((imageUrl) => Container(
                      width: width,
                      height: height,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: CommonImage(
                        src: imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList() ??
            [];
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 6.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: getList(),
      ),
    );
  }
}
