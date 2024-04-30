import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationRemoteDs {
  ///sign up a user with email and password
  ///
  ///throw a[FirebaseAuthException] if the process fails
  Future<void> signUp(String email, String password, String name);

  ///sign in a user with email and password
  ///
  ///throw a[FirebaseAuthException] if the process fails
  Future<void> signIn(String email, String password);

  ///sign In As A Guest
  Future<void> signInAnon();

  ///sign In As with google
  Future signInWithGoogle();

  ///sign In As with facebook
  Future signInWithFacebook();

  ///sign out if user signed in
  Future<void> signOut();
  Future<void> sendVerificationEmail();

  ///check if the user is signUp or signIn
  bool isSignedIn();
}

class AuthenticationRemoteDsImp extends AuthenticationRemoteDs {
  @override
  bool isSignedIn() => FirebaseAuth.instance.currentUser != null;

  @override
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      // Handle any errors that occur during sign-up
      print('Error signing up with facebook: $e');
      // You may want to throw the error or handle it in a different way
      throw e;
    }
  }

  @override
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  @override
  Future<void> signUp(String email, String password, String name) async {
    try {
      // Create the user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Once the user is created, update their display name
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateDisplayName(name);

        // Add user data to Firestore userinfo collection
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,

          // Add any additional user data fields here
        });
      } else {
        // Handle the case where user is null (should not happen)
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User not found after sign-up.',
        );
      }

      // Optionally, you can also update additional user data in Firestore here
    } catch (e) {
      // Handle any errors that occur during sign-up
      print('Error signing up: $e');
      // You may want to throw the error or handle it in a different way
      throw e;
    }
  }

  @override
  Future<void> sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<void> signInAnon() {
    // TODO: implement signInAnon
    throw UnimplementedError();
  }
}
