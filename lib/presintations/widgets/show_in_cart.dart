// show_in_cart.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowInCart extends StatefulWidget {
  const ShowInCart({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ShowInCart> createState() => _ShowInCartState();
}

class _ShowInCartState extends State<ShowInCart> {
  late bool isFavorite;
  late bool isInCart;
  @override
  void initState() {
    super.initState();

    isFavorite = widget.product.isFav;
    isInCart = widget.product.isInCart;
    // Check if the product is in the cart item collection
    // You'll need to replace 'checkIfInCart' with the appropriate method or logic
    // checkIfInCart().then((inCart) {
    //   setState(() {
    //     isInCart = inCart;
    //   });
    // });
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
              Column(
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
                  Row(
                    children: [
                      Text(
                        widget.product.price.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        tr("EGP"),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.product.quantity > 1) {
                              widget.product.quantity--;
                              // Update the product quantity in the cart
                              context.read<ProductBloc>().add(
                                  UpdateCartProduct(product: widget.product));
                              print(
                                  'Decreased quantity: ${widget.product.quantity}');
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        widget.product.quantity.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            // Check if increasing quantity exceeds available stock
                            if (widget.product.quantity <
                                widget.product.availableQuantity) {
                              // Increment the product quantity
                              widget.product.quantity++;
                              // Update the product quantity in the cart
                              context.read<ProductBloc>().add(
                                  UpdateCartProduct(product: widget.product));
                              print(
                                  'Increased quantity: ${widget.product.quantity}');
                            } else {
                              // If quantity exceeds available stock, show a message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('exceed the available quantity')),
                              );
                            }
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      ProductRemoteDsImp().updateProduct(
                          widget.product.copyWith(isInCart: false));

                      // Dispatch the RemoveProductFromCart event
                      context.read<ProductBloc>().add(RemoveProductFromCart(
                          product: widget.product, id: widget.product.id));

                      // Show a snackbar to indicate that the product has been removed from the cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Product removed from cart')),
                      );

                      setState(() {
                        // Update isInCart field locally
                        widget.product.isInCart = false;
                      });
                    },
                    child: Text(tr('Remove from cart')),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: kMainColor,
                      side: BorderSide(color: kMainColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      fixedSize: const Size(170, 40),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}