import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:firstly/constants.dart';
import 'package:firstly/presintations/bloc/papers_bloc.dart';
import 'package:firstly/presintations/bloc/papers_state.dart';
import 'package:firstly/presintations/bloc/papers_event.dart';
import 'package:firstly/presintations/screens/add-edit/add-papers.dart';
import 'package:firstly/presintations/widgets/show_product.dart';

class PapersCategoryPage extends StatefulWidget {
  const PapersCategoryPage({Key? key}) : super(key: key);

  @override
  State<PapersCategoryPage> createState() => _PapersCategoryPageState();
}

class _PapersCategoryPageState extends State<PapersCategoryPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<PapersBloc>().add(GetPapers());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: kSecondaryColor),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: kMainColor,
                context: context,
                isScrollControlled: false,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: searchController,
                        onChanged: (query) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
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
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.products.length,
                    itemBuilder: (context, i) {
                      final product = state.products[i];
                      if (searchController.text.isNotEmpty &&
                          !product.name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                        return SizedBox.shrink();
                      }
                      return ShowProducts(product: product);
                    },
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColor,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPapersPage()),
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
