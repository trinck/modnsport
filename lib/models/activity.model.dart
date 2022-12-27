class Activity extends Comparable<Activity>{
  String? discipline;
  String? id;
  String? image;
  int? kca;
  String? name;
  String? counterID;

  Activity({required this.discipline, this.id, this.image, this.kca, required this.name});

  Activity.fromJson(Map<String, dynamic> json) {
    discipline = json['discipline'];
    id = json['id'];
    image = json['image'];
    kca = json['kca'];
    name = json['name'];
    counterID = json['counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discipline'] = this.discipline;
    data['id'] = this.id;
    data['image'] = this.image;
    data['kca'] = this.kca;
    data['name'] = this.name;
    data['counterID'] = this.counterID;
    return data;
  }

  @override
  String toString() {
    return "Name: $name, descipline: $discipline, image: $image, kca: $kca, id: $id";
  }

  @override
  int compareTo(Activity other) {
    int result = this.id == other.id? 1: 0;
    return result;
  }
}
