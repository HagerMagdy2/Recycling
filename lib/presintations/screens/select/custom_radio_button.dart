import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  static String id = 'CustomRadioButton';
  final String label;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  CustomRadioButton({
    required this.label,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(imagePath, width: 50, height: 50),
          Text(label),
          SizedBox(height: 8),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.blue : Colors.transparent,
              border: Border.all(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
