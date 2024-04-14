import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageHelper {
  Future<String?> uploadImageFromFile(File file);
  Future<String?> uploadProfileImageFromFile(File file);
  void saveProfilePhotoUrl(String userId, String photoUrl);
  Future<String> getProfilePhotoUrl(String userId);
  String getCurrentUserId();
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

  @override
  Future<String?> uploadProfileImageFromFile(File file) async {
    String? image;
    final storageRef = FirebaseStorage.instance.ref();
    final uploadTask = storageRef
        .child("ProfilesImages/${file.path.split("/").last}")
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

  @override
  void saveProfilePhotoUrl(String userId, String photoUrl) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'photoUrl': photoUrl})
        .then((value) => print("Profile photo URL Saved"))
        .catchError(
            (error) => print("Failed to update profile photo URL: $error"));
  }

  @override
  Future<String> getProfilePhotoUrl(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return snapshot['photoUrl'];
  }

  @override
  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      // Handle the case where user is not logged in
      return '';
    }
  }

  // Create a StreamController to emit events when the profile photo is updated
  StreamController<String> _profilePhotoStreamController =
      StreamController<String>.broadcast();

  // Getter method to access the stream
  Stream<String> get profilePhotoStream => _profilePhotoStreamController.stream;

  // Method to update the profile photo URL
  Future<void> updateProfilePhotoUrl(String newUrl) async {
    // Update the profile photo URL in storage
    // ...

    // Emit an event with the new URL
    _profilePhotoStreamController.add(newUrl);
  }

  // Dispose the StreamController when no longer needed
  void dispose() {
    _profilePhotoStreamController.close();
  }
}
