import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50.0,
      notchMargin: 5.0,
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  Text('Home', style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ),
                  Text('Favorite', style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: Colors.grey,
                  ),
                  Text('Learn', style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  Text('Profile', style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
          ]),
    );
  }
}
