import 'package:flutter/material.dart';

class Birthdays extends StatelessWidget {
  const Birthdays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Birthdays'),
      ),
      body: const Center(
        child: Icon(
          Icons.cake,
          size: 120.0,
          color: Colors.orange,
        ),
      ),
    );
  }
}
