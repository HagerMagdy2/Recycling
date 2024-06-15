import 'dart:ui';
import 'package:flutter/material.dart';

const kMainColor = Color(0xFF259E73);
const kSecondaryColor = Color.fromARGB(255, 227, 237, 234);
const kMainColor1 = Color.fromARGB(255, 28, 121, 88);
const Gray = Color.fromARGB(255, 82, 81, 81);

const kMainColorGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF259E73),
    Color(0xFF1B805C),
    Color(0xFF106944),
    Color.fromARGB(199, 11, 88, 57),
  ],
);

final kMainColor1Gradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 28, 121, 88).withOpacity(0.8),
    Color.fromARGB(255, 21, 102, 74).withOpacity(0.8),
    Color.fromARGB(255, 13, 82, 59).withOpacity(0.8),
    Color.fromARGB(255, 5, 61, 44).withOpacity(0.8),
  ],
);
