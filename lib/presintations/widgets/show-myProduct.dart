import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowMYProducts extends StatefulWidget {
  const ShowMYProducts({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ShowMYProducts> createState() => _ShowMYProductsState();
}

class _ShowMYProductsState extends State<ShowMYProducts> {
  late bool isFavorite;
  late bool isInCart;

  @override
  void initState() {
    super.initState();

    isFavorite = widget.product.isFav;
    isInCart = widget.product.isInCart;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.all(7),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.product.price} EGP',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    // Check if userName is not null
                    Text(
                      'Added by: ${widget.product.userName}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    // Check if userEmail is not null
                    Text(
                      'Email: ${widget.product.userEmail}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                TextEditingController nameC =
                                    TextEditingController();
                                TextEditingController priceC =
                                    TextEditingController();
                                TextEditingController quantityC =
                                    TextEditingController();
                                bool isValid = true;

                                return AlertDialog(
                                  backgroundColor: kMainColor,
                                  title: Text(
                                    'Update Product',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: nameC,
                                        decoration: InputDecoration(
                                          labelText: 'name',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      TextField(
                                        controller: priceC,
                                        decoration: InputDecoration(
                                          labelText: 'price',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      TextField(
                                        controller: quantityC,
                                        decoration: InputDecoration(
                                          labelText: 'quantity',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Update',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (nameC.text.isEmpty ||
                                            priceC.text.isEmpty ||
                                            quantityC.text.isEmpty) {
                                          isValid = false;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'All fields must be filled out',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor: kMainColor,
                                            ),
                                          );
                                        } else {
                                          isValid = true;
                                          context.read<ProductBloc>().add(
                                                UpdateProduct(
                                                  product: Product(
                                                    id: widget.product.id,
                                                    name: nameC.text,
                                                    price:
                                                        int.parse(priceC.text),
                                                    image: widget.product.image,
                                                    userId:
                                                        widget.product.userId,
                                                    userName:
                                                        widget.product.userName,
                                                    userEmail: widget
                                                        .product.userEmail,
                                                    userPhone: widget
                                                        .product.userPhone,
                                                    quantity: int.parse(
                                                        quantityC.text),
                                                    availableQuantity: widget
                                                        .product
                                                        .availableQuantity,
                                                    category:
                                                        widget.product.category,
                                                  ),
                                                ),
                                              );
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.edit,
                          ),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: kMainColor,
                                  title: Text(
                                    'Delete Product',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    'Are you sure you want to delete this product?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        context.read<ProductBloc>().add(
                                              RemoveProduct(
                                                id: widget.product.id,
                                              ),
                                            );
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.delete_outline_outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
