class Ebced{
  int? id;
  String? head;
  String? name;
  String? calculatedTime;

  Ebced({
    required this.head,
    required this.name,
    required this.calculatedTime,
  });
  Ebced.withId({
    required this.id,
    required this.head,
    required this.name,
    required this.calculatedTime,
  });

  Map<String,dynamic>? toMap(){
    var map = new Map<String,dynamic>();
    map["head"]=head;
    map["name"]=name;
    map["calculatedTime"]=calculatedTime;
    if(id!=null){
      map["id"]=id;
    }
    return map;
  }

  Ebced.fromObject(dynamic o){
    this.id = o["id"];
    this.head = o["head"];
    this.name = o["name"];
    this.calculatedTime = o["calculatedTime"];
  }
}