import 'package:firstly/constants.dart';
import 'package:firstly/data/remotDs/product_remote_data_source.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowProducts extends StatefulWidget {
  const ShowProducts({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            // await Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => InfoPage(product: widget.product)));
            // setState(() {});
          },
          child: Container(
            color: Colors.grey[100],
            margin: const EdgeInsets.all(5),
            width: 180,
            height: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GridTile(
                footer: Container(
                  height: 70,
                  color: Colors.white.withOpacity(0.7),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: kSecondaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.product.price.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: kSecondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "EGP",
                            style: TextStyle(
                              fontSize: 16,
                              color: kSecondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          GestureDetector(
                            onTap: () {
                              ProductRemoteDsImp().addToCart(widget.product);
                              // showToast('Product added to cart');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Product added to cart')),
                              );
                            },
                            child: Icon(Icons.add_shopping_cart_outlined),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                child: Image.network(
                  widget.product.image, // Use the product image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
