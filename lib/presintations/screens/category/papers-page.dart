import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/papers_bloc.dart';
import 'package:firstly/presintations/bloc/papers_event.dart';
import 'package:firstly/presintations/bloc/papers_state.dart';
import 'package:firstly/presintations/screens/add-edit/add-papers.dart';

import 'package:firstly/presintations/screens/add-edit/add_produc.dart';
import 'package:firstly/presintations/widgets/show_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PapersCategoryPage extends StatefulWidget {
  const PapersCategoryPage({
    super.key,
  });

  @override
  State<PapersCategoryPage> createState() => _PapersCategoryPageState();
}

class _PapersCategoryPageState extends State<PapersCategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<PapersBloc>().add(GetPapers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(
          'Papers Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<PapersBloc, PapersState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  if (state is PapersLoadingState)
                    Lottie.asset(
                      'assets/images/Animation loading1.json',
                      height: 200,
                      width: 200,
                      repeat: true,
                    ),
                  if (state is PapersErrorState)
                    Text('Error: ${state.errorMessage}'),
                  if (state is PapersLoaded)
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
              MaterialPageRoute(builder: (context) => AddPapersPage()));
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
