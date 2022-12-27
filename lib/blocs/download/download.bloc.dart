import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modnsport/blocs/download/download.event.dart';
import 'package:modnsport/blocs/download/download.state.dart';

class DownloadBlocImages extends Bloc<DownloadManagementEvent,DownloadManagementState>{

  DownloadBlocImages(super.initialState){

    on<Download>((event, emit)async{

      event.task.snapshotEvents.listen((event2) {
        switch(event2.state){
          case TaskState.running : emit(DownloadRunning(task: event.task, progress: 100 * event2.bytesTransferred ~/ event2.totalBytes));
            break;
          case TaskState.paused: emit(DownloadPaused(task: event.task, progress: 100 * event2.bytesTransferred ~/ event2.totalBytes));
            break;
          case TaskState.success: emit(DownloadSuccess(task: event.task, progress: 100 * event2.bytesTransferred ~/ event2.totalBytes));
           break;
          default : emit(DownloadError(task: event.task, progress: 100 * event2.bytesTransferred ~/ event2.totalBytes));
           break;

        }
      });
    });
    /**on<DownloadPause>((event, emit) => event.);
    on<DownloadCancel>((event, emit) => null);
    on<DownloadResume>((event, emit) => null);*/
  }


}