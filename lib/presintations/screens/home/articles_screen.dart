import 'package:firstly/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatelessWidget {
  final String articleUrl;
  final String title;

  ArticleScreen({required this.articleUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kSecondaryColor,
        backgroundColor: kMainColor,
        title: Text(title,style: TextStyle(color: kSecondaryColor,fontSize: 20),),
      ),
       body: WebView(
        initialUrl: articleUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
