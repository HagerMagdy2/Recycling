import 'package:firstly/constants.dart';
import 'package:firstly/presintations/widgets/drawer.dart';
import 'package:firstly/presintations/widgets/item.dart';
import 'package:firstly/presintations/widgets/matrial_widget.dart';
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
        foregroundColor: kMainColor,
        backgroundColor: Colors.white,
        title: const Text('Be Green',style: TextStyle(fontWeight: FontWeight.bold,color: kMainColor),textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(

  child: Column(
  children: [
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Column(
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: CircleAvatar(backgroundColor: Colors.white,radius: 55,)),
          )),
          SizedBox(height: 20,),
          Text("Name")
        ],
      ),
  height: 200,

decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),  color: kMainColor,),
    ),
  ),
  
    
    Column(
  //  mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("       Materials",textAlign: TextAlign.start,
        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Gray) ,),
        Row(
          children: [Container(
            height: 150,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [Matrial(title: "Glasses", icon: Icons.wine_bar_outlined,),
                Matrial(title: "Plastic", icon: Icons.water),
                Matrial(title: "Compost", icon: Icons.food_bank_outlined),
                Matrial(title: "Papers", icon: Icons.file_copy_outlined),
                Matrial(title: "Oils", icon: Icons.oil_barrel_outlined),]),
            ),
          )],
        ),
      ],
    ),
    Container(height: 350,width: 400,child: ListView(
    children: [  ItemsGrideTail(),  ItemsGrideTail(),  ItemsGrideTail(),  ItemsGrideTail(),  ItemsGrideTail(),  ItemsGrideTail()],
    ))
  ],
  ),


      ),
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
