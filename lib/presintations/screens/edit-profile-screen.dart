import 'package:flutter/material.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/presintations/screens/change-pass.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;

  const EditProfileScreen({
    Key? key,
    required this.currentName,
    required this.currentEmail,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            OutlinedButton(
              onPressed: () {
                // Navigate to the change password screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(),
                  ),
                );
              },
              child: Text('Change Password'),
              style: OutlinedButton.styleFrom(
                primary: kMainColor,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                side: BorderSide(color: kMainColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Pass back the updated data to the previous screen
                Navigator.pop(context, {
                  'name': _nameController.text.trim(),
                  'email': _emailController.text.trim(),
                });
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
          ],
        ),
      ),
    );
  }
}
