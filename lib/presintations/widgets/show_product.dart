import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/core/firebase-service.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/compost_event.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowProducts extends StatefulWidget {
  const ShowProducts({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  bool isFavorite = false;
  bool isInCart = false;
  String? userName;
  String? userEmail;
  String? userPhoneNumber;

  @override
  void initState() {
    super.initState();
    fetchUserInfo(widget.product.userId);
  }

  void dispose() {
    // Cancel any ongoing operations here, such as async tasks or listeners
    // For example, if you have any StreamSubscription objects, cancel them here
    super.dispose();
  }

  Future<void> fetchUserInfo(String userId) async {
    try {
      // Fetch user information based on user ID
      User? user = await FirebaseService().getUserInfo(userId);
      if (user != null) {
        setState(() {
          // Set user information if user is found
          userName = user.displayName;
          userEmail = user.email;
          userPhoneNumber = user.phoneNumber;
        });
      } else {
        print("User not found.");
      }
    } catch (e) {
      print("Error fetching user information: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Container(
          color: Colors.grey[200],
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
                    if (userName != null) // Check if userName is not null
                      Text(
                        'Added by: $userName',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    if (userEmail != null) // Check if userEmail is not null
                      Text(
                        'Email: $userEmail',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    if (userPhoneNumber !=
                        null) // Check if userPhoneNumber is not null
                      Text(
                        'Phone: $userPhoneNumber',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              isInCart = !isInCart;
                            });
                            if (isInCart) {
                              ProductRemoteDsImp().addToCart(
                                  widget.product.copyWith(quantity: 1));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Product added to cart')),
                              );
                            } else {
                              ProductRemoteDsImp()
                                  .removeProductFromCart(widget.product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Product removed from cart')),
                              );
                            }
                          },
                          child: Text(
                              isInCart ? 'Remove from cart' : 'Add to cart'),
                          style: OutlinedButton.styleFrom(
                            primary: isInCart ? Colors.white : kMainColor,
                            backgroundColor:
                                isInCart ? kMainColor : Colors.white,
                            side: BorderSide(
                                color: isInCart ? kMainColor : kMainColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            fixedSize: const Size(170, 40),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            // Add logic to handle favorite status
                          },
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
