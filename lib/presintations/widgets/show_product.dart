import 'package:firstly/constants.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/data/product_remote_data_source.dart';
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
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              isInCart = !isInCart;
                            });
                            if (isInCart) {
                              ProductRemoteDsImp().addToCart(widget.product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Product added to cart')),
                              );
                            } else {
                              ProductRemoteDsImp().removeProductFromCart(widget.product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Product removed from cart')),
                              );
                            }
                          },
                          child: Text(isInCart ? 'Remove from cart' : 'Add to cart'),
                          style: OutlinedButton.styleFrom(
                            //primary: isInCart ? Colors.white : kMainColor,
                            backgroundColor: isInCart ? kMainColor : Colors.white,
                            side: BorderSide(color: isInCart ? kMainColor : kMainColor),
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
