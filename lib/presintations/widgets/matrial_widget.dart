
import 'package:flutter/material.dart';

class Matrial extends StatefulWidget {
  const Matrial({super.key, required this.title, required this.icon});
  final String title;
  final Widget icon;
  @override
  State<Matrial> createState() => _MatrialState();
}

class _MatrialState extends State<Matrial> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [widget.icon, Text(widget.title)],
        ));
  }
}
