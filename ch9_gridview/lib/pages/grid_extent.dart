import 'package:flutter/material.dart';
import 'package:ch9_gridview/widgets/grid_icons.dart';

class GridExtent extends StatefulWidget {
  const GridExtent({Key? key}) : super(key: key);

  @override
  State<GridExtent> createState() => _GridExtentState();
}

class _GridExtentState extends State<GridExtent> {

  List<IconData> _iconList = GridIcons().getIconList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gridview.count'),
        ),
        body: Center(
          child: GridView.extent(
            maxCrossAxisExtent: 100.0,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(8.0),
            children: List.generate(50, (index) {
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
