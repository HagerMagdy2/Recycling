import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemsGrideTail extends StatefulWidget {
  const ItemsGrideTail({super.key});

  @override
  State<ItemsGrideTail> createState() => _ItemsGrideTailState();
}

class _ItemsGrideTailState extends State<ItemsGrideTail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
    leading: Image.asset("assets/images/cup.png"),
    title: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text("Title"),
    Row(children: [Text("data   "),Text("data    "),Text("data   ")],)]),
      ),
    );
  }
}