import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/demo/demo.repository.firebase.dart';
import 'demo.event.dart';
import 'demo.state.dart';

class DemoBloc extends Bloc<DemoManagementEvent, DemoManagementState>
{
  DemoRepositoryFirebase demoRepositoryFirebase = GetIt.I.get<DemoRepositoryFirebase>();

  DemoBloc(super.initialState){

    on<GetDemo>((event, emit)async {

     // await Future.delayed(const Duration(seconds: 10));
      emit(ViewedDemo(illustration: ["demo1", "demo2","demo3", "demo4"], currentIllustration: 0));

    });
    on<NextDemo>((event, emit)async {
      emit(ViewedDemo(illustration: (state as ViewedDemo).illustration, currentIllustration: (state as ViewedDemo).currentIllustration+1));
    });
    on<PrecedeDemo>((event, emit)async {
      emit(ViewedDemo(illustration: (state as ViewedDemo).illustration, currentIllustration: (state as ViewedDemo).currentIllustration-1));});

  }

}