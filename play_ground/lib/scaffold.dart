import 'package:flutter/material.dart';

class DemoScaffold extends StatelessWidget {
  const DemoScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scaffold demo'),
      ),
      body: const Center(
        child: Text(
            'Welcome to Scaffold demo',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: const Icon(Icons.add),
        onPressed: () {
          print('FloatingActionButton tapped');
        },
      ),
      drawer: buildDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        fixedColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Orders',
            icon: Icon(Icons.menu),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
        onTap: (int indexOfItem) {
          if (indexOfItem == 0) {
            print('Tapped Home item');
          } else if (indexOfItem == 1) {
            print('Tapped Orders item');
          } else if (indexOfItem == 2) {
            print('Tapped Settings item');
          }
        },
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Scaffold demo',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            leading: Icon(Icons.abc),
          ),
          ListTile(
            title: Text('Item 2'),
            leading: Icon(Icons.man),
          ),
        ],
      ),
    );
  }

}
