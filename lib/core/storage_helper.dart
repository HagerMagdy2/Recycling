import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageHelper {
  Future<String?> uploadImageFromFile(File file);
}

class StorageHelperImpl implements StorageHelper {
  @override
  Future<String?> uploadImageFromFile(File file) async {
    String? image;
    final storageRef = FirebaseStorage.instance.ref();
    final uploadTask = storageRef
        .child("ProductImages/${file.path.split("/").last}")
        .putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    if (taskSnapshot.state == TaskState.running) {
      print(
          "progress :${100 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes)}");
    } else if (taskSnapshot.state == TaskState.error) {
      throw Exception("failed");
    } else if (taskSnapshot.state == TaskState.success) {
      image = await taskSnapshot.ref.getDownloadURL();
    }
    print(image);
    return image;
  }
}
