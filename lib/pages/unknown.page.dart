import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  final String? name;
  const UnknownPage({Key? key,this.name }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children:  [const Icon(Icons.warning, color: Colors.orangeAccent, size:60), const SizedBox(width: 8,), Text("There is no page on this path: $name")]),),);
  }
}
