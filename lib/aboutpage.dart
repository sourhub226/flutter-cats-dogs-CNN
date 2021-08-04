import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Hello'),
          ],
        ),
      ),
    );
  }
}
