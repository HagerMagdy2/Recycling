import 'package:easy_localization/easy_localization.dart';
import 'package:firstly/constants.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: kMainColor,
          title: Text(tr('About Us'), style: TextStyle(color: Colors.white)),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to left
              children: <Widget>[
                SizedBox(height: 10), // Add some space below the app bar
                AboutUsUIItem(
                  title: 'Phone',
                  details: '01119257229',
                ),
                AboutUsUIItem(
                  title: 'Developers',
                  details: 'Mai Atef & Arwa Ayman & Hagar Magdy ',
                ),
                AboutUsUIItem(
                  title: 'Facebook',
                  details: 'LINK',
                ),
                AboutUsUIItem(
                  title: 'Version',
                  details: '1.0.0',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutUsUIItem extends StatelessWidget {
  final String title;
  final String details;

  const AboutUsUIItem({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align to left
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: kMainColor1,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          details,
          style: TextStyle(color: Colors.grey),
        ),
        Divider()
      ],
    );
  }
}