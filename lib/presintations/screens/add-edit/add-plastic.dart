import 'dart:io';

import 'package:firstly/constants.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/bloc/plastic_bloc.dart';
import 'package:firstly/presintations/bloc/plastic_event.dart';
import 'package:firstly/presintations/bloc/plastic_state.dart';
import 'package:firstly/presintations/screens/category/plastic-page.dart';
import 'package:firstly/presintations/widgets/add_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddPlasticPage extends StatefulWidget {
  const AddPlasticPage({Key? key}) : super(key: key);

  @override
  State<AddPlasticPage> createState() => _AddPlasticPageState();
}

class _AddPlasticPageState extends State<AddPlasticPage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController idC = TextEditingController();
  String? imageURL;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          'Add New Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<PlasticBloc, PlasticState>(
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
                        context: context,
                        builder: (context) => AddPhoto(),
                      );
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
                    controller: idC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product ID';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Product ID',
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
                            builder: (context) => PlasticCategoryPage(),
                          ),
                        );

                        context.read<PlasticBloc>().add(
                              AddPlastic(
                                product: Product(
                                  image: imageURL ?? '',
                                  name: nameC.text,
                                  id: idC.text,
                                  price: num.parse(priceC.text),
                                  quantity: 1,
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
