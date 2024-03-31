import 'package:firstly/constants.dart';
import 'package:firstly/presintations/screens/add_product.dart';
import 'package:firstly/presintations/widgets/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('start'),
      ),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        onPressed: () {
          try {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProduct(),
                ));
          } catch (e) {
            print(e);
          }
        },
        tooltip: 'Add Place',
        child: const Icon(Icons.add),
      ),
    );
  }
}
