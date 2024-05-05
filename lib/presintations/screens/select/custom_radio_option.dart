import 'package:flutter/material.dart';

class CustomRadioOption {
  static String id = 'CustomRadioOption';
  final String label;
  final String imagePath;
  final int value;

  CustomRadioOption({required this.label, required this.imagePath, required this.value});
}

class MyRadioButtons extends StatefulWidget {
  @override
  _MyRadioButtonsState createState() => _MyRadioButtonsState();
}

class _MyRadioButtonsState extends State<MyRadioButtons> {
  int _selectedValue = 0;

  final List<CustomRadioOption> options = [
    CustomRadioOption(label: 'Option 1', imagePath: 'assets/option1.png', value: 1),
    CustomRadioOption(label: 'Option 2', imagePath: 'assets/option2.png', value: 2),
    // Add more options as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return RadioListTile<int>(
          title: Text(option.label),
          value: option.value,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value!;
            });
          },
          secondary: Image.asset(option.imagePath),
        );
      }).toList(),
    );
  }
}
