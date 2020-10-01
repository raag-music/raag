import 'package:flutter/material.dart';
import 'package:raag/model/strings.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: title,
        home: Scaffold(
          appBar: new AppBar(
            title: new Text(title),
          ),
          body: new Center(
            child: Container(
              child: Text(title),
            ),
          ),
        ));
  }
}
