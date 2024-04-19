import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firstly/constants.dart';

class AddProfilePhoto extends StatefulWidget {
  const AddProfilePhoto({Key? key}) : super(key: key);

  @override
  State<AddProfilePhoto> createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  File? file;
  bool isLoading = false;
  String? profilePhotoUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  _pickImage(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: kMainColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Pick from gallery",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  _pickImage(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: kMainColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Take photo",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
        ),
        isLoading
            ? Positioned.fill(
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                  color: Colors.white.withOpacity(0.8),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      isLoading = true;
    });

    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      file = File(pickedFile.path);
      String? imageUrl =
          await StorageHelperImpl().uploadProfileImageFromFile(file!);
      String userId = StorageHelperImpl().getCurrentUserId();
      StorageHelperImpl().saveProfilePhotoUrl(userId, imageUrl!);
    }

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context);
  }
}
