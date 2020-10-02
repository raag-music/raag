import 'package:flutter/material.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/view/home_scaffold.dart';
import 'package:raag/provider/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        title: title,
        home: HomeScaffold()
    );
  }
}
