import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/presintations/screens/home/video_screen.dart';
import 'package:flutter/material.dart';

import 'articles_screen.dart';

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              tr('Videos'),
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: kMainColor),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('videos').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var videos = snapshot.data?.docs;

                  return ListView.builder(
                    itemCount: videos?.length,
                    itemBuilder: (context, index) {
                      var video = videos?[index];
                      return _buildVideoCard(
                        video?['title'],
                        'assets/images/vv1.jpeg',
                        context,
                        video?['video'],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 15), // Spacer between videos and articles
            Text(
              tr('Articles'),
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: kMainColor),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Articles')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var article = snapshot.data?.docs[index];
                      return _buildArticleCard(
                        article?['title'],
                        'assets/images/6.webp',
                        context,
                        article?['article'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(
      String title, String image, BuildContext context, String video) {
    return Card(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Image.asset(
          image,
          width: 90,
          height: 100,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: kMainColor1,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoScreen(
                        title: title,
                        videoUrl: video,
                      )));
        },
      ),
    );
  }

  Widget _buildArticleCard(
      String title, String image, BuildContext context, String article) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Image.asset(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: kMainColor1,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleScreen(
                          title: title,
                          articleUrl: article,
                        )));
          },
        ),
      ),
    );
  }
}
