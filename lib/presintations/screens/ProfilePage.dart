import 'package:flutter/material.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/core/firebase-service.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/presintations/screens/add-edit/edit-profile-screen.dart';
import 'package:firstly/presintations/widgets/add_profile-photo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String id = 'ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userId;
  String? profilePhotoUrl;
  String? userName;
  String? userEmail;
  String? userPhone;
  bool _isSavingPhoneNumber = false;

  @override
  void initState() {
    super.initState();
    userId = StorageHelperImpl().getCurrentUserId();
    loadProfileData();
    loadProfilePhotoUrl();
    loadPhoneNumber(); // Call loadPhoneNumber here
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
      // Load phone number after loading profile data
      await loadPhoneNumber();
    }
  }

  Future<void> loadPhoneNumber() async {
    userPhone = await FirebaseService.getUserPhoneNumber(userId);
    setState(() {});
  }

  Future<void> updateProfileData(
      String newName, String newEmail, String newPhone) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateDisplayName(newName);
        await user.updateEmail(newEmail);
        await FirebaseService.saveUserPhoneNumber(userId, newPhone);
        setState(() {
          userName = newName;
          userEmail = newEmail;
          userPhone = newPhone; // Update local state with the new phone number
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
      String? verificationId =
          await FirebaseService.verifyPhoneNumber(phoneNumber);
      if (verificationId != null) {
        await FirebaseService.saveUserPhoneNumber(phoneNumber, verificationId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone number saved successfully')),
        );
        print('Current user phone number: $userPhone');

        await loadPhoneNumber(); // Reload phone number after saving
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send verification code')),
        );
      }
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AddProfilePhoto(),
                );
                await loadProfileData();
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
                        await showDialog(
                          context: context,
                          builder: (context) => AddProfilePhoto(),
                        );
                        await loadProfileData();
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
            SizedBox(height: 10),
            Text(
              userPhone ?? 'User Phone Number',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      currentName: userName ?? '',
                      currentEmail: userEmail ?? '',
                      currentPhone: userPhone ?? '',
                    ),
                  ),
                );

                if (result != null && result is Map<String, String>) {
                  await updateProfileData(
                    result['name']!,
                    result['email']!,
                    result['phone']!,
                  );
                }
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                //primary: kMainColor,
                backgroundColor: kMainColor,
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
