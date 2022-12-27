import 'dart:async';

import 'package:modnsport/blocs/programs/programs.event.dart';
import 'package:modnsport/models/activity.model.dart';
import 'package:modnsport/models/programs.model.dart';

abstract class ProgramsRepositoryFirebase{


  Future<List<Programs>> getPage([int limit = 30, String? start]);
  Future<List<Programs>> getAll();
  Future<void> createProgram ({required Programs programs});
  Future<void> followProgram ({required String programID});
  Future<void> subscribeOtherToProgram ({required String programID,required String uid});
  Future<void> unSubscribeOtherToProgram ({required String programID, required String uid});
  Future<void> unFollowProgram ({required String programID});
  Future<void> progressOnProgram ({required String programID,required Stream<int> stream, required UserProgramsActivity activity});
  Future<Programs> getProgram({required String programID});
  Future<UserProgramsActivity> getUserProgramActivity({required String programID,required String uid, required String activityID});
  Future<void> updateProgram({required Programs program});
  Future<void> updateProgramInfos({required Programs program});
  Future<void> updateProgramDuree({required Programs program});
  Future<void> updateProgramTitle({required Programs program});
  Future<void> deletePrograms({required String programID});
  Future<void> updateProgramsImages({required Programs program});
  Future<void> updateProgramsFollowers({required Programs program});
  Future<void> updateProgramsActivities({required Programs program});
  Future<void> deleteProgramsActivity({required String programID, required String activityID});
  Future<void> addProgramsActivity({required String programID, required ProgramsActivity activity});
  Future<void> addProgramsImage({required String programID, required ProgramsImages image});
  Future<void> deleteProgramsImage({required String programID, required String imageID});
  Future<void> updateProgramsActivity({required Programs program, required String activityID});
  Future<void> onProgramsEvent({required StreamController<OnProgramsEvent> streamController});
  Future<void> onValue({required String childIdField, required StreamController streamController});

}