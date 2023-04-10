import 'package:flutter/material.dart';

class DemoRowColumn extends StatefulWidget {
  const DemoRowColumn({Key? key}) : super(key: key);

  @override
  State<DemoRowColumn> createState() => _DemoRowColumnState();
}

class _DemoRowColumnState extends State<DemoRowColumn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Row and Column example')
    ),
      body: Container(
        margin: EdgeInsets.all(10),
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.lightGreen.shade500,
            ]
          )
        ),
        child: buildColumn(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        buildRow('Row 1'),
        buildRow('Row 2'),
        buildRow('Row 3'),
      ],
    );
  }

  Container buildRow(String name) {
    return Container(
        height: 80,
        width: double.maxFinite,
        margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          color: Colors.lightBlueAccent.shade100,
        ),
        child: Text(name),
      );
  }
}