import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_providers.dart';
import '../providers/pesanan_providers.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  // FUNGSI UTAMA: Menghubungkan Cart ke Pesanan
  void _prosesPesanan(BuildContext context, CartProvider cart) {
    if (cart.items.isEmpty) return;

    int totalHarga = cart.totalHarga;

    // Membuat ringkasan teks untuk riwayat pesanan
    String ringkasanItems = cart.items
        .map((item) => "${item['menu'].nama} (${item['quantity']}x)")
        .join(", ");

    // 1. KIRIM KE PESANAN PROVIDER
    Provider.of<PesananProvider>(
      context,
      listen: false,
    ).tambahPesanan(ringkasanItems, totalHarga);

    // 2. BERSIHKAN KERANJANG
    cart.clearCart();

    // 3. Notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Pesanan berhasil dikirim ke dapur!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Jangan pakai Navigator.pop jika halaman ini adalah bagian dari Tab Navbar
    // Jika ini halaman mandiri (push), pop boleh dipakai.
  }

  @override
  Widget build(BuildContext context) {
    // Pakai Consumer agar lebih efisien dalam mendengarkan perubahan data
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Keranjang"),
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
          ),
          bottomNavigationBar: cart.items.isEmpty
              ? null
              : Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Bayar:",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Rp ${cart.totalHarga}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _prosesPesanan(context, cart),
                        child: const Text("PESAN SEKARANG"),
                      ),
                    ],
                  ),
                ),
          body: cart.items.isEmpty
              ? const Center(child: Text("Keranjang masih kosong nih..."))
              : ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      leading: const Icon(Icons.fastfood, color: Colors.brown),
                      title: Text("${item['menu'].nama}"),
                      subtitle: Text(
                        "Rp ${item['menu'].harga} x ${item['quantity']}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red,
                            ),
                            onPressed: () => cart.updateQuantity(
                              index,
                              item['quantity'] - 1,
                            ),
                          ),
                          Text(
                            "${item['quantity']}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.green,
                            ),
                            onPressed: () => cart.updateQuantity(
                              index,
                              item['quantity'] + 1,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                cart.removeItem(index), // SUDAH DIPERBAIKI
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
