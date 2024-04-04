import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  Future<File?> pickImage(ImageSource source);
  Future<void> _pickProfileImage(ImageSource source);
}

class ImagePickerHelperImpl implements ImagePickerHelper {
  @override
  Future<File?> pickImage(ImageSource source) => ImagePicker()
      .pickImage(source: source)
      .then((file) => file == null ? null : File(file.path));

  Future<void> _pickProfileImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: source); // or ImageSource.camera
    // Handle the pickedImage
  }
}
