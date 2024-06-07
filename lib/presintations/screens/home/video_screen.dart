import 'package:firstly/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoScreen extends StatelessWidget {
  final String videoUrl;
  final String title;

  VideoScreen({Key? key, required this.videoUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kSecondaryColor,
        backgroundColor: kMainColor,
        title: Text(
          title,
          style: TextStyle(color: kSecondaryColor, fontSize: 20),
        ),
      ),
      body: WebView(
        initialUrl: videoUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
