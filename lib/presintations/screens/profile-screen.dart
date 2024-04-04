import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/core/firebase-service.dart';
import 'package:flutter/material.dart';
import 'package:firstly/presintations/screens/edit-profile-screen.dart';
import 'package:firstly/presintations/widgets/add_profile-photo.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firstly/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userId = StorageHelperImpl().getCurrentUserId();
  String? profilePhotoUrl;
  String? userName;
  String? userEmail;
  TextEditingController _phoneController =
      TextEditingController(); // Controller for phone number input
  bool _isSavingPhoneNumber = false;

  @override
  void initState() {
    super.initState();
    loadProfileData();
    loadProfilePhotoUrl();
    StorageHelperImpl().profilePhotoStream.listen((String newUrl) {
      setState(() {
        profilePhotoUrl = newUrl;
      });
    });
  }

  Future<void> loadProfilePhotoUrl() async {
    profilePhotoUrl = await StorageHelperImpl().getProfilePhotoUrl(userId);
    setState(() {});
  }

  Future<void> loadProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName;
        userEmail = user.email;
      });
    }
  }

  Future<void> updateProfileData(String newName, String newEmail) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateDisplayName(newName);
        await user.updateEmail(newEmail);
        setState(() {
          userName = newName;
          userEmail = newEmail;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        print("Failed to update profile: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }

  Future<void> savePhoneNumber(String phoneNumber) async {
    setState(() {
      _isSavingPhoneNumber = true;
    });
    try {
      // Verify phone number and get the verification ID
      String? verificationId =
          await FirebaseService.verifyPhoneNumber(phoneNumber);
      // If you need to handle verification ID, you can use it here
      // For simplicity, I'm assuming verification ID is not needed in this scenario

      // Implement the UI for entering verification code
      // Once the verification code is entered, call FirebaseService.savePhoneNumber with the verification code
      // Example:
      // String verificationCode = ... // Get the verification code from the user input
      // await FirebaseService.savePhoneNumber(phoneNumber, verificationId!, verificationCode);
    } catch (e) {
      print("Failed to verify phone number: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to verify phone number: $e')),
      );
    } finally {
      setState(() {
        _isSavingPhoneNumber = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                // Display the add photo dialog
                await showDialog(
                  context: context,
                  builder: (context) => AddProfilePhoto(),
                );
                // Reload profile data after adding photo
                await loadProfileData(); // Wait for the profile data to be reloaded
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile photo set successfully')),
                );
              },
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: kMainColor,
                      radius: 80,
                      backgroundImage: profilePhotoUrl != null
                          ? NetworkImage(profilePhotoUrl!)
                          : null,
                      child: profilePhotoUrl == null
                          ? Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        // Display the add photo dialog
                        await showDialog(
                          context: context,
                          builder: (context) => AddProfilePhoto(),
                        );
                        // Reload profile data after adding photo
                        await loadProfileData(); // Wait for the profile data to be reloaded
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Profile photo set successfully')),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              userName ?? 'User Name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              userEmail ?? 'User Email',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSavingPhoneNumber
                  ? null
                  : () {
                      // Save the phone number when the button is pressed
                      savePhoneNumber(_phoneController.text.trim());
                    },
              child: _isSavingPhoneNumber
                  ? CircularProgressIndicator() // Show loading indicator while saving
                  : Text('Save Phone Number'),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                // Navigate to the edit profile screen and await the result
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      currentName: userName ?? '',
                      currentEmail: userEmail ?? '',
                    ),
                  ),
                );

                // Handle the result from the edit profile screen
                if (result != null && result is Map<String, String>) {
                  // Update the profile data with the new values
                  await updateProfileData(result['name']!, result['email']!);
                }
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                primary: kMainColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
