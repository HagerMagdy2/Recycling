import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/data/remotDs/plastic-remot-ds.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/presintations/bloc/plastic_bloc.dart';
import 'package:firstly/presintations/bloc/plastic_state.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowPlastic extends StatefulWidget {
  const ShowPlastic({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ShowPlastic> createState() => _ShowPlasticState();
}

class _ShowPlasticState extends State<ShowPlastic> {
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
    return BlocBuilder<PlasticBloc, PlasticState>(
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
                            print(
                                "Before adding to cart - isFav: $isFavorite, isInCart: $isInCart");
                            setState(() {
                              isInCart = !isInCart;
                            });
                            print(
                                "After adding to cart - isFav: $isFavorite, isInCart: $isInCart");
                            if (isInCart) {
                              // Update only isInCart status
                              PlasticRemoteDsImp().updatePlastic(
                                  widget.product.copyWith(isInCart: true));
                              PlasticRemoteDsImp().addToCart(
                                  widget.product.copyWith(quantity: 1));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Product added to cart')),
                              );
                            } else {
                              // Update only isInCart status
                              PlasticRemoteDsImp().updatePlastic(
                                  widget.product.copyWith(isInCart: false));
                              PlasticRemoteDsImp()
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
                            print(
                                "Before adding to favorites - isFav: $isFavorite, isInCart: $isInCart");
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            print(
                                "After adding to favorites - isFav: $isFavorite, isInCart: $isInCart");

                            if (isFavorite) {
                              // Update only isFav status
                              PlasticRemoteDsImp().updatePlastic(
                                  widget.product.copyWith(isFav: true));
                              ProductRemoteDsImp().addToFavorites(
                                  widget.product.copyWith(isFav: true));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Product added to favorites')),
                              );
                            } else {
                              // Update only isFav status
                              PlasticRemoteDsImp().updatePlastic(
                                  widget.product.copyWith(isFav: false));
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
