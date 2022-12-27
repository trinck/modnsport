import 'package:modnsport/utils/fierebase.covertomap.dart';

class Programs {
  int? duree;
  String? infos;
  String? id;
  List<ProgramsActivity>? activities;
  int? pause;
  String? title;
  int? createAt;
  List<ProgramsImages>? images;
  List<ProgramsFollower>? followers;
  String? authorID;


  Programs({this.duree, this.infos, this.pause, this.title, this.images});

  Programs.fromJson(Map<String, dynamic> json) {
    duree = json['duree'];
    authorID = json['authorID'];
    createAt = json['createAt'];
    infos = json['infos'];
    pause = json['pause'];
    title = json['title'];
    id = json['id'];

    this.images = json['images']!= null? FirebaseObjectsElementsToMap.objetsToMap(json["images"]).entries.map((e) => ProgramsImages.fromJson(e.value)).toList():null;
    this.followers = json['followers']!= null? List.from((json['followers']as Map).entries.map((e) => ProgramsFollower.fromJson(e ))):null;
    this.activities = json['activities']!= null? FirebaseObjectsElementsToMap.objetsToMap(json["activities"]).entries.map((e) => ProgramsActivity.fromJson(e.value)).toList():null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duree'] = this.duree;
    data['infos'] = this.infos;
    data['authorID'] = this.authorID;
    data['pause'] = this.pause;
    data['title'] = this.title;
    data['createAt'] = this.createAt;
    data['images'] = this.images!.map((e) => {e.id:e.toJson()});
    data['followers'] = this.followers!.map((e) => e.toJson());
    data['activities'] = this.activities!.map((e) => {e.id:e.toJson()});
    return data;
  }


}
class ProgramsActivity{

  String? counterID;
  String? id;
  String? activityID;
  ProgramsActivity({required this.counterID});
  ProgramsActivity.fromJson(Map<String, dynamic> json){
    counterID = json['counterID'];
    id = json['id'];
    activityID = json["activityID"];

  }

  Map<String,dynamic> toJson()
  {
    final data = <String, dynamic>{};
    data['counterID'] = this.counterID;
    data['id'] = this.id;
    data["activityID"] = this.activityID;
    return data;
  }


}


class ProgramsFollower{

  String? uid;
  ProgramsFollower({required this.uid});
  ProgramsFollower.fromJson(MapEntry<dynamic, dynamic> json){
    uid = json.key;

  }

  Map<String,dynamic> toJson()
  {
    final data = <String, dynamic>{};
    data['$uid'] = true;
    return data;
  }
}


class ProgramsImages{

  String? url;
  String? id;
  String? title;

  ProgramsImages({required this.url, required this.title});
  ProgramsImages.fromJson(Map<String, dynamic> json){
    url = json['url'];
    title = json['title'];
    id = json['id'];
  }

  Map<String,dynamic> toJson()
  {
    final data = <String, dynamic>{};
    data['url'] = this.url;
    data['title'] = this.title;
    data['id'] = this.id;
    return data;
  }


}



class UserProgramsActivity{

  String? counterStep;
  String? id;
  String? step;
  int? start;
  String? activityID;
  UserProgramsActivity({this.id, this.step, this.activityID, this.counterStep, this.start});
  UserProgramsActivity.fromJson(Map<String, dynamic> json){
    
    id = json['id'];
    activityID = json["activityID"];
    counterStep = json["counterStep"];
    start = json["start"];
    step = json["step"];

  }

  Map<String,dynamic> toJson()
  {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data["activityID"] = this.activityID;
    data["counterStep"] = this.counterStep;
    data["step"] = this.step;
    data["start"] = this.start;
    return data;
  }


}
