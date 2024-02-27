import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final IconData icon;

  const CustomTextField(
      {super.key, required this.icon, required this.hint, this.controller});

  String? _errorMessage(String str) {
    switch (hint) {
      case 'Enter your name':
        return 'Name is empty!';
      case 'Enter your email':
        return 'Invalid Email';
      case 'Enter your password':
        return 'Password is empty or too short!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return _errorMessage(hint);
          }
          if (hint == 'Enter your email') {
            if (!value.contains('@') ||
                value.startsWith('@') ||
                !value.endsWith('.com') ||
                value.length < 5) {
              return 'Invalid Email';
            }
          } else if (hint == 'Enter your password' && (value.length < 6)) {
            return 'Invalid Password';
          }
          return null;
        },
        cursorColor: kMainColor,
        obscureText: hint == 'Enter your password', // Hide password text
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          hintText: hint,
          filled: true,
          fillColor: kSecondaryColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
