import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modnsport/blocs/activity/activity.event.dart';
import 'package:modnsport/blocs/authenticationstate/authstate.bloc.dart';
import 'package:modnsport/blocs/authenticationstate/authstate.state.dart';
import 'package:modnsport/blocs/login/login.bloc.dart';
import 'package:modnsport/blocs/profil/profil.bloc.dart';
import 'package:modnsport/blocs/profil/profil.event.dart';
import 'package:modnsport/blocs/profil/profil.state.dart';
import 'package:modnsport/blocs/sigin/sigin.bloc.dart';
import 'package:modnsport/models/activity.model.dart';
import 'package:modnsport/repositories/activity/activity.repository.dart';
import 'package:modnsport/repositories/chat/chat.repository.dart';
import 'package:modnsport/repositories/counter/counter.repository.dart';
import 'package:modnsport/repositories/discipline/discipline.repository.dart';
import 'package:modnsport/repositories/messages/message.repository.dart';
import 'package:modnsport/repositories/user/user.repository.dart';
import 'package:modnsport/repositories/user/user.repository.firebase.dart';


import '../blocs/login/login.event.dart';
import '../blocs/login/login.state.dart';
import '../blocs/sigin/sigin.event.dart';
import '../models/chat.model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}


class _HomeState extends State<Home> {

  List<Activity> activities = [];
  CounterRepository  repository = CounterRepository();
  UserRepositoryFirebase userRepository = GetIt.instance.get<UserRepositoryFirebase>();
  DisciplineRepository disciplineRepository = DisciplineRepository();
  StreamController<OnActivityEvent> controller = StreamController();
  ChatRepository chatRepository = ChatRepository();
  ActivityRepository activityRepository = ActivityRepository();
  MessageRepository messageRepository = MessageRepository();
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

  return   CustomScrollView(slivers: [

    SliverAppBar(floating: true,snap: false,

      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(background: Stack(fit: StackFit.expand,
        children: [
          Image(image: AssetImage("assets/images/fitness.jpg"),fit: BoxFit.cover),
          Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,tileMode: TileMode.mirror,colors: [Colors.transparent,Colors.black]))),
          Row(children: [TextButton.icon(onPressed: () => print("+++++++1"), icon: Icon(Icons.add), label: Text("Counter")), CircleAvatar(backgroundImage: AssetImage("assets/images/dumbbells-2.jpg"),radius:50 ), ],),

        ],
      ),

      ),
    ),

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

 void _logOut() {
    context.read<ProfilBloc>().add(LogOut());
  }

  void profile() {
    Navigator.of(context).pushNamed("profile");

  }


}

