import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:  Column(
        children: [
          DrawerHeader(child: Text("MyDrawer"))
        ],
      ),
    );
  }
}
