import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../widgets/setting.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);
  static String id = 'HelpScreen';
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          tr('Help'),
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  labelText: tr('What happened?'),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: 200,
                minLines: 10,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String comment = commentController.text.trim();

                  if (comment.isNotEmpty) {
                    addCommentToFirebase(context, comment);

                    commentController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a comment.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(
                  tr('Submit'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMainColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addCommentToFirebase(BuildContext context, String comment) {
    CollectionReference comments =
        FirebaseFirestore.instance.collection('help comments');

    comments.add({
      'comment': comment,
      'timestamp': DateTime.now(),
    }).then((value) {
      print("Comment added to Firestore!");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Comment submitted successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      print("Failed to add comment: $error");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit comment. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
}
