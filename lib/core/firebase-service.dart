import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class FirebaseService {
  static Future<String?> verifyPhoneNumber(String phoneNumber) async {
    try {
      final PhoneVerificationCompleted verificationCompleted =
          (PhoneAuthCredential credential) async {
        // This callback will be invoked if the automatic verification is successful.
        // You can handle it based on your application flow.
      };

      final PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException e) {
        // This callback will be invoked if the verification failed.
        // You can handle it based on your application flow.
        print('Phone verification failed: ${e.message}');
      };

      final PhoneCodeSent codeSent =
          (String verificationId, int? resendToken) async {
        // This callback will be invoked when the verification code is sent to the provided phone number.
        // You can save the verification ID and prompt the user to enter the code.
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        // This callback will be invoked when the code auto-retrieval timeout has passed.
        // You can handle it based on your application flow.
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );

      // Return null as verificationId is not returned directly from verifyPhoneNumber
      return null;
    } catch (e) {
      print("Failed to verify phone number: $e");
      throw e;
    }
  }

  static Future<String?> getUserPhoneNumber(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final encryptedPhoneNumber = snapshot['phoneNumber'];
      if (encryptedPhoneNumber != null) {
        return EncryptionService.decryptPhoneNumber(encryptedPhoneNumber);
      }
      return null;
    } catch (e) {
      print("Failed to get user phone number: $e");
      throw e;
    }
  }

  static Future<void> saveUserPhoneNumber(
      String userId, String phoneNumber) async {
    try {
      final encryptedPhoneNumber =
          EncryptionService.encryptPhoneNumber(phoneNumber);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'phoneNumber': encryptedPhoneNumber});
    } catch (e) {
      print("Failed to save user phone number: $e");
      throw e;
    }
  }

  static Future<void> updateProfileData(
      String userId, String newName, String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(newName);
        await user.updateEmail(newEmail);
      }
    } catch (e) {
      print("Failed to update profile: $e");
      throw e;
    }
  }
}

class EncryptionService {
  static final key = encrypt.Key.fromLength(32); // 32 bytes key for AES-256
  static final iv = encrypt.IV.fromLength(16); // 16 bytes IV for AES-256-CBC
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static String encryptPhoneNumber(String phoneNumber) {
    final encrypted = encrypter.encrypt(phoneNumber, iv: iv);
    return encrypted.base64;
  }

  static String decryptPhoneNumber(String encryptedPhoneNumber) {
    final encrypted = encrypt.Encrypted.fromBase64(encryptedPhoneNumber);
    return encrypter.decrypt(encrypted, iv: iv);

}
}