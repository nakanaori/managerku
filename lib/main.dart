import 'package:flutter/material.dart';
import 'details.dart';
import 'calendar.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ManagerKu",
      home: Home(),
    );
  }
}
