class group {
  int? id;
  int? idLeader;
  String? name;
  String? createdAt;
  String? updatedAt;

  group({this.id, this.idLeader, this.name, this.createdAt, this.updatedAt});

  group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idLeader = json['id_leader'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_leader'] = this.idLeader;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}