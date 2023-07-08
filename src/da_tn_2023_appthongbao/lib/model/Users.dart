class userModel {
  int? id;
  String? username;
  String? password;
  String? email;
  String? hinhDaiDien;
  String? googleId;
  int? biKhoa;
  String? createdAt;
  String? updatedAt;

  userModel(
      {this.id,
      this.username,
      this.password,
      this.email,
      this.hinhDaiDien,
      this.googleId,
      this.biKhoa,
      this.createdAt,
      this.updatedAt});

  userModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    hinhDaiDien = json['hinh_dai_dien'];
    googleId = json['google_id'];
    biKhoa = json['bi_khoa'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data']['id'] = this.id;
    data['data']['username'] = this.username;
    data['data']['password'] = this.password;
    data['data']['email'] = this.email;
    data['data']['hinh_dai_dien'] = this.hinhDaiDien;
    data['data']['google_id'] = this.googleId;
    data['data']['bi_khoa'] = this.biKhoa;
    data['data']['created_at'] = this.createdAt;
    data['data']['updated_at'] = this.updatedAt;
    return data;
  }
}