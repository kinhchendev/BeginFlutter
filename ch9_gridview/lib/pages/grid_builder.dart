import 'dart:math';

import 'package:ch9_gridview/widgets/grid_icons.dart';
import 'package:flutter/material.dart';

class GridBuilder extends StatelessWidget {
  const GridBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> _iconList = GridIcons().getIconList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gridview.count'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150.0,
          ),
          itemCount: 51,
          itemBuilder: (BuildContext context, int index) {
            Color cardColor = Colors.grey;
            int seed = Random().nextInt(50);
            if (seed % 4 == 0) {
              cardColor = Colors.lightBlue;
            } else if (seed % 4 == 1) {
              cardColor = Colors.lightGreen;
            } else if (seed % 4 == 2) {
              cardColor = Colors.red;
            } else {
              cardColor = Colors.yellow;
            }
            return Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _iconList[index % 20],
                        size: 48.0,
                        color: cardColor,
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
            },
        ),
      ),
    );
  }
}

