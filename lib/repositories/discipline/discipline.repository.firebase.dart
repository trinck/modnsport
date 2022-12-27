import 'package:modnsport/models/discipline.model.dart';

abstract class DisciplineRepositoryFirebase{

  Future<List<Discipline>> getAll();
  Future<List<Discipline>> getPage([int limit = 30, String? start]);
  Future<void> addDiscipline({required Discipline discipline});
  Future<void> updateDisciplineName({required String oldName, required String newName});
  Future<void> updateDisciplineVerified({required String disciplineName, required bool verified});
  Future<void> addDisciplineActivity ({required  ActivityDiscipline activityDiscipline,required String disciplineName});
  Future<List<ActivityDiscipline>> getDisciplineActivities({required String disciplineName});
  Future<Discipline> getDiscipline({required String disciplineName});
  Future<void> deleteDiscipline({required String disciplineName});
  Future<void> deleteDisciplineActivity({required String disciplineName, required String activityDiscipline});



}