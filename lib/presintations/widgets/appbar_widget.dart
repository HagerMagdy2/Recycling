import 'package:flutter/material.dart';

import '../../constants.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(
        color: Colors
            .black), // set backbutton color here which will reflect in all screens.
    leading: BackButton(),
    backgroundColor: kMainColor1,
    elevation: 0,
  );
}