import 'dart:io';

import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';

import 'package:firstly/presintations/bloc/papers_bloc.dart';
import 'package:firstly/presintations/bloc/papers_event.dart';
import 'package:firstly/presintations/bloc/papers_state.dart';
import 'package:firstly/presintations/screens/category/papers-page.dart';

import 'package:firstly/presintations/widgets/add_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPapersPage extends StatefulWidget {
  const AddPapersPage({Key? key}) : super(key: key);

  @override
  State<AddPapersPage> createState() => _AddPapersPageState();
}

class _AddPapersPageState extends State<AddPapersPage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController idC = TextEditingController();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title:  Text(
          'Add New Product',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: BlocBuilder<PapersBloc, PapersState>(
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
                            builder: (context) => PapersCategoryPage(),
                          ),
                        );
                        final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                        var currentUser = firebaseAuth.currentUser;
                        context.read<PapersBloc>().add(
                              AddPapers(
                                product: Product(
                                  image: imageURL ?? '',
                                  name: nameC.text,
                                  id: idC.text,
                                  price: num.parse(priceC.text),
                                  quantity: num.parse(quantityC.text),
                                  availableQuantity: num.parse(quantityC.text),
                                  userId: currentUser!.uid,
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