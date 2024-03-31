import 'dart:io';

import 'package:firstly/constants.dart';
import 'package:firstly/presintations/widgets/add_photo.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () async {
                      await showDialog(
                              context: context,
                              builder: (context) => AddPhoto())
                          .then((value) => file = value);
                      setState(() {});
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          file == null ? "Add photo" : "",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55),
                          color: const Color.fromARGB(128, 158, 158, 158),
                          image: file != null
                              ? DecorationImage(
                                  image: FileImage(file!),
                                  fit: BoxFit.cover,
                                )
                              : null),
                    ))),
          ),
          SizedBox(
            height: 20,
          ),
          Text("name")
        ]),
      ),
    );
  }
}
