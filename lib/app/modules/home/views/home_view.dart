import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var debouce = Debouncer(
      delay: const Duration(milliseconds: 800),
    );
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Kelompok",
                            ),
                            controller: controller.textEditingController,
                            onChanged: (v) {
                              if (v.isNumericOnly) {
                                debouce.call(
                                  () {
                                    controller.jumlahKelompok.value = int.parse(
                                      controller.textEditingController.text,
                                    );
                                    controller.funcRunBagiKelompok();
                                  },
                                );
                              } else {
                                controller.jumlahKelompok.value = 1;
                                controller.funcRunBagiKelompok();
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Anggota yang masuk",
                            ),
                            controller: controller.anggotaController,
                            onChanged: (v) {
                              if (v.isNumericOnly) {
                                debouce.call(
                                  () {
                                    controller.jumlahAnggota.value =
                                        int.parse(v);
                                    controller.funcRunBagiKelompok();
                                  },
                                );
                              } else {
                                controller.funcRunBagiKelompok();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Total Anggota : ${controller.jumlahAnggota.value}",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Jumlah Kelompok : ${controller.dataFinalKelompok.length}",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: PageView(
                  children: [
                    for (var i = 0;
                        i <
                            controller
                                .dataFinalNamaDanJumlahSetiapKelompok.length;
                        i++)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Text(controller
                                        .dataFinalNamaDanJumlahSetiapKelompok[i]
                                        .namaKelompok ??
                                    "--"),
                                const SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "Anggota : ${controller.dataFinalNamaDanJumlahSetiapKelompok[i].jumlahAnggotaKelompok ?? "0"}",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                for (var j
                                    in controller.dataFinalKelompok[i].data ??
                                        <String>[])
                                  ListTile(
                                    title: Text(
                                      j,
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
