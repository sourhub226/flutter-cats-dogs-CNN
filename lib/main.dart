import 'package:catsanddogs/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const labelColor = Color(0xFFcfdfe8);
  static const accentColor = Color(0xfffdc550);
  static const appBarColor = Color(0xff323232);
  static const canvasColor = Color(0xff222222);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cats and Dogs Classifier",
      home: MySplash(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(elevation: 0),
        brightness: Brightness.dark,
        primaryColor: appBarColor,
        canvasColor: canvasColor,
        accentColor: accentColor,
        primaryIconTheme: IconThemeData(color: accentColor),
        iconTheme: IconThemeData(color: labelColor),
        tooltipTheme: TooltipThemeData(
          textStyle: TextStyle(color: labelColor),
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
