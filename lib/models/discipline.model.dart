import 'package:modnsport/utils/fierebase.covertomap.dart';

class Discipline {
  List<ActivityDiscipline>? activities;
  String? name;
  bool? verified;

  Discipline({required this.name, this.activities, this.verified});

  Discipline.fromJson(Map<String, dynamic> json) {
    activities = json['activities'] != null
        ? List.from(FirebaseObjectsElementsToMap.objectToMap(json['activities']).entries.map((e) => ActivityDiscipline.fromJson(e)).toList())
        : null ;
    name = json['name'];
    verified = json['verified'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.activities != null) {
      data['activities'] = this.activities!.map((e) => e.toJson()) as Map<String,dynamic>;
    }
    data['name'] = this.name;
    return data;
  }



}

class ActivityDiscipline {
  String? activityID;

  ActivityDiscipline({this.activityID});

  ActivityDiscipline.fromJson(MapEntry<dynamic, dynamic> json) {
    activityID = json.key;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['$activityID'] = true;
    return data;
  }
}
