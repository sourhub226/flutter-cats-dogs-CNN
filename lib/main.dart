import 'package:catsanddogs/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static const labelColor = Color(0xFFcfdfe8);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cats and Dogs Classifier",
      home: MySplash(),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xff1c1c1c),
          canvasColor: Color(0xff222222),
          accentColor: Color(0xfffdbd40),
          primaryIconTheme: IconThemeData(color: Color(0xfffdbd40)),
          iconTheme: IconThemeData(color: labelColor),
          tooltipTheme: TooltipThemeData(
              textStyle: TextStyle(color: labelColor),
              decoration: BoxDecoration(
                  color: Color(0xff1c1c1c),
                  borderRadius: BorderRadius.circular(20)))),
      themeMode: ThemeMode.dark,
    );
  }
}
