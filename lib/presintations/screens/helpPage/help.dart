import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../widgets/setting.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);
  static String id = 'HelpScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title:  Text('Help Me',
          style: TextStyle(fontSize: 24,
            color: Colors.white,),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children:   [
              SizedBox(height: 10,
              ),
              TextFeild_(
                text: 'What happened ?',
                keyboardType:TextInputType.multiline,
                maxLine: null ,
                maxLength: 200,
                minLine: 10, icon: null,
              ),
              ElevatedButton(
                onPressed: () {
                  // Pass the problem massage to admin
                },
                child: Text('Submit', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
                style: ElevatedButton.styleFrom(
                  //primary: kMainColor,
                  backgroundColor: kMainColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}