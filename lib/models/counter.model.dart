import 'package:modnsport/utils/fierebase.covertomap.dart';

class CounterModel {
  List<ActivityCounter>? activities;
  String? keyname;
  bool? verified;

  CounterModel({this.keyname, this.verified});

  CounterModel.fromJson(Map<String, dynamic> json) {
    activities = json['activities'] != null
        ? List.from(FirebaseObjectsElementsToMap.objetsToMap(json['activities']).entries.map((e) => ActivityCounter.fromJson(e.value)).toList())
        : null ;
    keyname = json['keyname'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.activities != null) {
      data['activities'] = this.activities!.map((e) => {e.id: e.toJson()}) as Map<String,dynamic>;
    }
    data['keyname'] = this.keyname;
    data['verified'] = this.verified;
    return data;
  }



}

class ActivityCounter {
  int? step;
  String? id;

  ActivityCounter({this.step, this.id});

  ActivityCounter.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['step'] = this.step;
    data["id"] = this.id;
    return data;
  }
}
