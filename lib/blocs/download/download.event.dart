import 'package:firebase_storage/firebase_storage.dart';

abstract class DownloadManagementEvent{}

class Download extends DownloadManagementEvent{
  DownloadTask task;
  Download({required this.task});
}


class DownloadPause extends DownloadManagementEvent{

}

class DownloadCancel extends DownloadManagementEvent{

}
class DownloadResume extends DownloadManagementEvent{

}