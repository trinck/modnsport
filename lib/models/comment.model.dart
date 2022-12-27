class CommentModel {
  String? body;
  int? createAt;
  String? sender;
  String? id;

  CommentModel({this.body, this.createAt, this.sender});
  CommentModel.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    createAt = json['createAt'];
    sender = json['sender'];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['createAt'] = this.createAt;
    data['sender'] = this.sender;
    data["id"] = this.id;
    return data;
  }
}
