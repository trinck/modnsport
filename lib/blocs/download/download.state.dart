import 'package:firebase_storage/firebase_storage.dart';

abstract class DownloadManagementState{}

class DownloadRunning extends DownloadManagementState{
  DownloadTask task;
  int progress;
  DownloadRunning({required this.task, required this.progress});
}

class DownloadSuccess extends DownloadManagementState{
  DownloadTask task;
  int progress;
  DownloadSuccess({required this.task, required this.progress});
}

class DownloadPaused extends DownloadManagementState{
  DownloadTask task;
  int progress;
  DownloadPaused({required this.task, required this.progress});
}

class DownloadCanceled extends DownloadManagementState{
  DownloadTask task;
  int progress;
  DownloadCanceled({required this.task, required this.progress});
}
class DownloadError extends DownloadManagementState{
  DownloadTask task;
  int progress;
  String? error;
  DownloadError({required this.task, required this.progress, this.error});
}