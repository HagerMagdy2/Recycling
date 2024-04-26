import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  final String article;
  final String title;

  ArticleScreen({required this.article,required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl, // Right-to-left text direction for Arabic
            child: Text(
              article,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
