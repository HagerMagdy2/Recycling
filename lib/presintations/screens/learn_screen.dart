import 'package:flutter/material.dart';


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
              child: ListView(
                children: <Widget>[
                  _buildVideoCard('إعادة التدوير', 'assets/images/v1.png',),
                  SizedBox(
                    height: 10,
                  ),
                  _buildVideoCard('إعادة تدوير الإكسسوارات القديمة',
                      'assets/images/v2.png'),
                  SizedBox(
                    height: 10,
                  ),
                  _buildVideoCard('إعادة تدوير النفايات في المنزل',
                      'assets/images/v3.png'),
                ],
              ),
            ),
            SizedBox(height: 20), // Spacer between videos and articles
            Text(
              'articles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildArticleCard(
                      'إعادة التدوير',
                      'assets/images/a1.jpg',),
                      SizedBox(
                    height: 10,
                  ),
                  _buildArticleCard(
                      'إعادة تدوير الورق', 'assets/images/a2.jpg'),  SizedBox(
                    height: 10,
                  ),
                  _buildArticleCard(
                      'إعادة تدوير الزيت ',
                      'assets/images/a3.jpeg',),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(
      String title, String image) {
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
        },
      ),
    );
  }

  Widget _buildArticleCard(
      String title, String image) {
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
        },
      ),
    );
  }
}
