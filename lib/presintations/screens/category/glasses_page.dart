import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/presintations/screens/add-edit/add_glasses.dart';
import 'package:firstly/presintations/widgets/show_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class GlassesCategoryPage extends StatefulWidget {
  const GlassesCategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GlassesCategoryPage> createState() => _GlassesCategoryPageState();
}

class _GlassesCategoryPageState extends State<GlassesCategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(
          'Glasses Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is ProductLoadingState)
                    Lottie.asset(
                      'assets/images/Animation loading1.json',
                      height: 200,
                      width: 200,
                      repeat: true,
                    ),
                  if (state is ProductErrorState)
                    Text('Error: ${state.errorMessage}'),
                  if (state is ProductLoaded)
                    ListView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling of inner ListView
                      shrinkWrap: true,
                      itemCount: state.products.length,
                      itemBuilder: (context, i) =>
                          ShowProducts(product: state.products[i]),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColor,
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddGlassesPage()));
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
