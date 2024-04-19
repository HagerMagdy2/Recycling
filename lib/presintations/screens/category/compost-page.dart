import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/compost_bloc.dart';
import 'package:firstly/presintations/bloc/compost_event.dart';
import 'package:firstly/presintations/bloc/compost_state.dart';
import 'package:firstly/presintations/bloc/products_bloc.dart';
import 'package:firstly/presintations/bloc/products_event.dart';
import 'package:firstly/presintations/bloc/products_state.dart';
import 'package:firstly/presintations/screens/add-edit/add-compost.dart';
import 'package:firstly/presintations/screens/add-edit/add_produc.dart';
import 'package:firstly/presintations/widgets/show_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CompostCategoryPage extends StatefulWidget {
  const CompostCategoryPage({
    super.key,
  });

  @override
  State<CompostCategoryPage> createState() => _CompostCategoryPageState();
}

class _CompostCategoryPageState extends State<CompostCategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<CompostBloc>().add(GetCompost());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(
          'Compost Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<CompostBloc, CompostState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  if (state is CompostLoadingState)
                    Lottie.asset(
                      'assets/images/Animation loading1.json',
                      height: 200,
                      width: 200,
                      repeat: true,
                    ),
                  if (state is CompostErrorState)
                    Text('Error: ${state.errorMessage}'),
                  if (state is CompostLoaded)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.products.length,
                          itemBuilder: (context, i) =>
                              ShowProducts(product: state.products[i])),
                    )
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColor,
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCompostPage()));
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
