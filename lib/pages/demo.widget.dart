import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/demo/demo.bloc.dart';
import '../blocs/demo/demo.event.dart';
import '../blocs/demo/demo.state.dart';

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(body: BlocBuilder<DemoBloc, DemoManagementState>(builder: (BuildContext context, state) {

      if(state is InitDemos){
       return const Center(child: CircularProgressIndicator());
      }

      return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text((state as ViewedDemo).illustration[state.currentIllustration]),
          Row(
            children: [MaterialButton(child: const Text("Precedent"),onPressed: () { if(state.illustration.length>= state.currentIllustration && state.currentIllustration>0 ){context.read<DemoBloc>().add(PrecedeDemo());} },), MaterialButton(child: const Text("Next"),onPressed: () { if(state.illustration.length> state.currentIllustration+1){context.read<DemoBloc>().add(NextDemo());} },),MaterialButton(child: const Text("Skip"),onPressed: () { Navigator.of(context).popAndPushNamed("landing"); },)   ],
          )
        ],
      );

    },

    ));


    return BlocBuilder<DemoBloc, DemoManagementState>(builder: (BuildContext context, state) {

      if(state is InitDemos){
        return const CircularProgressIndicator();
      }

        return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text((state as ViewedDemo).illustration[state.currentIllustration]),
            Row(
              children: [MaterialButton(child: const Text("Precedent"),onPressed: () { if(state.illustration.length>= state.currentIllustration && state.currentIllustration>0 ){context.read<DemoBloc>().add(PrecedeDemo());} },), MaterialButton(child: const Text("Next"),onPressed: () { if(state.illustration.length> state.currentIllustration+1){context.read<DemoBloc>().add(NextDemo());} },),MaterialButton(child: const Text("Skip"),onPressed: () { Navigator.of(context).popAndPushNamed("landing"); },)   ],
            )
          ],
        );

    },

    );
  }
}
