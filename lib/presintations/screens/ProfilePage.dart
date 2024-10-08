// import 'dart:async';
//
// import 'package:firstly/presintations/User/user.dart';
// // import 'package:firstly/presintations/screens/edit_birthday.dart';
// import 'package:flutter/material.dart';
//
// import '../../constants.dart';
// import '../User/user_data.dart';
// import '../widgets/display_image_widget.dart';
// import 'edit_description.dart';
// import 'edit_email.dart';
// import 'edit_image.dart';
// import 'edit_name.dart';
// import 'edit_phone.dart';
//
// class ProfilePage extends StatefulWidget {
//   static String id = 'ProfilePage';
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   var user = UserData.myUser;
//   @override
//   Widget build(BuildContext context) {
//     //final user = UserData.myUser;
//
//     return Scaffold(
//       body: Column(
//         children: [
//           AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             toolbarHeight: 10,
//           ),
//           Center(
//               child: Padding(
//                   padding: EdgeInsets.only(bottom: 20),
//                   child: Text(
//                     'My Profile',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w700,
//                       color: kMainColor1,
//                     ),
//                   ))),
//           InkWell(
//               onTap: () {
//                 navigateSecondPage(EditImagePage());
//               },
//               child: DisplayImage(
//                 imagePath: user.image,
//                 onPressed: () {},
//               )),
//           buildUserInfoDisplay(user.name, 'Name', EditNameFormPage()),
//           buildUserInfoDisplay(user.phone, 'Phone', EditPhoneFormPage()),
//           buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
//           Expanded(
//             child: buildAbout(user),
//             flex: 4,
//           )
//         ],
//       ),
//     );
//   }
//
//   // Widget builds the display item with the proper formatting to display the user's info
//   Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
//       Padding(
//           padding: EdgeInsets.only(bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey,
//                 ),
//               ),
//               SizedBox(
//                 height: 1,
//               ),
//               Container(
//                   width: 350,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(
//                     color: Colors.grey,
//                     width: 1,
//                   ))),
//                   child: Row(children: [
//                     Expanded(
//                         child: TextButton(
//                             onPressed: () {
//                               navigateSecondPage(editPage);
//                             },
//                             child: Text(
//                               getValue,
//                               style: TextStyle(fontSize: 16, height: 1.4),
//                             ))),
//                     IconButton(
//                       onPressed: () {
//                         navigateSecondPage(editPage);
//                       },
//                       icon: Icon(
//                         Icons.edit,
//                         color: Colors.grey,
//                       ),
//                       iconSize: 20,
//                     )
//                   ]))
//             ],
//           ));
//
//   // Widget builds the About Me Section
//   Widget buildAbout(User user) => Padding(
//       padding: EdgeInsets.only(bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Tell Us About Yourself',
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 1),
//           Container(
//               width: 350,
//               height: 100,
//               decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(
//                 color: Colors.grey,
//                 width: 1,
//               ))),
//               child: Row(children: [
//                 Expanded(
//                     child: TextButton(
//                         onPressed: () {
//                           navigateSecondPage(EditDescriptionFormPage());
//                         },
//                         child: Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
//                             child: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   user.aboutMeDescription,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     height: 1.4,
//                                   ),
//                                 ))))),
//                 IconButton(
//                   onPressed: () {
//                     navigateSecondPage(EditDescriptionFormPage());
//                   },
//                   icon: Icon(
//                     Icons.edit,
//                     color: Colors.grey,
//                   ),
//                   iconSize: 20,
//                 )
//               ]))
//         ],
//       ));
//
//   // Refrshes the Page after updating user info.
//   FutureOr onGoBack(dynamic value) {
//     setState(() {});
//   }
//
//   // Handles navigation and prompts refresh.
//   void navigateSecondPage(Widget editForm) {
//     Route route = MaterialPageRoute(builder: (context) => editForm);
//     Navigator.push(context, route).then(onGoBack);
//   }
// }
