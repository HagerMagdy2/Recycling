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
      drawer:AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Be Green',style: TextStyle(fontWeight: FontWeight.bold,color: kMainColor),textAlign: TextAlign.center,),
      ),
      body: const Center(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        backgroundColor: kMainColor,
        elevation: 10,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50.0,
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(padding: const EdgeInsets.only(left: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home,color: Colors.grey,),
                Text('Home',style: TextStyle(color: Colors.grey))

              ],
            ),
            ),
            Padding(padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite,color: Colors.grey,),
                Text('Favorite',style: TextStyle(color: Colors.grey))

              ],
            ),
            ),
            Padding(padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lightbulb,color: Colors.grey,),
                Text('Learn',style: TextStyle(color: Colors.grey))

              ],
            ),
            ),
            Padding(padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person,color: Colors.grey,),
                Text('Profile',style: TextStyle(color: Colors.grey))

              ],
            ),
            ),
          ]
          ),
      ),
    );
  }
}
