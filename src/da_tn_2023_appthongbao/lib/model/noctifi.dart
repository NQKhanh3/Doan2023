class noctifiModel {
  int? id;
  int? idGroup;
  String? tieuDe;
  String? noiDung;
  int? mauSac;
  String? ngay;
  String? time;
  String? lapLai;
  String? createdAt;
  String? updatedAt;

  noctifiModel(
      {
      this.id,
        this.idGroup,
      this.tieuDe,
      this.noiDung,
      this.mauSac,
      this.ngay,
      this.time,
      this.lapLai,
      this.createdAt,
      this.updatedAt});

  noctifiModel.fromJson(Map<String, dynamic> json) {
     id = json['id'];
    idGroup = json['id_group'];
    tieuDe = json['tieu_de'];
    noiDung = json['noi_dung'];
    mauSac = json['mau_sac'];
    ngay = json['ngay'];
    time = json['time'];
    lapLai = json['lap_lai'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_group'] = this.idGroup;
    data['tieu_de'] = this.tieuDe;
    data['noi_dung'] = this.noiDung;
    data['mau_sac'] = this.mauSac;
    data['ngay'] = this.ngay;
    data['time'] = this.time;
    data['lap_lai'] = this.lapLai;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}