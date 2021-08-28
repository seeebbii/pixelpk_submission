
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FileHandler{

  static Future<File>? takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80
    );
    return imageFile == null ? File('') : File(imageFile.path);
  }

  static Future<File>? getImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80
    );
    return imageFile == null ? File('') : File(imageFile.path);
  }

}