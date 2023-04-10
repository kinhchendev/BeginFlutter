import 'package:flutter/material.dart';
import 'package:ch9_gridview/widgets/grid_icons.dart';

class GridCount extends StatefulWidget {
  const GridCount({Key? key}) : super(key: key);

  @override
  State<GridCount> createState() => _GridCountState();
}

class _GridCountState extends State<GridCount> {

  List<IconData> _iconList = GridIcons().getIconList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Gridview.count'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.all(8.0),
          children: List.generate(50, (index) {
            print('_buildGridView $index');
            return Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _iconList[index % 20],
                      size: 48.0,
                      color: Colors.blue,
                    ),
                    Divider(),
                    Text(
                      'Index $index',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  print('Row $index');
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
