import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/plastic_bloc.dart';
import 'package:firstly/presintations/bloc/plastic_event.dart';
import 'package:firstly/presintations/bloc/plastic_state.dart';
import 'package:firstly/presintations/screens/add-edit/add-plastic.dart';
import 'package:firstly/presintations/widgets/show_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PlasticCategoryPage extends StatefulWidget {
  const PlasticCategoryPage({
    super.key,
  });

  @override
  State<PlasticCategoryPage> createState() => _PlasticCategoryPageState();
}

class _PlasticCategoryPageState extends State<PlasticCategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<PlasticBloc>().add(GetPlastic());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(
          'Plastic Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<PlasticBloc, PlasticState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is PlasticLoadingState)
                    Lottie.asset(
                      'assets/images/Animation loading1.json',
                      height: 200,
                      width: 200,
                      repeat: true,
                    ),
                  if (state is PlasticErrorState)
                    Text('Error: ${state.errorMessage}'),
                  if (state is PlasticLoaded)
                    ListView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling of inner list
                      scrollDirection: Axis.vertical,
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
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPlasticPage()),
          );
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
