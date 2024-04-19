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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          'Add New Product',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                      await showDialog(
                        context: context,
                        builder: (context) => AddPhoto(),
                      ).then((value) {
                        setState(() {
                          imagePath = value?.path;
                        });
                      });
                    },
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                          image: imagePath != null
                              ? DecorationImage(
                                  image: FileImage(File(imagePath!)),
                                  fit: BoxFit.cover,
                                )
                              : null),
                      child: imagePath == null
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
                            builder: (context) => PapersCategoryPage(),
                          ),
                        );

                        context.read<PapersBloc>().add(
                              AddPapers(
                                product: Product(
                                  image: imagePath ?? '',
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
