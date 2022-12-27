class StatsModel{
  String? date;
  String? id;
  String? name;
  int? kca;
  int? kcaDone;

  StatsModel({this.date,this.name,this.id,this.kca});
 StatsModel.fromJson(Map<String,dynamic>json){
   this.kca = json["kca"];
   this.id = json["id"];
   this.name = json["name"];
   this.date = json["date"];
   this.kcaDone = json["kcaDone"];
 }
  Map<String,dynamic> toJson(){
   Map<String, dynamic> data = <String,dynamic>{};
   data["kca"] = this.kca;
   data["id"] = this.id;
   data["name"] = this.name;
   data["date"] = this.date;
   data["kcaDone"] = this.kcaDone;

   return data;

  }

}