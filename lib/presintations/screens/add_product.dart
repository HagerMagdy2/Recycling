import 'dart:io';

import 'package:firstly/constants.dart';
import 'package:firstly/core/storage_helper.dart';
import 'package:firstly/presintations/widgets/add_photo.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProductScreen';
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController title = TextEditingController();

  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADD PRODUCT",
        ),
        backgroundColor: kMainColor,
      ),
      body: SizedBox(
        child: ListView(children: [
          // Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: TextField(
          //       controller: title,
          //       style:
          //           TextStyle(color: const Color.fromARGB(176, 255, 255, 255)),
          //       cursorColor: Colors.white,
          //       decoration: InputDecoration(
          //           enabledBorder: UnderlineInputBorder(
          //             borderSide: BorderSide(color: kMainColor1),
          //           ),
          //           focusedBorder: UnderlineInputBorder(
          //             borderSide: BorderSide(color: kMainColor1),
          //           ),
          //           hoverColor: Colors.white,
          //           labelText: "Image frome network",
          //           labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
          //     )),
          GestureDetector(
            onTap: () async {
              await showDialog(
                      context: context, builder: (context) => AddPhoto())
                  .then((value) => file = value);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 250,
                child: Text(
                  file == null ? "Add photo" : "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(128, 158, 158, 158),
                    image: file != null
                        ? DecorationImage(
                            image: FileImage(file!),
                            fit: BoxFit.cover,
                          )
                        : null),
              ),
            ),
          ),
          Container(
              width: double.infinity,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  //     alignment: Alignment(0, 0.9),
                  backgroundColor: kMainColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () async {
                  // context.read<PlaceBloc>().add(AddPlaceEvent(
                  //     place: Place(
                  //         latitude: 5,
                  //         longitude: 5,
                  //         id: "id",
                  //         userId: "userId",
                  await StorageHelperImpl().uploadImageFromFile(file!);
                  //         title: title.text,
                  //         location:
                  //             "${country}-${city}-${road}")));
                },
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ]),
      ),
    );
  }
}
