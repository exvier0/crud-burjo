import 'package:flutter/material.dart';

class Pesanan {
  final String id;
  final String items;
  final int totalHarga;
  final String status;
  final DateTime waktu;

  Pesanan({
    required this.id,
    required this.items,
    required this.totalHarga,
    required this.status,
    required this.waktu,
  });
}

class PesananProvider extends ChangeNotifier {
  final List<Pesanan> _riwayat = [
    Pesanan(
      id: "ORD-SAMPLE01",
      items: "Nasi Magelangan (1x), Es Teh (1x)",
      totalHarga: 15000,
      status: "Selesai",
      waktu: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  List<Pesanan> get riwayat => _riwayat;

  void tambahPesanan(String items, int total) {
    _riwayat.insert(
      0,
      Pesanan(
        id: "ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
        items: items,
        totalHarga: total,
        status: "Sedang Dimasak",
        waktu: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
