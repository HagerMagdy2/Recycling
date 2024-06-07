import 'package:firstly/presintations/screens/add-edit/add_oils.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/presintations/screens/add-edit/add-compost.dart';
import 'package:firstly/presintations/screens/add-edit/add-papers.dart';
import 'package:firstly/presintations/screens/add-edit/add-plastic.dart';
import 'package:firstly/presintations/screens/add-edit/add_glasses.dart';

import 'package:firstly/presintations/screens/home/cart-page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AddFromHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        foregroundColor: Colors.white,
        title: Text(
          'Be Green',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            child: Icon(
              Icons.shopping_cart,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Which category do you want to add?',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 23.9,
                  color: kMainColor1,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: 5, // Number of items
              itemBuilder: (BuildContext context, int index) {
                return FadeInUp(
                  duration: Duration(
                      milliseconds:
                          500 * (index + 1)), // Increasing delay for each item
                  child: _buildMaterialItem(context, index),
                );
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialItem(BuildContext context, int index) {
    List<Map<String, dynamic>> items = [
      {
        'title': "Glasses",
        'image': "assets/images/icons-glasses.png",
        'destination': AddGlassesPage(),
      },
      {
        'title': "Plastic",
        'image': "assets/images/icons-plastics.png",
        'destination': AddPlasticPage(),
      },
      {
        'title': "Compost",
        'image': "assets/images/icons-carrots.png",
        'destination': AddCompostPage(),
      },
      {
        'title': "Papers",
        'image': "assets/images/icons-paper.png",
        'destination': AddPapersPage(),
      },
      {
        'title': "Oils",
        'image': "assets/images/icons-oils.png",
        'destination': AddOilsPage()
      },
    ];

    final item = items[index];

    return SizedBox(
      width: double.infinity,
      height: 180, // Set the desired height here
      child: GestureDetector(
        onTap: () {
          if (item['destination'] != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item['destination']),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                item['image'],
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                item['title'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
