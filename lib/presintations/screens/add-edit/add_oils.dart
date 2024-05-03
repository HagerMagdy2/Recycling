import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/core/firebase-service.dart';
import 'package:firstly/data/models/product.dart';

import 'package:firstly/presintations/bloc/oils_bloc.dart';
import 'package:firstly/presintations/bloc/oils_event.dart';
import 'package:firstly/presintations/bloc/oils_state.dart';
import 'package:firstly/presintations/screens/category/oils_page.dart';

import 'package:firstly/presintations/widgets/add_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOilsPage extends StatefulWidget {
  const AddOilsPage({Key? key}) : super(key: key);

  @override
  State<AddOilsPage> createState() => _AddOilsPageState();
}

class _AddOilsPageState extends State<AddOilsPage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController quantityC = TextEditingController();

  String? imageURL;
  String? userId,
      userName,
      userEmail,
      userPhone; // Add a variable to store the user ID

  @override
  void initState() {
    super.initState();
    _getUserID(); // Call function to retrieve the user ID
  }

  Future<void> _getUserID() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          userId = user.uid;
          userName = user.displayName;
          userEmail = user.email;
        });
      } else {
        print("User not found.");
      }
    } catch (e) {
      print("Error fetching user information: $e");
    }
  }

  Future<void> loadPhoneNumber() async {
    userPhone = await FirebaseService.getUserPhoneNumber(userId!);
    setState(() {});
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('product_images/$fileName.jpg');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String url = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        imageURL = url;
      });
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(
          'Add New Product',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: BlocBuilder<OilsBloc, OilsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: key,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () async {
                      File? imageFile = await showDialog(
                          context: context, builder: (context) => AddPhoto());
                      if (imageFile != null) {
                        await _uploadImage(imageFile);
                      }
                    },
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        image: imageURL != null
                            ? DecorationImage(
                                image: NetworkImage(imageURL!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: imageURL == null
                          ? Center(
                              child: Icon(
                                Icons.add_photo_alternate,
                                size: 50,
                                color: Colors.grey[600],
                              ),
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: nameC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: priceC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: quantityC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'quantity',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OilsCategoryPage(),
                          ),
                        );
                        print(userName);

                        context.read<OilsBloc>().add(
                              AddOils(
                                product: Product(
                                  image: imageURL ?? '',
                                  name: nameC.text,
                                  id: idC.text,
                                  price: num.parse(priceC.text),
                                  quantity: num.parse(quantityC.text),
                                  availableQuantity: num.parse(quantityC.text),
                                  userId: userId!,
                                  userName: userName ??
                                      '', // Ensure userName is not null
                                  userEmail: userEmail ??
                                      '', // Ensure userEmail is not null
                                  userPhone: userPhone ?? '',
                                ),
                              ),
                            );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kMainColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Add Product',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
