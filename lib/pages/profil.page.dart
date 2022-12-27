import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   CustomScrollView(slivers: [

    /*  Stack(fit: StackFit.expand,
        children: [
          Image(image: AssetImage("assets/images/fitness.jpg"),fit: BoxFit.cover),
          Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,tileMode: TileMode.mirror,colors: [Colors.transparent,Colors.black]))),
          Row(children: [TextButton.icon(onPressed: () => print("+++++++1"), icon: Icon(Icons.add), label: Text("Counter"))],),

        ],
      ),*/


       /*SliverAppBar( floating: true,snap: false,pinned: true,

        expandedHeight: 200.0,
        flexibleSpace: FlexibleSpaceBar(
            title: Text("trinck"),
        ),
      ),*/

     /* SliverFillRemaining(child: Stack(fit: StackFit.expand,
        children: [
          Image(image: AssetImage("assets/images/fitness.jpg"),fit: BoxFit.cover),
          Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,tileMode: TileMode.mirror,colors: [Colors.transparent,Colors.black]))),
          Row(children: [TextButton.icon(onPressed: () => print("+++++++1"), icon: Icon(Icons.add), label: Text("Counter"))],),

        ],
      ),),*/
      SliverPersistentHeader(pinned: true,delegate: MyDelegate()),

      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Container(
             // alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('Grid Item $index'),
            );
          },
          childCount: 50,
        ),
      ),




    ],);
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

   return  Stack(fit: StackFit.expand,
     children: [
       Image(image: AssetImage("assets/images/fitness.jpg"),fit: BoxFit.cover),
       Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,tileMode: TileMode.mirror,colors: [Colors.transparent,Colors.black]))),
       Row(children: [CircleAvatar(backgroundImage: AssetImage("assets/images/dumbbells-2.jpg"),radius:shrinkOffset ),],),

     ],
   );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 400;

  @override
  // TODO: implement minExtent
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return this != oldDelegate;
  }


}
