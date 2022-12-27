import 'package:modnsport/utils/fierebase.covertomap.dart';

class Video {
  Metrics? metrics;
  String? title;
  String? uid;
  String? id;
  String? url;
  int? createAt;
  bool? permission;


  Video({this.metrics, this.title, this.uid, this.url});

  Video.fromJson(Map<String, dynamic> json) {
    metrics =  json['metrics'] != null ?  Metrics.fromJson(FirebaseObjectsElementsToMap.objectToMap(json['metrics'] as Map)) : null;
    title = json['title'];
    uid = json['uid'];
    url = json['url'];
    id = json['id'];
    permission = json['permission'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.metrics != null) {
      data['metrics'] = this.metrics!.toJson();
    }
    data['title'] = this.title;
    data['uid'] = this.uid;
    data['url'] = this.url;
    data['id'] = this.id;
    data['permission'] = this.permission;
    data['createAt'] = this.createAt;
    return data;
  }
}

class Metrics {
  int? likes;
  int? shares;
  List<UserMetrics>? users;
  Metrics({this.likes, this.shares, this.users});

  Metrics.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    shares = json['shares'];
    users = json['users'] != null ? List.from(FirebaseObjectsElementsToMap.objectToMap((json['users'] as Map)).entries.map((e) => UserMetrics.fromJson(e.value)).toList()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likes'] = this.likes;
    data['shares'] = this.shares;
    if (this.users != null) {
      data['users'] = this.users!.map((e) => e.toJson());
    }
    return data;
  }
}

class UserMetrics {
  String? uid;
  UserMetrics({this.uid});
  UserMetrics.fromJson(Map<String, dynamic> json) {
    uid = json.entries.first.key;

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
      data['$uid'] = true;
    return data;
  }
}

