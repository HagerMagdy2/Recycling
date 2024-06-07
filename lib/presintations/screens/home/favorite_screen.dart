import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/presintations/widgets/show_fav.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return Center(
              child: Lottie.asset(
                'assets/images/Animation loading1.json',
                height: 200,
                width: 200,
                repeat: true,
              ),
            );
          } else if (state is ProductErrorState) {
            return Text('Error: ${state.errorMessage}');
          } else if (state is ProductLoaded) {
            // Filter products where isFav is true
            final favoriteProducts =
                state.products.where((product) => product.isFav).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, i) =>
                          ShowFav(product: favoriteProducts[i]),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(); // Return empty container for other states
          }
        },
      ),
    );
  }
}