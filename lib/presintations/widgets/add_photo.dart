import 'dart:io';

import 'package:firstly/constants.dart';
import 'package:firstly/core/image_picker_helper.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                file = await ImagePickerHelperImpl()
                    .pickImage(ImageSource.gallery);
                String? imageUrl =
                    await StorageHelperImpl().uploadImageFromFile(file!);
                Navigator.pop(context, file);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.photo,
                    color: kMainColor,
                  ),
                  Text(
                    "pick frome gallary",
                    style: TextStyle(
                        fontFamily: "", fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async {
                file =
                    await ImagePickerHelperImpl().pickImage(ImageSource.camera);
                String? imageUrl =
                    await StorageHelperImpl().uploadImageFromFile(file!);
                print(imageUrl);

                Navigator.pop(context, file);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: kMainColor,
                  ),
                  Text(
                    "Take photo ",
                    style: TextStyle(
                        fontFamily: "", fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<File?> getImage(ImageSource imageSource) async {
  XFile? xFile = await ImagePicker().pickImage(source: imageSource);
  if (xFile != null) {
    return File(xFile.path);
  }
 return null;
}