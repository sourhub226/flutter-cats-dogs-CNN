// import 'package:cats_dogs_classifier/home.dart';
import 'package:cats_dogs_classifier/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cat vs Dog",
      home:MySplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
