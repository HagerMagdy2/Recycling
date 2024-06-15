import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firstly/constants.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  // This function returns the current locale of the app
  Locale getCurrentLocale() {
    return context.locale;
  }

  @override
  Widget build(BuildContext context) {
    // Get the current locale
    Locale currentLocale = getCurrentLocale();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title: Text(tr('Languages')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                tr('Arabic'),
                style: TextStyle(
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: currentLocale.languageCode == 'ar'
                  ? Icon(Icons.check, color: kMainColor)
                  : null,
              onTap: () {
                // Change language to Arabic
                context.setLocale(Locale("ar"));
                setState(() {});
              },
            ),
            ListTile(
              title: Text(
                tr('English'),
                style: TextStyle(
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: currentLocale.languageCode == 'en'
                  ? Icon(Icons.check, color: kMainColor)
                  : null,
              onTap: () {
                // Change language to English
                context.setLocale(Locale("en"));
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
