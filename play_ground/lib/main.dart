import 'package:flutter/material.dart';
import 'package:play_ground/appbar.dart';
import 'package:play_ground/container.dart';
import 'package:play_ground/rowcolumn.dart';
import 'package:play_ground/scaffold.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoRowColumn(),
      debugShowCheckedModeBanner: false,
    );
  }
}
