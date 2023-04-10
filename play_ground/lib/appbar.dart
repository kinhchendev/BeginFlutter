import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoAppBar extends StatelessWidget {
  const DemoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.yellow,
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(),
        body: const Center(
          child: Text(
            'Demo AppBar',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Demo AppBar'),
      titleSpacing: 00.0,
      centerTitle: true,
      toolbarHeight: 64,
      toolbarOpacity: 1.0,
      backgroundColor: Colors.orange,
      foregroundColor: Colors.purple,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )
      ),
      elevation: 10.0,
      actions: [
        IconButton(
          icon: const Icon(Icons.comment),
          tooltip: 'Comment Icon',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Settings Icon',
          onPressed: () {},
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Menu Icon',
        onPressed: () {},
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      flexibleSpace: Container(
        width: 20,
        height: 30,
        color: Colors.green.withOpacity(0.4),
      ),
    );
  }
}
