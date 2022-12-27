class Chat {
  int? createAt;
  String? id;
  String? lastmessage;

  Chat({ this.id, this.lastmessage});

  Chat.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    id = json['id'];
    lastmessage = json['lastmessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createAt'] = this.createAt;
    data['id'] = this.id;
    data['lastmessage'] = this.lastmessage;
    return data;
  }
}
