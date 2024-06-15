import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowFav extends StatefulWidget {
  const ShowFav({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ShowFav> createState() => _ShowFavState();
}

class _ShowFavState extends State<ShowFav> {
  late bool isFavorite;
  late bool isInCart;
  Future<bool> checkIfInCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // Logic to check if the product is in the cart item collection
    // You can use your data source or any other method to perform this check
    // For demonstration purposes, let's assume a hypothetical method called 'isInCart'
    return await ProductRemoteDsImp()
        .isInCart(widget.product.id, _auth.currentUser!);
  }

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
                    // Check if userPhoneNumber is not null
                    // Text(
                    //   'Phone:${widget.product.userPhone}',
                    //   style: const TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              isInCart = !isInCart;
                            });
                            if (isInCart) {
                              // Update only isInCart status
                              ProductRemoteDsImp().updateProduct(
                                  widget.product.copyWith(isInCart: true));
                              ProductRemoteDsImp().addToCart(
                                  widget.product.copyWith(quantity: 1));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Product added to cart')),
                              );
                            } else {
                              // Update only isInCart status
                              ProductRemoteDsImp().updateProduct(
                                  widget.product.copyWith(isInCart: false));
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
                            foregroundColor: isInCart ? Colors.white : kMainColor, backgroundColor:
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
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            ProductRemoteDsImp().updateProduct(
                                widget.product.copyWith(isFav: false));
                            context.read<ProductBloc>().add(
                                RemoveProductFromFavorites(
                                    id: widget.product.id));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Product removed from favorites')),
                            );
                            setState(() {});

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
