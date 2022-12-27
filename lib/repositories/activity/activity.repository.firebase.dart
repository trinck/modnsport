import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modnsport/blocs/activity/activity.event.dart';
import 'package:modnsport/blocs/home/home.event.dart';
import 'package:modnsport/models/activity.model.dart';

abstract class ActivityRepositoryFirebase
{


  Future<List<Activity>> getPage([int limit = 30, String? start]);
  Future<List<Activity>> getAll();
  Future<void> createActivity ({required Activity activity});
  Future<Activity> getActivity({required String activityID});
  Future<void> updateActivity({required Activity activity});
  Future<void> deleteActivity({required Activity activity});
  Future<void> onActivityEvent({required StreamController<OnActivityEvent> streamController});
  Future<void> onValue({required String childIdField, required StreamController streamController});


  
}