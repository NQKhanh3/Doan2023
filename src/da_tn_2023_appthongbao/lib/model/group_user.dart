class group_user {
  int? id;
  int? idGroup;
  int? idUser;
  String? vaiTro;
  int? trangThai;

  group_user({this.id, this.idGroup, this.idUser, this.vaiTro, this.trangThai});

  group_user.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idGroup = json['id_group'];
    idUser = json['id_user'];
    vaiTro = json['vai_tro'];
    trangThai = json['trang_thai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_group'] = this.idGroup;
    data['id_user'] = this.idUser;
    data['vai_tro'] = this.vaiTro;
    data['trang_thai'] = this.trangThai;
    return data;
  }
}