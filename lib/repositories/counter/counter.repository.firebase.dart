import 'dart:async';

import 'package:modnsport/models/activity.model.dart';
import 'package:modnsport/models/counter.model.dart';
import 'package:modnsport/models/programs.model.dart';

abstract class CounterRepositoryFirebase{

  Future<List<CounterModel>> getAll();
  Future<void> createCounter({required CounterModel counterModel});
  Future<void> updateCounterName({required String oldKeyName, required String newName});
  Future<void> updateCounterVerified({required String counterKeyName, required bool verified});
  Future<void> createCounterProgramActivity ({required ActivityCounter activityCounter,required String counterKeyName});
  Future<ActivityCounter> getCounterProgramActivity({required String activityProgramID, required String counterKeyName});
  Future<void> updateCounterProgramActivity({required ActivityCounter activityCounter,required String counterKeyName});
  Future<CounterModel> getCounter({required String counterKeyName});
  Future<void> onCounterActivitiesEvent({required StreamController streamController});



}