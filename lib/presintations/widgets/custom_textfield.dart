import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  final IconData icon;
  final bool showPasswordToggle;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.hint,
    this.controller,
    this.showPasswordToggle = false, // default is no toggle
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  String? _errorMessage(String str) {
    switch (str) {
      case 'Enter your name':
        return 'Name is empty!';
      case 'Enter your email':
        return 'Invalid Email';
      case 'Enter your password':
        return 'Password is empty or too short!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value!.isEmpty) {
            return _errorMessage(widget.hint);
          }
          if (widget.hint == 'Enter your email') {
            if (!value.contains('@') ||
                value.startsWith('@') ||
                !value.endsWith('.com') ||
                value.length < 5) {
              return 'Invalid Email';
            }
          } else if (widget.hint == 'Enter your password' && (value.length < 6)) {
            return 'Invalid Password';
          }
          return null;
        },
        cursorColor: kMainColor,
        obscureText: widget.hint == 'Enter your password' && _obscureText, // Hide password text conditionally
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: kMainColor,
          ),
          hintText: widget.hint,
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
          suffixIcon: widget.showPasswordToggle
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: kMainColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}