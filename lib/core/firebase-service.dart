import 'package:firebase_auth/firebase_auth.dart';

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
}
