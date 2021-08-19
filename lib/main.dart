import 'package:catsanddogs/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const labelColor = Color(0xFfc0d8ed);
  static const accentColor = Color(0xfffdc550);
  static const appBarColor = Color(0xff232b2e);
  static const canvasColor = Color(0xff161c1d);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cats and Dogs Classifier",
      home: MySplash(),
      theme: ThemeData(
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
