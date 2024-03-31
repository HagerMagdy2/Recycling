import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationRemoteDs {
  ///sign up a user with email and password
  ///
  ///throw a[FirebaseAuthException] if the process fails
  Future<void> signUp(String email, String password);
  Future<void> sendVerificationEmail();

  ///sign in a user with email and password
  ///
  ///throw a[FirebaseAuthException] if the process fails
  Future<void> signIn(String email, String password);

 
  ///sign In As A Guest
  Future<void> signInAnon();

  ///sign In As with google
  Future signInWithGoogle();
 main

  ///sign out if user signed in
  Future<void> signOut();

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
  Future<void> signUp(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
