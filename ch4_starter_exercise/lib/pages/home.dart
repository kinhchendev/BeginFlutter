import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHorizontalRow(),
                Padding(padding: EdgeInsets.all(16.0)),
                _buildRowAndColumn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildRowAndColumn() {
    return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        color: Colors.yellow,
                        height: 60.0,
                        width: 60.0,
                      ),
                      Padding(padding: EdgeInsets.all(16.0)),
                      Container(
                        color: Colors.amber,
                        height: 40.0,
                        width: 40.0,
                      ),
                      Padding(padding: EdgeInsets.all(16.0)),
                      Container(
                        color: Colors.brown,
                        height: 20.0,
                        width: 20.0,
                      ),
                      Divider(),
                      Row(
                        children: [
                          // Next step we'll add more widgets
                          CircleAvatar(
                            backgroundColor: Colors.lightGreen,
                            radius: 100.0,
                            child: Stack(
                              children: [
                                Container(
                                  height: 100.0,
                                  width: 100.0,
                                  color: Colors.yellow,
                                ),
                                Container(
                                  height: 60.0,
                                  width: 60.0,
                                  color: Colors.amber,
                                ),
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  color: Colors.brown,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Text('End of the Line'),
                    ],
                  ),
                ],
              );
  }

  Row _buildHorizontalRow() {
    return Row(
                children: [
                  Container(
                    color: Colors.yellow,
                    height: 40.0,
                    width: 40.0,
                  ),
                  Padding(padding: EdgeInsets.all(16.0)),
                  Expanded(
                    child: Container(
                      color: Colors.amber,
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(16.0)),
                  Container(
                    color: Colors.brown,
                    height: 40.0,
                    width: 40.0,
                  )
                ],
              );
  }
}

class HomeTwo extends StatefulWidget {
  const HomeTwo({Key? key}) : super(key: key);

  @override
  State<HomeTwo> createState() => _HomeTwoState();
}

class _HomeTwoState extends State<HomeTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeeksforGeeks'),
        backgroundColor: Colors.greenAccent[400],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 0.0,
              width: 128,
              child: Icon(Icons.message,
                  size: 128.0,
                  color: Colors.greenAccent[400]),
            ),
            Positioned(
              top: 0,
              left: 128,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Text('24'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
