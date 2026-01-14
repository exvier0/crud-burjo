import 'package:flutter/material.dart';

// --- IMPORT SEMUA HALAMAN ---
import 'beranda.dart';
import 'menu_page.dart';
import 'login.dart';
import 'pembayaran_page.dart';
import 'status_pemesanan_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // List halaman ditaruh di dalam build agar data Provider di dalamnya bisa refresh
    final List<Widget> _pages = [
      const Beranda(),
      const MenuPage(), 
      const PembayaranPage(totalHarga: 0, items: ""),
      const StatusPesananPage(),
    ];

    return Scaffold(
      // Menggunakan IndexedStack agar status scroll di menu tidak hilang
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          if (value == 4) {
            // Logika Logout
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          } else {
            setState(() => _index = value);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Beranda"),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: "Menu",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Bayar"),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Status",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.red),
            label: "Logout",
          ),
        ],
      ),
    );
  }
}
