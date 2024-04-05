import 'package:firstly/presintations/widgets/add_profile-photo.dart';
import 'package:flutter/material.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firstly/constants.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userId = StorageHelperImpl().getCurrentUserId();
  String? profilePhotoUrl;
  String? userName;
  String? userEmail; // Variable to hold the user's name

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
  } // Load profile data including the user's name

  Future<void> loadProfilePhotoUrl() async {
    profilePhotoUrl = await StorageHelperImpl().getProfilePhotoUrl(userId);
    setState(() {});
  }

  Future<void> loadProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName;
        userEmail = user.email; // Set the userName variable
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: profilePhotoUrl == null
                            ? kMainColor // Set background color only when profile photo is not available
                            : kMainColor,
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
                      //if (profilePhotoUrl == null) CircularProgressIndicator(),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () async {
                      // Display the add photo dialog
                      await showDialog(
                        context: context,
                        builder: (context) => AddProfilePhoto(),
                      );
                      // Reload profile data after adding photo
                      loadProfileData();
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
            SizedBox(height: 20),
            Text(
              userName ??
                  'User Name', // Display user's name if available, otherwise display a default value
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              userEmail ?? 'User Email', // Replace with actual user email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Add functionality for sign out
            //   },
            //   child: Text('Sign Out'),
            // ),
          ],
        ),
      ),
    );
  }
}
