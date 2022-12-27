import 'package:modnsport/utils/fierebase.covertomap.dart';
class UserModel {
  String? displayname;
  int? height;
  int? lastOnline;
  String? uid;
  String? photoUrl;
  int? weight;
  String? email;
  Map<String, bool>? programs;
  Map<String, bool>? connexions;
  List<Rdm>? rdm;
  List<Dm>? dm;
  List<Follower>? followers;

  UserModel({this.displayname, this.height, this.lastOnline, this.uid, this.weight, this.email, this.photoUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    displayname = json['displayname'];
    height = json['height'];
    lastOnline = json['lastOnline'];
    uid = json['uid'];
    photoUrl = json['photoUrl'];
    email = json['email'];
    weight = json['weight'];
    programs = json["programs"];
    connexions = json["connexions"];
    followers = json["followers"]!=null? FirebaseObjectsElementsToMap.objetsToMap(json["followers"]).entries.map((e) => Follower.fromJson(e.value)).toList():null;
    rdm = json["rdm"]!=null? FirebaseObjectsElementsToMap.objetsToMap(json["rdm"]).entries.map((e) => Rdm.fromJson(e.value)).toList():null;
    dm = json["dm"]!=null? FirebaseObjectsElementsToMap.objetsToMap(json["dm"]).entries.map((e) => Dm.fromJson(e.value)).toList():null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayname'] = this.displayname ;
    data['height'] = this.height;
    data['lastOnline'] = this.lastOnline ;
    data['uid'] = this.uid;
    data['weight'] = this.weight ;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['rdm'] = this.rdm?.map((e) => {e.senderUid: e.toJson()});
    return data;
  }
}


class Rdm {
  String? chatID;
  int? createAt;
  String? senderUid;

  Rdm({ this.chatID, this.createAt, this.senderUid});

  Rdm.fromJson(Map<String, dynamic> json) {

    chatID = json['chatID'];
    createAt = json['createAt'];
    senderUid = json['senderUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['chatID'] = this.chatID;
    data['createAt'] = this.createAt;
    data['senderUid'] = this.senderUid;
    return data;
  }
}



class Dm {
  String? chatID;
  int? createAt;
  String? targetUid;

  Dm({ this.chatID, this.createAt, this.targetUid});

  Dm.fromJson(Map<String, dynamic> json) {

    chatID = json['chatID'];
    createAt = json['createAt'];
    targetUid = json['targetUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['chatID'] = this.chatID;
    data['createAt'] = this.createAt;
    data['targetUid'] = this.targetUid;
    return data;
  }
}


class Follower{

  String? chatID;
  String? followerUid;

  Follower({ this.chatID,  this.followerUid});

  Follower.fromJson(Map<String, dynamic> json) {
  chatID = json['chatID'];
  followerUid = json['followerUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

  data['chatID'] = this.chatID;
  data['followerUid'] = this.followerUid;
  return data;
  }



}