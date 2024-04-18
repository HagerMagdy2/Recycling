import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/presintations/screens/glasses_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController imageC = TextEditingController();
  TextEditingController idC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: kMainColor,
          title: Text(
            ('Add new Product'),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: key,
                child: ListView(
                  children: [
                    if (state is ProductInitial)
                      SizedBox(
                        height: 50,
                      ),
                    TextFormField(
                      controller: nameC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return ('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: ('name'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: priceC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return ('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: ('price'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: imageC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return ('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: ('image'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: idC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return ('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: ('id'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kMainColor)),
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GlassesCategoryPage()));
                            context.read<ProductBloc>().add(AddProduct(
                                product: Product(
                                    image: imageC.text,
                                    name: nameC.text,
                                    id: idC.text,
                                    price: num.parse(priceC.text),
                                    quantity: 1)));
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              ('Add Product'),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
