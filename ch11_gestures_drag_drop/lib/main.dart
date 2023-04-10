import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _gestureDetected = "";
  Color _paintedColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestures, Drag and Drop'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildGestureDetector(),
              const Divider(
                color: Colors.black,
                height: 44.0,
              ),
              _buildDraggable(),
              const Divider(
                height: 40.0,
              ),
              _buildDragTarget(),
              const Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        print('onTap');
        _displayGestureDetected('onTap');
      },
      onDoubleTap: () {
        print('onDoubleTap');
        _displayGestureDetected('onDoubleTap');
      },
      onLongPress: () {
        print('onLongPress');
        _displayGestureDetected('onLongPress');
      },
      onPanUpdate: (DragUpdateDetails details) {
        print('onPanUpdate: $details');
        _displayGestureDetected('onPanUpdate: \n$details');
      },
      child: Container(
        color: Colors.lightGreen,
        width: double.infinity,
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(
              Icons.access_alarm,
              size: 98.0,
            ),
            Text('$_gestureDetected'),
          ],
        ),
      ),
    );
  }

  void _displayGestureDetected(String gesture) {
    setState(() {
      _gestureDetected = gesture;
    });
  }

  Draggable<int> _buildDraggable() {
    return Draggable(
      childWhenDragging: const Icon(
        Icons.palette,
        color: Colors.grey,
        size: 48.0,
      ),
      feedback: const Icon(
        Icons.brush,
        color: Colors.deepOrange,
        size: 80.0,
      ),
      data: Colors.purple.value,
      child: Column(
        children: const [
          Icon(
            Icons.palette,
            color: Colors.deepOrange,
            size: 48.0,
          ),
          Text('Drag Me below to change color'),
        ],
      ),
    );
  }

  DragTarget<int> _buildDragTarget() {
    return DragTarget<int>(
      onAccept: (colorValue) {
        _paintedColor = Color(colorValue);
      },
      builder: (BuildContext context,
                List<dynamic> acceptedData,
                List<dynamic> rejectedData) {
        return acceptedData.isEmpty ?
        Text(
          'Drag To see color change',
          style: TextStyle(
            color: _paintedColor
          ),
        ):
        Text(
          'Painting Color: $acceptedData',
          style: TextStyle(
            color: Color(acceptedData[0]),
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
