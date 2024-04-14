import 'package:flutter/material.dart';

import '../../constants.dart';
import '../User/user_data.dart';
import '../widgets/appbar_widget.dart';

class EditDescriptionFormPage extends StatefulWidget {
  @override
  _EditDescriptionFormPageState createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void updateUserValue(String description) {
    user.aboutMeDescription = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // Use SingleChildScrollView to prevent overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.9, // 90% of screen width
                  child: const Text(
                    "What type of passenger\nare you?",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                    height: 250, // Consider making this responsive if needed
                    width: MediaQuery.of(context).size.width *
                        0.9, // 90% of screen width
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length > 200) {
                          return 'Please describe yourself but keep it under 200 characters.';
                        }
                        return null;
                      },
                      controller: descriptionController,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 100),
                        hintMaxLines: 3,
                        hintText:
                            'Write a little bit about yourself. Do you like Recycling?',
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.9, // 90% of screen width
                    height: 50, // Fixed height for buttons is usually okay
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updateUserValue(descriptionController.text);
                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kMainColor1),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
