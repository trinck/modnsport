import 'package:flutter/material.dart';
import 'package:modnsport/utils/utils.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {

   return Scaffold(appBar: AppBar(elevation: 0,leading: const Icon(Icons.show_chart),title: const Text("Stats"),),);
  }



}
