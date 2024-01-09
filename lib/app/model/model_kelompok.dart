// To parse this JSON data, do
//
//     final modelKelompok = modelKelompokFromJson(jsonString);

import 'dart:convert';

List<ModelKelompok> modelKelompokFromJson(String str) =>
    List<ModelKelompok>.from(
        json.decode(str).map((x) => ModelKelompok.fromJson(x)));

String modelKelompokToJson(List<ModelKelompok> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelKelompok {
  String? namaKelompok;
  List<String>? data;

  ModelKelompok({
    this.namaKelompok,
    this.data,
  });

  factory ModelKelompok.fromJson(Map<String, dynamic> json) => ModelKelompok(
        namaKelompok: json["nama_kelompok"],
        data: json["data"] == null
            ? []
            : List<String>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nama_kelompok": namaKelompok,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}

///
///
///

List<ModelNamaDanJumlahSetiapKelompok> modelNamaDanJumlahSetiapKelompokFromJson(
        String str) =>
    List<ModelNamaDanJumlahSetiapKelompok>.from(json
        .decode(str)
        .map((x) => ModelNamaDanJumlahSetiapKelompok.fromJson(x)));

String modelNamaDanJumlahSetiapKelompokToJson(
        List<ModelNamaDanJumlahSetiapKelompok> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelNamaDanJumlahSetiapKelompok {
  String? namaKelompok;
  int? jumlahAnggotaKelompok;

  ModelNamaDanJumlahSetiapKelompok({
    this.namaKelompok,
    this.jumlahAnggotaKelompok,
  });

  factory ModelNamaDanJumlahSetiapKelompok.fromJson(
          Map<String, dynamic> json) =>
      ModelNamaDanJumlahSetiapKelompok(
        namaKelompok: json["nama_kelompok"],
        jumlahAnggotaKelompok: json["jumlah_anggota_kelompok"],
      );

  Map<String, dynamic> toJson() => {
        "nama_kelompok": namaKelompok,
        "jumlah_anggota_kelompok": jumlahAnggotaKelompok,
      };
}
