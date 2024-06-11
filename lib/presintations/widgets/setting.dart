import 'package:flutter/material.dart';

Widget SettingIcons(
    {required IconData icon,
      required void Function()? function,
      required double size}) =>
    Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: IconButton(
        icon: Icon(
          icon,
          size: size,
          color: Colors.grey[500],
        ),
        onPressed: function,
      ),
    );

Widget MenuPage(
    {required Color color,
      required IconData icon,
      required text,
      required fun,
      context}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text,
              style:
              Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
              textScaleFactor: 1.5,
            ),
          ),
          trailing: SettingIcons(
            icon: Icons.arrow_forward_ios_outlined,
            function: fun,
            size: 20,
          ),
          selected: true,
          onTap: fun),
    );

class TextFeild_ extends StatelessWidget {
  const TextFeild_(
      {Key? key,
        required this.icon,
        required this.text,
        required this.maxLine,
        required this.keyboardType,
        this.maxLength,
        this.minLine})
      : super(key: key);
  final IconData? icon;
  final String text;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextField(
        keyboardType: keyboardType,
        maxLines: maxLine,
        minLines: minLine,
        maxLength: maxLength,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
          // labelText: text,
          labelText: text,
          prefixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
Widget defaultButton({
  double width = double.infinity,
  double height = 40.0,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function() function,
  required String text,
  //double width = double.infinity,
  // Color background = Colors.blue,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          '${isUpperCase ? text.toUpperCase() : text}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );