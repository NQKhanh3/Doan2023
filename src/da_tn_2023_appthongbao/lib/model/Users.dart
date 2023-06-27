class users{
  int? id;
  String? email;
  
  int? vai_tro_id;
  int? google_id;
  String? password;
  String? username;
  String? anh_dai_dien;
   int? bi_khoa;
 
 
 
  users({
    this.id,
    this.email,
    this.password,
    this.vai_tro_id,
    this.google_id,
    this.username,
    this.anh_dai_dien,
    this.bi_khoa,
    
  });
 users.fromJson(Map<String,dynamic>json){
    id=json['id'];
    email=json['email'];
    password=json['password'];
    vai_tro_id=json['vai_tro_id'];
    google_id=json['google_id'];
    username=json['username'];
    anh_dai_dien=json['anh_dai_dien'];
    bi_khoa=json['bi_khoa'];
   
  }
  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data=  Map<String,dynamic>();
    data['id']=this.id;
    data['email']=this.email;
    data['password']=this.password;
    data['vai_tro_id']=this.vai_tro_id;
    data['google_id']=this.google_id;
    data['username']=this.username;
    data['anh_dai_dien']=this.anh_dai_dien;
    data['bi_khoa']=this.bi_khoa;
    return data;
  }
}