import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PembayaranPage extends StatefulWidget {
  final int totalHarga;
  final String items;

  const PembayaranPage({
    super.key,
    required this.totalHarga,
    required this.items,
  });

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  int _selectedPaymentIndex = -1;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'title': 'Cash / Tunai',
      'subtitle': 'Bayar di kasir',
      'icon': Icons.money,
      'color': Colors.green,
    },
    {
      'title': 'QRIS',
      'subtitle': 'Scan cepat',
      'icon': Icons.qr_code_2,
      'color': Colors.black,
    },
    {
      'title': 'E-Wallet',
      'subtitle': 'Dana / Gopay',
      'icon': Icons.account_balance_wallet,
      'color': Colors.blue,
    },
  ];

  Future<void> _processPayment() async {
    if (_selectedPaymentIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pilih metode pembayaran dulu!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String metode = _paymentMethods[_selectedPaymentIndex]['title'];
    String noHp = "628123456789";
    String pesan =
        "Halo Burjo! Order: ${widget.items}\nTotal: Rp ${widget.totalHarga}\nVia: $metode";

    final Uri url = Uri.parse(
      "https://wa.me/$noHp?text=${Uri.encodeComponent(pesan)}",
    );

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Gagal buka WA');
      }
    } catch (e) {
      debugPrint("Error WA: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.totalHarga == 0) {
      return Scaffold(
        appBar: AppBar(title: const Text("Pemesanan")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 20),
              const Text("Belum ada pesanan aktif"),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: Column(
        children: [
          ListTile(
            title: const Text("Total Tagihan"),
            subtitle: Text(
              "Rp ${widget.totalHarga}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _paymentMethods.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = _paymentMethods[index];
                return ListTile(
                  leading: Icon(item['icon'], color: item['color']),
                  title: Text(item['title']),
                  trailing: _selectedPaymentIndex == index
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () => setState(() => _selectedPaymentIndex = index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  "Pesan via WhatsApp",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
