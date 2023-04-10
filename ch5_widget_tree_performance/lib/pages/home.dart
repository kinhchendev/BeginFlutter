// home.dart
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _buttonTapHandler() {
    print('Button tap handler');
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    print('Home build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Tree'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                const RowWidget(),
                Padding(padding: EdgeInsets.all(16.0)),
                const RowAndColumnWidget(),
                FloatingActionButton(
                  onPressed: _buttonTapHandler,
                  tooltip: 'Button',
                  child: const Icon(Icons.lightbulb),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowAndColumnWidget extends StatelessWidget {
  const RowAndColumnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('RowAndColumnWidget build');
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max, children: <Widget>[
          Container(
            color: Colors.yellow, height: 60.0,
            width: 60.0,
          ), Padding(
            padding: EdgeInsets.all(16.0), ),
          Container(
            color: Colors.amber, height: 40.0,
            width: 40.0,
          ), Padding(
            padding: EdgeInsets.all(16.0), ),
          Container(
            color: Colors.brown, height: 20.0,
            width: 20.0,
          ),
          Divider(),
          const RowAndStackWidget(),
          Divider(),
          Text('End of the Line. Date: ${DateTime.now()}'),
        ], ),
      ], );
  }
}

class RowAndStackWidget extends StatelessWidget {
  const RowAndStackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('RowAndStackWidget build');
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.lightGreen, radius: 100.0,
          child: Stack(
            children: <Widget>[ Container(
              height: 100.0,
              width: 100.0,
              color: Colors.yellow,
            ), Container(
              height: 60.0,
              width: 60.0,
              color: Colors.amber, ),
              Container(
                height: 40.0,
                width: 40.0,
                color: Colors.brown,
              ), ],
          ), ),
      ], );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('RowWidget build');

    return Row(
      children: <Widget>[
        Container(
          color: Colors.yellow, height: 40.0,
          width: 40.0,
        ), Padding(
          padding: EdgeInsets.all(16.0), ),
        Expanded(
          child: Container(
            color: Colors.amber, height: 40.0,
            width: 40.0,
          ), ),
        Padding(
          padding: EdgeInsets.all(16.0),
        ), Container(
          color: Colors.brown, height: 40.0,
          width: 40.0,
        ), ],
    );
  }
}