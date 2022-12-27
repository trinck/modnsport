import 'package:flutter/material.dart';
import 'package:modnsport/models/activity.model.dart';
class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key, Activity? activity}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(title: const Text("Activity")),body: Container(),);
  }



 Widget myDialog(BuildContext context){

    return AlertDialog(content:const SizedBox(
      child: Text("an email check was sent ...")
    ),
      actions: [
        OutlinedButton(onPressed: () => Navigator.of(context).pop(),child: const Text("Abort"),),

      ],icon: CircleAvatar(radius: 50, child: Image.asset("assets/images/logo2.jpg")),elevation: 0,);

}

Widget mySheet(BuildContext context){

    return BottomSheet(enableDrag: false,elevation: 10,onClosing: () {  }, builder: (BuildContext context) { return Column(mainAxisSize: MainAxisSize.min,
      children: [
        const Text("hvhvc"),
        const Text("hvhvc"),
        const Text("hvhvc"),
        const Text("hvhvc"),
        const Text("hvhvc"),
        const Text("hvhvc"),
      ],
    ); },);
}
}

