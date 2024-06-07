import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/core/firebase-service.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/presintations/screens/add-edit/edit-profile-screen.dart';
import 'package:firstly/presintations/widgets/add_profile-photo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
    loadPhoneNumber();
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
          userPhone = newPhone;
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
        await loadPhoneNumber();
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
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: kMainColor,
                ),
              ),
            ),
          ),
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
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kMainColor, width: 5),
                    ),
                    child: CircleAvatar(
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
          buildUserInfoDisplay(userName ?? 'User Name', 'Name'),
          SizedBox(height: 20),
          buildUserInfoDisplay(userEmail ?? 'User Email', 'Email'),
          SizedBox(height: 20),
          buildUserInfoDisplay(userPhone ?? 'User Phone Number', 'Phone'),
          SizedBox(height: 40),
          ElevatedButton.icon(
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
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            label: Text('Edit Profile', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: kMainColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: kMainColor1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title) => Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      getValue,
                      style: TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildAbout() => Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 1),
            Container(
              width: 350,
              height: 100,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
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
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
