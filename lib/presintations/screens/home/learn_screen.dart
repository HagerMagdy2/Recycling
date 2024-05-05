import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstly/presintations/screens/home/video_screen.dart';
import 'package:flutter/material.dart';

import 'articles_screen.dart';

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Education'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Videos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('videos').snapshots(),
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
                      'assets/images/v1.png',
                      context,
                        video?['video'],

                    );
                  },
                );
              },
            ),
          ),
            // Expanded(
            //   child: ListView(
            //     children: <Widget>[
            //       _buildVideoCard('إعادة التدوير', 'assets/images/v1.png',
            //           context, 'videos/video1.mp4'),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       _buildVideoCard('إعادة تدوير الإكسسوارات القديمة',
            //           'assets/images/v2.png', context, 'videos/video2.mp4'),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       _buildVideoCard('إعادة تدوير النفايات في المنزل',
            //           'assets/images/v3.png', context, 'videos/video3.mp4'),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20), // Spacer between videos and articles
            Text(
              'articles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Articles').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var article = snapshot.data?.docs[index];
                  return _buildArticleCard(
                    article?['title'],
                    'assets/images/a1.jpg',
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
      child: ListTile(
        leading: Image.asset(
          image,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: TextStyle(
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
          // Handle video tap
        },
      ),
    );
  }

  Widget _buildArticleCard(
      String title, String image, BuildContext context, String article) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ListTile(
          leading: Image.asset(
            image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          title: Text(
            title,
            style: TextStyle(
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
                      article: article,
                    )));
            // Handle video tap
          },
        ),
      ),
    );
  }
}
