import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firstly/data/models/product.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/constants.dart';

class ShowForYou extends StatefulWidget {
  const ShowForYou({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ShowForYou> createState() => _ShowForYouState();
}

class _ShowForYouState extends State<ShowForYou> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white, // White background color
            borderRadius: BorderRadius.circular(30), // Circular border
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(50), // Circular border for image
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
                        color: kMainColor1,
                      ),
                    ),
                    const SizedBox(height: 5),
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
