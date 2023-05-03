import 'dart:convert';

class HomeModel {
  String? nama;
  String? email;
  String? nohp;

  HomeModel({this.nama, this.email, this.nohp});

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
      "email": email,
      "nohp": nohp,
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      nama: map[" nama"],
      email: map[" email"],
      nohp: map[" nohp"],
    );
  }

  String toJson() => json.encode(toMap());
}
