import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
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
  late bool isFavorite;
  late bool isInCart;
  // Future<bool> checkIfInCart() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   // Logic to check if the product is in the cart item collection
  //   // You can use your data source or any other method to perform this check
  //   // For demonstration purposes, let's assume a hypothetical method called 'isInCart'
  //   return await ProductRemoteDsImp()
  //       .isInCart(widget.product.id, _auth.currentUser!);
  // }

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
                      '${widget.product.price}' + tr('EGP'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      tr('Added by: ') + '${widget.product.userName}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      tr('Email: ') + '${widget.product.userEmail}',
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
                              ProductRemoteDsImp().updateProduct(widget.product
                                  .copyWith(isInCart: true, isFav: isFavorite));
                              ProductRemoteDsImp().addToCart(
                                  widget.product.copyWith(quantity: 1));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Product added to cart')),
                              );
                            } else {
                              ProductRemoteDsImp().updateProduct(widget.product
                                  .copyWith(
                                      isInCart: false, isFav: isFavorite));
                              ProductRemoteDsImp()
                                  .removeProductFromCart(widget.product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Product removed from cart')),
                              );
                            }
                          },
                          child: Text(isInCart
                              ? tr('Remove from cart')
                              : tr('Add to cart')),
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
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            print(
                                "Before adding to favorites - isFav: $isFavorite, isInCart: $isInCart");
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            print(
                                "After adding to favorites - isFav: $isFavorite, isInCart: $isInCart");

                            if (isFavorite) {
                              ProductRemoteDsImp().updateProduct(widget.product
                                  .copyWith(isFav: true, isInCart: isInCart));
                              ProductRemoteDsImp().addToFavorites(
                                  widget.product.copyWith(isFav: true));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Product added to favorites')),
                              );
                            } else {
                              ProductRemoteDsImp().updateProduct(widget.product
                                  .copyWith(isFav: false, isInCart: isInCart));
                              ProductRemoteDsImp()
                                  .removeFromFavorites(widget.product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Product removed from favorites')),
                              );
                            }
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