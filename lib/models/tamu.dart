// To parse this JSON data, do
//
//     final tamus = tamusFromJson(jsonString);

import 'dart:convert';

List<Tamus> tamusFromJson(String str) =>
    List<Tamus>.from(json.decode(str).map((x) => Tamus.fromJson(x)));

String tamusToJson(List<Tamus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tamus {
  int id;
  String kodeTamu;
  String namaTamu;
  String alamatTamu;
  String noTelpon;
  DateTime createdAt;
  DateTime updatedAt;

  Tamus({
    required this.id,
    required this.kodeTamu,
    required this.namaTamu,
    required this.alamatTamu,
    required this.noTelpon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tamus.fromJson(Map<String, dynamic> json) => Tamus(
        id: json["id"],
        kodeTamu: json["kode_tamu"],
        namaTamu: json["nama_tamu"],
        alamatTamu: json["alamat_tamu"],
        noTelpon: json["no_telpon"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_tamu": kodeTamu,
        "nama_tamu": namaTamu,
        "alamat_tamu": alamatTamu,
        "no_telpon": noTelpon,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
