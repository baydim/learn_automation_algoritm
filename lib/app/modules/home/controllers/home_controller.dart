import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:learn_automation_algoritm/app/data/data_names.dart';

import '../../../model/model_kelompok.dart';

class HomeController extends GetxController {
  final jumlahAnggota = 0.obs;

  /// PEMBAGI KELOMPOK OTOMATIS
  final jumlahKelompok = 1.obs;
  final dataFinalKelompok = <ModelKelompok>[].obs;
  final TextEditingController textEditingController = TextEditingController();
  final dataFinalNamaDanJumlahSetiapKelompok =
      <ModelNamaDanJumlahSetiapKelompok>[].obs;
  Future<List<Map<String, dynamic>>> bagiKelompok(
      List<String> namas, int jumlahKelompok) async {
    List<String> nama = [];
    nama.addAll(namas);
    nama.shuffle();
    int namaPerKelompok = (nama.length / jumlahKelompok).ceil();
    List<Map<String, dynamic>> kelompok = [];
    for (int i = 0; i < nama.length; i += namaPerKelompok) {
      int akhir = i + namaPerKelompok;
      if (akhir > nama.length) {
        akhir = nama.length;
      }
      String groupName = 'kelompok ${kelompok.length + 1}';

      kelompok.add({
        'nama_kelompok': groupName,
        'data': nama.sublist(i, akhir),
      });
    }
    return kelompok;
  }

  funcRunBagiKelompok() async {
    List<Map<String, dynamic>> kelompok =
        await bagiKelompok(await names(), jumlahKelompok.value);
    dataFinalKelompok.value = modelKelompokFromJson(
      jsonEncode(kelompok),
    );

    var dataNamaDanJumlahSetiapKelompok = [];

    for (var i in dataFinalKelompok) {
      var anggota = i.data?.length ?? 0;
      dataNamaDanJumlahSetiapKelompok.add({
        "nama_kelompok": i.namaKelompok,
        "jumlah_anggota_kelompok": anggota,
      });
    }

    dataFinalNamaDanJumlahSetiapKelompok.value =
        modelNamaDanJumlahSetiapKelompokFromJson(
      jsonEncode(
        dataNamaDanJumlahSetiapKelompok,
      ),
    );

    // dev.log(
    //   jsonEncode(dataNamaDanJumlahSetiapKelompok),
    // );
  }

  /// PEMBAGI KELOMPOK OTOMATIS

  funcInial() async {
    names().then((value) {
      jumlahAnggota.value = value.length;
      funcRunBagiKelompok();
    });
  }

  @override
  void onInit() {
    funcInial();
    super.onInit();
  }
}
