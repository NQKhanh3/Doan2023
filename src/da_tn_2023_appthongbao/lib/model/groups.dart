class group{
   int? id;
  int? id_leader;
  String? name;
  group({
    this.id,
    this.id_leader,
    this.name,
    
  });
 group.fromJson(Map<String,dynamic>json){
    id=json['id'];
    id_leader=json['id_leader'];
    name=json['name'];
   
  }
  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data=  Map<String,dynamic>();
    data['id']=this.id;
    data['id_leader']=this.id_leader;
    data['name']=this.name;
 
    return data;
  }
}