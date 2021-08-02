import 'package:flutter/material.dart';
import 'package:catsanddogs/home.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text(
        "Cats and Dogs",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 30,
          color: Theme.of(context).accentColor,
        ),
      ),
      image: Image.asset("assets/icons/catdog_transparent.png"),
      backgroundColor: Theme.of(context).primaryColor,
      photoSize: 100,
      loaderColor: Theme.of(context).accentColor,
    );
  }
}
