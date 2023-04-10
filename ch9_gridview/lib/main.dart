import 'package:ch9_gridview/pages/grid_builder.dart';
import 'package:ch9_gridview/pages/grid_count.dart';
import 'package:ch9_gridview/pages/grid_extent.dart';
import 'package:flutter/material.dart';
import 'package:ch9_gridview/widgets/grid_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        title: Text('GridView'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildCard(context, 'GridView.count'),
          buildCard(context, 'GridView.extent'),
          buildCard(context, 'GridView.builder'),
        ],
      ),
    );
  }

  void tapOnCard(BuildContext context, String cardName) {
    print('tapOnCard with cardName = $cardName');
    if (cardName == 'GridView.count') {
      // Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GridCount(),
          )
      );
    } else if (cardName == 'GridView.extent') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GridExtent(),
          )
      );
    } else if (cardName == 'GridView.builder') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GridBuilder(),
          )
      );
    }
  }

  Card buildCard(BuildContext context, String cardName) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                '$cardName',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          tapOnCard(context, cardName);
          },
      ),
    );
  }
}
