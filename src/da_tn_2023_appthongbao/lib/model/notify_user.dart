class notify_user {
  int? id;
  int? idNotcie;
  int? idUser;
  int? tinhTrang;
 

  notify_user(
      {this.id,
      this.idNotcie,
      this.idUser,
      this.tinhTrang,
    });

  notify_user.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idNotcie = json['id_notcie'];
    idUser = json['id_user'];
    tinhTrang = json['tinh_trang'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_notcie'] = this.idNotcie;
    data['id_user'] = this.idUser;
    data['tinh_trang'] = this.tinhTrang;
    return data;
  }
}