import 'package:firstly/constants.dart';
import 'package:firstly/presintations/widgets/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: const Text('start'),
      ),
      body: const Center(),
    );
  }
}
