import 'package:flutter/material.dart';
import 'package:firstly/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  bool _isIncorrectPassword = false;
  String? pass;
  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorText: _isIncorrectPassword ? 'Incorrect password' : null,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Validate and update the password
                  _changePassword();
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  primary: kMainColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() async {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Add validation logic here
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Check if new passwords match
    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Reauthenticate the user with the old password
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: oldPassword);
        await user.reauthenticateWithCredential(credential);

        // Update the password
        await user.updatePassword(newPassword);

        // Password updated successfully, navigate back
        Navigator.pop(context);
      } else {
        // User is not authenticated, handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not authenticated')),
        );
      }
    } catch (e) {
      print("eeeeeeeeee$e");
      print("pppp$e");
      print("pppp$newPassword");

      // Error occurred during password update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update password: $e')),
      );
    }
  }
}