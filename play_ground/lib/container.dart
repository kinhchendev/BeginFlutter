import 'package:flutter/material.dart';

class DemoContainer extends StatefulWidget {
  const DemoContainer({Key? key}) : super(key: key);

  @override
  State<DemoContainer> createState() => _DemoContainerState();
}

class _DemoContainerState extends State<DemoContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container example')
      ),
      body: Container(
        // color: Colors.purpleAccent.shade100,
        height: 400,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.purpleAccent.shade100,
          border: Border.all(color: Colors.black, width: 2),
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.5,
            colors: [
              Colors.white,
              Colors.lightGreen.shade300,
              Colors.yellow.shade400,
              Colors.red.shade400
            ]
          )
        ),
        transform: Matrix4.rotationZ(0.0),
        child: const Text(
          'Hello, I\'m in a container. '
              'This is a quick example about Container properties',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
